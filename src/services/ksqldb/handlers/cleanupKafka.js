import { send, SUCCESS, FAILED } from "cfn-response-async";
import * as topics from "../../../libs/topics-lib.js";
import { 
  executeWithRetry, 
  logEvent, 
  logError,
  DEFAULT_RETRY_CONFIG 
} from "../../../shared/utils/index.js";

/**
 * Handler for cleanup operations related to Kafka topics
 */
export const handler = async function (event, context) {
  logEvent("info", "CleanupKafka request received", { 
    requestType: event.RequestType,
    resourceType: event.ResourceType
  });
  
  const responseData = {};
  let responseStatus = SUCCESS;
  
  try {
    if (event.RequestType === "Create" || event.RequestType === "Update") {
      logEvent("info", "Create/Update request - no action needed");
    } else if (event.RequestType === "Delete") {
      const BrokerString = event.ResourceProperties.BrokerString;
      const TopicPatternsToDelete = event.ResourceProperties.TopicPatternsToDelete;
      
      logEvent("info", "Attempting to delete topics", { 
        patterns: TopicPatternsToDelete 
      });

      await executeWithRetry(
        async () => {
          await topics.deleteTopics(BrokerString, TopicPatternsToDelete);
        },
        {
          ...DEFAULT_RETRY_CONFIG,
          onRetry: (error, retryCount) => {
            logEvent("warn", `Retrying delete topics operation`, { 
              retryCount,
              error: error.message
            });
          }
        }
      );
      
      logEvent("info", "Successfully deleted topics");
    }
  } catch (error) {
    logError(error, "cleanupKafka", {
      requestType: event.RequestType 
    });
    responseStatus = FAILED;
  } finally {
    await send(event, context, responseStatus, responseData, "static");
  }
};
