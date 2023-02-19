import { send, SUCCESS, FAILED } from "cfn-response-async";
import * as topics from "../../../libs/topics-lib.js";
// import _ from "lodash";
exports.handler = async function (event, context) {
  console.log("Request:", JSON.stringify(event, undefined, 2));
  const responseData = {};
  let responseStatus = SUCCESS;
  try {
    const TopicsToCreate = event.ResourceProperties.TopicsToCreate;
    const Namespace = event.ResourceProperties.Namespace;
    const BrokerString = event.ResourceProperties.BrokerString;
    const topicConfig = TopicsToCreate.map(function (element) {
      const name = element.name;
      const replicationFactor = element.replicationFactor || 3;
      const numPartitions = element.numPartitions || 1;
      if (!name) {
        throw "Invalid configuration for TopicsToCreate.  All entries must have a 'name' key with a string value.";
      }
      if (replicationFactor < 3) {
        throw "Invalid configuration for TopicsToCreate.  If replicationFactor is set for a topic, it must be greater than or equal to 3.";
      }
      if (numPartitions < 1) {
        throw "Invalid configuration for TopicsToCreate.  If numPartitions is set for a topic, it must be greater than or equal to 1.";
      }
      return {
        topic: `${Namespace}${name}`,
        numPartitions,
        replicationFactor,
      };
    });
    console.log(JSON.stringify(topicConfig, null, 2));
    if (event.RequestType === "Create" || event.RequestType == "Update") {
      await topics.createTopics(BrokerString, topicConfig);
    } else if (event.RequestType === "Delete") {
      console.log("asdf");
      // console.log(namespace);
      // // Here, we skip deletion unless we have a namespace that fits our expected pattern.
      // // This guards against non-namespace branches, whether intentionally so (master) or
      // // unintentionally so (a mistake), from getting topics deleted.
      // // FYSA:  The deleteTopics function has a separate but similar safeguard.
      // if (namespace.match(/--.*--.*--/g)) {
      //   console.log("Attempting to delete topics...");
      //   var topicList = topicConfig.map(function (topic) {
      //     return topic.topic;
      //   });
      //   console.log(topicList);
      //   await topics.deleteTopics(brokerString, topicList);
      // } else {
      //   console.log("Skipping topic deletion, as no namespace was passed...");
      // }
    }
  } catch (error) {
    console.error(error);
    responseStatus = FAILED;
  } finally {
    await send(event, context, responseStatus, responseData, "static");
  }
};

// function generateTopicList(config, namespace) {
//   var ret = [];
//   for (var element of config) {
//     ret.push(
//       ..._.map(element.topics, (topic) => {
//         return {
//           topic: `${namespace}${element.topicPrefix}${topic}`,
//           numPartitions: element.numPartitions,
//           replicationFactor: element.replicationFactor,
//         };
//       })
//     );
//   }
//   return ret;
// }
