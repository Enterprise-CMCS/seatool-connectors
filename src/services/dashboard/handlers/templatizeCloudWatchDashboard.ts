import { CloudWatch } from "@aws-sdk/client-cloudwatch";
import type {
  APIGatewayEvent,
  APIGatewayProxyCallback,
  Context,
} from "aws-lambda";

type DashboardTemplateInputs = {
  accountId: string;
  region: string;
  service: string;
  stage: string;
};

type CloudWatchDashboardClient = Pick<CloudWatch, "getDashboard">;

export function templatizeDashboardBody(
  dashboardBody: string,
  { accountId, region, service, stage }: DashboardTemplateInputs
) {
  return dashboardBody
    .replaceAll(accountId, "${aws:accountId}")
    .replaceAll(stage, "${sls:stage}")
    .replaceAll(region, "${env:REGION_A}")
    .replaceAll(service, "${self:service}");
}

export async function getTemplatizedDashboard(
  inputs: DashboardTemplateInputs,
  client: CloudWatchDashboardClient = new CloudWatch({})
) {
  const dashboard = await client.getDashboard({
    DashboardName: `${inputs.service}-${inputs.stage}`,
  });

  return templatizeDashboardBody(dashboard.DashboardBody!, inputs);
}

export const handler = async (
  _event: APIGatewayEvent,
  _context: Context,
  _callback: APIGatewayProxyCallback
) => {
  //environment variables passed to lambda from serverless.yml
  const service = process.env.service!;
  const accountId = process.env.accountId!;
  const stage = process.env.stage!;
  const region = process.env.region!;

  return getTemplatizedDashboard({
    accountId,
    region,
    service,
    stage,
  });
};
