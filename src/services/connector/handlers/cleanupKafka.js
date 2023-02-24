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
      if (
        TopicPatternsToDelete.every((expression) => {
          return !!expression.match(/.*--.*--.*--.*/g); // The !! converts to a boolean; true if match is found
        })
      ) {
        await topics.deleteTopics(BrokerString, TopicPatternsToDelete);
      } else {
        console.log(`
        WARNING:  Only patterns that include a namespace qualifier can be deleted; they must match /.*--.*--.*--.*/g
        You have passed at least one pattern that does not match this pattern.
        This resource will do nothing.
        `);
      }
    }
  } catch (error) {
    console.error(error);
    responseStatus = FAILED;
  } finally {
    await send(event, context, responseStatus, responseData, "static");
  }
};
