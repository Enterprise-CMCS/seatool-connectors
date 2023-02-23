import { send, SUCCESS, FAILED } from "cfn-response-async";
import * as topics from "../../../libs/topics-lib.js";

exports.handler = async function (event, context) {
  console.log("Request:", JSON.stringify(event, undefined, 2));
  const responseData = {};
  let responseStatus = SUCCESS;
  try {
    const BrokerString = event.ResourceProperties.BrokerString;
    const TopicsToDelete = event.ResourceProperties.TopicsToDelete;
    if (event.RequestType === "Create" || event.RequestType == "Update") {
      console.log("This resource does nothing on Create and Update events.")
    } else if (event.RequestType === "Delete") {
      if (
        !TopicsToDelete.every((expression) => {
          expression.match(/.*--.*--.*--.*/g);
        })
      ) {
        console.log(`
        WARNING:  Only patterns that include a namespace qualifier can be deleted; they must match /.*--.*--.*--.*/g
        You have passed at least one pattern that does not match this pattern.
        This resource will do nothing.
        `);
      } else {
        await topics.deleteTopics(BrokerString, TopicsToDelete);
      }
    }
  } catch (error) {
    console.error(error);
    responseStatus = FAILED;
  } finally {
    await send(event, context, responseStatus, responseData, "static");
  }
};
