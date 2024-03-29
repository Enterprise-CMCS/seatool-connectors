import { send, SUCCESS, FAILED } from "cfn-response-async";
import * as topics from "../../../libs/topics-lib.js";

export const handler = async function (event, context) {
  console.log("Request:", JSON.stringify(event, undefined, 2));
  const responseData = {};
  let responseStatus = SUCCESS;
  try {
    if (event.RequestType === "Create" || event.RequestType === "Update") {
      console.log("This resource does nothing on Create and Update events.");
    } else if (event.RequestType === "Delete") {
      const BrokerString = event.ResourceProperties.BrokerString;
      const TopicPatternsToDelete =
        event.ResourceProperties.TopicPatternsToDelete;
      console.log(
        `Attempting a delete for each of the following patterns:  ${TopicPatternsToDelete}`
      );

      const maxRetries = 10;
      const retryDelay = 10000; //10s
      let retries = 0;
      let success = false;
      while (!success && retries < maxRetries) {
        try {
          await topics.deleteTopics(BrokerString, TopicPatternsToDelete);
          success = true;
        } catch (error) {
          console.error(
            `Error in deleteTopics operation: ${JSON.stringify(error)}`
          );
          retries++;
          console.log(
            `Retrying in ${
              retryDelay / 1000
            } seconds (Retry ${retries}/${maxRetries})`
          );
          await new Promise((resolve) => setTimeout(resolve, retryDelay));
        }
      }
      if (!success) {
        console.error(`Failed to delete topics after ${maxRetries} retries.`);
        responseStatus = FAILED;
      }
    }
  } catch (error) {
    console.error(error);
    responseStatus = FAILED;
  } finally {
    await send(event, context, responseStatus, responseData, "static");
  }
};
