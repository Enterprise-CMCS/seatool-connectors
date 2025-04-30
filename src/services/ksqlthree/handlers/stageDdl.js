import { send, SUCCESS, FAILED } from "cfn-response-async";
import fs from "fs";
import { 
  zipAndUploadToS3,
  logEvent,
  logError
} from "../../../shared/utils/index.js";

/**
 * Lambda handler for staging DDL files in S3
 */
exports.handler = async function (event, context) {
  // Log event with sensitive data sanitized
  logEvent("info", "StageDdl request received", { 
    requestType: event.RequestType,
    resourceType: event.ResourceType,
    responseUrl: event.ResponseURL
  });

  const responseData = {};
  let responseStatus = SUCCESS;
  let outFileName;
  
  try {
    if (event.RequestType === "Create" || event.RequestType === "Update") {
      outFileName = `${context.awsRequestId}.zip`;
      const outFile = `/tmp/${outFileName}`;

      // Create a zip file with SQL contents and upload to S3
      await zipAndUploadToS3(
        event.ResourceProperties.DdlBucket,
        outFileName,
        event.ResourceProperties.SqlContents,
        outFile
      );

      responseData.S3Key = outFileName;
      logEvent("info", "DDL staging complete", responseData);
    } else if (event.RequestType === "Delete") {
      logEvent("info", "Delete request - no action needed");
    }
  } catch (error) {
    logError(error, "stageDdl", {
      requestType: event.RequestType,
      resourceType: event.ResourceType
    });
    responseStatus = FAILED;
  } finally {
    await send(event, context, responseStatus, responseData, "static");
  }
};
