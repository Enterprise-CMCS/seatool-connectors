import { send, SUCCESS, FAILED } from "cfn-response-async";
var fs = require("fs");
import archiver from "archiver";
import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";
exports.handler = async function (event, context) {
  console.log("Request:", JSON.stringify(event, undefined, 2));
  const responseData = {};
  let responseStatus = SUCCESS;
  try {
    console.log("mike");
    console.log(event.ResourceProperties.LayerVersion);
    if (event.RequestType === "Create" || event.RequestType == "Update") {
      let outFileName = `${context.awsRequestId}.zip`;
      let outFile = `/tmp/${outFileName}`;
      await zipDirectory("/opt", outFile);
      await uploadToS3(
        event.ResourceProperties.DdlBucket,
        `${context.awsRequestId}.zip`,
        fs.readFileSync(outFile)
      );
      responseData.S3Key = `${context.awsRequestId}.zip`;
      console.log(responseData);
    } else if (event.RequestType === "Delete") {
      console.log("This resource does nothing on Delete events.");
    }
  } catch (error) {
    console.error(error);
    responseStatus = FAILED;
  } finally {
    await send(event, context, responseStatus, responseData, "static");
  }
};

function zipDirectory(sourceDirectoryPath, targetFilePath) {
  return new Promise((resolve, reject) => {
    const output = fs.createWriteStream(targetFilePath);
    const archive = archiver("zip", { zlib: { level: 9 } });

    output.on("close", function () {
      console.log(`Zip archive created: ${archive.pointer()} total bytes`);
      resolve();
    });

    archive.on("error", function (err) {
      reject(err);
    });

    archive.pipe(output);

    archive.directory(sourceDirectoryPath, false);

    archive.finalize();
  });
}

async function uploadToS3(s3Bucket, s3Key, body) {
  const s3 = new S3Client({});
  try {
    console.log(`Uploading ${s3Key} to ${s3Bucket}`);
    await s3.send(
      new PutObjectCommand({
        Bucket: s3Bucket,
        Key: s3Key,
        Body: body,
      })
    );
  } catch (err) {
    console.error(err, err.stack);
  }
}
