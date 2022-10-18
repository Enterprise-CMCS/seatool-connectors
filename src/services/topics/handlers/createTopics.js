import * as topics from "../../../libs/topics-lib.js";
import _ from "lodash";

const condensedTopicList = [
  {
    // topics for the seatool service's debezium connector
    topicPrefix: "aws.seatool.cmcs",
    numPartitions: 1,
    replicationFactor: 3,
    topics: [
      "", // schema change topic
      ".dbHistory", // database history topic
      ".dbo.Action_Officers", // table stream topics
      ".dbo.Action_Types",
      ".dbo.aspnet_Users",
      ".dbo.Call_Held_Reasons",
      ".dbo.Code_After_Init_Assess",
      ".dbo.Column_Definition",
      ".dbo.Components_StatePlans",
      ".dbo.Components",
      ".dbo.Early_Alert_Field_Types",
      ".dbo.Early_Alert_Fields",
      ".dbo.Email",
      ".dbo.EmailDistribution",
      ".dbo.Holiday",
      ".dbo.OCD_Review",
      ".dbo.Officers",
      ".dbo.Plan_Types",
      ".dbo.Position",
      ".dbo.Priority_Codes",
      ".dbo.Priority_Complexity",
      ".dbo.Priority_Review_Position",
      ".dbo.RAI",
      ".dbo.Region_Access",
      ".dbo.Region",
      ".dbo.SPA_Type",
      ".dbo.SPW_Status",
      ".dbo.State_Plan_1115_State_PN",
      ".dbo.State_Plan_1115_TE",
      ".dbo.State_Plan_1115",
      ".dbo.State_Plan_APD_Sub_Type",
      ".dbo.State_Plan_APD",
      ".dbo.State_Plan_Early_Alerts",
      ".dbo.State_Plan_Impact_Funding",
      ".dbo.State_Plan", // table stream topics
      ".dbo.States_Officer_Represents",
      ".dbo.States",
      ".dbo.Stop_Resume_Dates",
      ".dbo.Sub_Type",
      ".dbo.Table_Definition",
      ".dbo.Title_Type",
      ".dbo.Type",
      ".dbo.State_Plan_Service_Types",
      ".dbo.State_Plan_Service_SubTypes",
    ],
  },
];

exports.handler = async function (event, context, callback) {
  console.log("Received event:", JSON.stringify(event, null, 2));
  var topicList = [];

  // Generate the complete topic list from the condensed version above.
  for (var element of condensedTopicList) {
    topicList.push(..._.map(element.topics, (topic) => {
      return {
        topic: `${element.topicPrefix}${topic}`,
        numPartitions: element.numPartitions,
        replicationFactor: element.replicationFactor,
      };
    }));
  }

  await topics.createTopics(
    process.env.brokerString,
    process.env.topicNamespace,
    topicList
  );
};
