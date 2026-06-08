import yargs from "yargs";
import * as dotenv from "dotenv";
import LabeledProcessRunner from "./runner.js";
import * as fs from "fs";
import { ServerlessStageDestroyer } from "@stratiformdigital/serverless-stage-destroyer";
import { ServerlessRunningStages } from "@enterprise-cmcs/macpro-serverless-running-stages";
import { SecurityHubJiraSync } from "@enterprise-cmcs/macpro-security-hub-sync";

// load .env
dotenv.config();

const runner = new LabeledProcessRunner();

function touch(file: string) {
  try {
    const time = new Date();
    fs.utimesSync(file, time, time);
  } catch (err) {
    fs.closeSync(fs.openSync(file, "w"));
  }
}

async function frozenInstall(runner: LabeledProcessRunner, dir: string) {
  await runner.run_command_and_output(
    `${dir.split("/").slice(-1)} deps`,
    ["yarn", "install", "--frozen-lockfile"],
    dir
  );
}

async function install(runner: LabeledProcessRunner, dir: string) {
  await runner.run_command_and_output(
    `${dir.split("/").slice(-1)} deps`,
    ["yarn", "install"],
    dir
  );
}

async function install_deps(runner: LabeledProcessRunner, dir: string) {
  const lockfile = `${dir}/yarn.lock`;
  const marker = `${dir}/.yarn_install`;
  const packageJson = `${dir}/package.json`;
  const hasLockfile = fs.existsSync(lockfile);
  const changedSinceLastInstall = !fs.existsSync(marker)
    ? true
    : hasLockfile
      ? fs.statSync(marker).ctimeMs < fs.statSync(lockfile).ctimeMs
      : fs.statSync(marker).ctimeMs < fs.statSync(packageJson).ctimeMs;

  if (process.env.CI == "true") {
    if (!fs.existsSync(`${dir}/node_modules`)) {
      if (hasLockfile) {
        await frozenInstall(runner, dir);
      } else {
        await install(runner, dir);
      }
    }
  } else {
    if (changedSinceLastInstall) {
      if (hasLockfile) {
        await frozenInstall(runner, dir);
      } else {
        await install(runner, dir);
      }
      touch(marker);
    }
  }
}

async function install_deps_for_services() {
  var services = getDirectories("src/services");
  for (let service of services) {
    await install_deps(runner, `src/services/${service}`);
  }
  await install_deps(runner, "src/libs");
}

function getDirectories(path: string) {
  return fs.readdirSync(path).filter(function (file) {
    return fs.statSync(path + "/" + file).isDirectory();
  });
}

async function refreshOutputs(stage: string) {
  await runner.run_command_and_output(
    `SLS Refresh Outputs`,
    ["./node_modules/.bin/sls", "refresh-outputs", "--stage", stage],
    ".",
    true
  );
}

yargs(process.argv.slice(2))
  .command("install", "install all service dependencies", {}, async () => {
    await install_deps_for_services();
  })
  .command(
    "deploy",
    "deploy the project",
    {
      stage: { type: "string", demandOption: true },
      service: { type: "string", demandOption: false },
    },
    async (options) => {
      await install_deps_for_services();
      var deployCmd = [
        "./node_modules/.bin/sls",
        "deploy",
        "--stage",
        options.stage,
      ];
      if (options.service) {
        await refreshOutputs(options.stage);
        deployCmd = [
          "./node_modules/.bin/sls",
          options.service,
          "deploy",
          "--stage",
          options.stage,
        ];
      }
      await runner.run_command_and_output(`SLS Deploy`, deployCmd, ".");
    }
  )
  .command(
    "destroy",
    "destroy a stage in AWS",
    {
      stage: { type: "string", demandOption: true },
      service: { type: "string", demandOption: false },
      wait: { type: "boolean", demandOption: false, default: true },
      verify: { type: "boolean", demandOption: false, default: true },
    },
    async (options) => {
      let destroyer = new ServerlessStageDestroyer();
      let filters = [
        {
          Key: "PROJECT",
          Value: `${process.env.PROJECT}`,
        },
      ];
      if (options.service) {
        filters.push({
          Key: "SERVICE",
          Value: `${options.service}`,
        });
      }
      await destroyer.destroy(`${process.env.REGION_A}`, options.stage, {
        wait: options.wait,
        filters: filters,
        verify: options.verify,
      });
    }
  )
  .command(
    "connect",
    "Prints a connection string that can be run to 'ssh' directly onto the ECS Fargate task",
    {
      stage: { type: "string", demandOption: true },
      service: { type: "string", demandOption: true },
    },
    async (options) => {
      await install_deps_for_services();
      await refreshOutputs(options.stage);
      await runner.run_command_and_output(
        `SLS connect`,
        [
          "./node_modules/.bin/sls",
          options.service,
          "connect",
          "--stage",
          options.stage,
        ],
        "."
      );
    }
  )
  .command(
    ["listRunningStages", "runningEnvs", "listRunningEnvs"],
    "Reports on running environments in your currently connected AWS account.",
    {},
    async () => {
      await install_deps_for_services();
      for (const region of [process.env.REGION_A]) {
        const runningStages =
          await ServerlessRunningStages.getAllStagesForRegion(region!);
        console.log(`runningStages=${runningStages.join(",")}`);
      }
    }
  )
  .command(
    "base-update",
    "this will update your code to the latest version of the base template",
    {},
    async () => {
      const addRemoteCommand = [
        "git",
        "remote",
        "add",
        "base",
        "https://github.com/Enterprise-CMCS/macpro-base-template",
      ];

      await runner.run_command_and_output(
        "Update from Base | adding remote",
        addRemoteCommand,
        ".",
        true,
        {
          stderr: true,
          close: true,
        }
      );

      const fetchBaseCommand = ["git", "fetch", "base"];

      await runner.run_command_and_output(
        "Update from Base | fetching base template",
        fetchBaseCommand,
        "."
      );

      const mergeCommand = ["git", "merge", "base/production", "--no-ff"];

      await runner.run_command_and_output(
        "Update from Base | merging code from base template",
        mergeCommand,
        ".",
        true
      );

      console.log(
        "Merge command was performed. You may have conflicts. This is normal behaivor. To complete the update process fix any conflicts, commit, push, and open a PR."
      );
    }
  )
  .command(
    ["listRunningStages", "runningEnvs", "listRunningEnvs"],
    "Reports on running environments in your currently connected AWS account.",
    {},
    async () => {
      await install_deps_for_services();
      for (const region of [process.env.REGION_A]) {
        const runningStages =
          await ServerlessRunningStages.getAllStagesForRegion(region!);
        console.log(`runningStages=${runningStages.join(",")}`);
      }
    }
  )
  .command(
    ["securityHubJiraSync", "securityHubSync", "secHubSync"],
    "Create Jira Issues for Security Hub findings.",
    {},
    async () => {
      await install_deps_for_services();
      await new SecurityHubJiraSync({
        customJiraFields: {
          customfield_14117: [{ value: "Platform Team" }],
          customfield_14151: [{ value: "Not Applicable " }],
          customfield_14068:
            "* All findings of this type are resolved or suppressed, indicated by a Workflow Status of Resolved or Suppressed.  (Note:  this ticket will automatically close when the AC is met.)",
        },
      }).sync();
    }
  )
  .strict() // This errors and prints help if you pass an unknown command
  .scriptName("run") // This modifies the displayed help menu to show 'run' isntead of 'dev.js'
  .demandCommand(1, "").argv; // this prints out the help if you don't call a subcommand
