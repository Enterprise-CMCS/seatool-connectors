import { send, SUCCESS, FAILED } from "cfn-response-async";
import * as topics from "../../../libs/topics-lib.js";

exports.handler = async function (event, context) {
  console.log("Request:", JSON.stringify(event, undefined, 2));
  const responseData = {};
  let responseStatus = SUCCESS;
  try {
    const BrokerString = event.ResourceProperties.BrokerString;
    const TopicPatternsToDelete =
      event.ResourceProperties.TopicPatternsToDelete;
    if (event.RequestType === "Create" || event.RequestType == "Update") {
      console.log("This resource does nothing on Create and Update events.");
    } else if (event.RequestType === "Delete") {
      // Quietly filter out non-compliant patterns; we only delete patterns that contain --.*--.*--
      const validDeletePatterns = TopicPatternsToDelete.filter(
        (pattern) => !!pattern.match(/.*--.*--.*--.*/g)
      );
      console.log(
        `Attempting a delete for each of the following patterns:  ${validDeletePatterns}`
      );
      await topics.deleteTopics(BrokerString, validDeletePatterns);
    }
  } catch (error) {
    console.error(error);
    responseStatus = FAILED;
  } finally {
    await send(event, context, responseStatus, responseData, "static");
  }
};
