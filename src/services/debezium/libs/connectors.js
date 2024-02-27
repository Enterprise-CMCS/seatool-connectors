export const connectors = [
  {
    name: "aws.seatool.debezium.cdc",
    config: {
      "connector.class": "io.debezium.connector.sqlserver.SqlServerConnector",
      "database.hostname": process.env.legacydbIp,
      "database.port": process.env.legacydbPort,
      "database.user": process.env.legacydbUser,
      "database.password": process.env.legacydbPassword,
      "database.names": "SEA",
      "topic.prefix": `${process.env.topicNamespace}aws.seatool.debezium.cdc`,
      "database.server.name": `${process.env.topicNamespace}aws.seatool.debezium.cdc`,
      "table.include.list":
        "dbo.Action_Officers, dbo.Action_Types, dbo.Aspnet_Users, dbo.Call_Held_Reasons, dbo.Code_After_Init_Assess, dbo.Column_Definition, dbo.Components_StatePlans, dbo.Components, dbo.Early_Alert_Field_Types, dbo.Early_Alert_Fields, dbo.Email, dbo.EmailDistribution, dbo.Holiday, dbo.OCD_Review, dbo.Officers, dbo.Plan_Types, dbo.Position, dbo.Priority_Codes, dbo.Priority_Complexity, dbo.Priority_Review_Position, dbo.RAI, dbo.Region_Access, dbo.Region, dbo.SPA_Type, dbo.SPW_Status, dbo.State_Plan_1115_State_PN, dbo.State_Plan_1115_TE, dbo.State_Plan_1115, dbo.State_Plan_APD_Sub_Type, dbo.State_Plan_APD, dbo.State_Plan_Early_Alerts, dbo.State_Plan_Impact_Funding, dbo.State_Plan,dbo.States_Officer_Represents, dbo.States, dbo.Stop_Resume_Dates, dbo.Sub_Type, dbo.Table_Definition, dbo.Title_Type, dbo.Type, dbo.State_Plan_Service_Types, dbo.State_Plan_Service_SubTypes",
      "column.exclude.list":
        "dbo.State_Plan.Changed_Date,dbo.Action_Officers.replica_timestamp,dbo.Action_Types.replica_timestamp,dbo.Aspnet_Users.replica_timestamp,dbo.Call_Held_Reasons.replica_timestamp,dbo.Code_After_Init_Assess.replica_timestamp,dbo.Column_Definition.replica_timestamp,dbo.Components_StatePlans.replica_timestamp,dbo.Components.replica_timestamp,dbo.Early_Alert_Field_Types.replica_timestamp,dbo.Early_Alert_Fields.replica_timestamp,dbo.Email.replica_timestamp,dbo.EmailDistribution.replica_timestamp,dbo.Holiday.replica_timestamp,dbo.OCD_Review.replica_timestamp,dbo.Officers.replica_timestamp,dbo.Plan_Types.replica_timestamp,dbo.Position.replica_timestamp,dbo.Priority_Codes.replica_timestamp,dbo.Priority_Complexity.replica_timestamp,dbo.Priority_Review_Position.replica_timestamp,dbo.RAI.replica_timestamp,dbo.Region_Access.replica_timestamp,dbo.Region.replica_timestamp,dbo.SPA_Type.replica_timestamp,dbo.SPW_Status.replica_timestamp,dbo.State_Plan_1115_State_PN.replica_timestamp,dbo.State_Plan_1115_TE.replica_timestamp,dbo.State_Plan_1115.replica_timestamp,dbo.State_Plan_APD_Sub_Type.replica_timestamp,dbo.State_Plan_APD.replica_timestamp,dbo.State_Plan_Early_Alerts.replica_timestamp,dbo.State_Plan_Impact_Funding.replica_timestamp,dbo.State_Plan.replica_timestamp,dbo.States_Officer_Represents.replica_timestamp,dbo.States.replica_timestamp,dbo.Stop_Resume_Dates.replica_timestamp,dbo.Sub_Type.replica_timestamp,dbo.Table_Definition.replica_timestamp,dbo.Title_Type.replica_timestamp,dbo.Type.replica_timestamp,dbo.State_Plan_Service_Types.replica_timestamp,dbo.State_Plan_Service_SubTypesdbo.Action_Officers.replica_id,dbo.Action_Types.replica_id,dbo.Aspnet_Users.replica_id,dbo.Call_Held_Reasons.replica_id,dbo.Code_After_Init_Assess.replica_id,dbo.Column_Definition.replica_id,dbo.Components_StatePlans.replica_id,dbo.Components.replica_id,dbo.Early_Alert_Field_Types.replica_id,dbo.Early_Alert_Fields.replica_id,dbo.Email.replica_id,dbo.EmailDistribution.replica_id,dbo.Holiday.replica_id,dbo.OCD_Review.replica_id,dbo.Officers.replica_id,dbo.Plan_Types.replica_id,dbo.Position.replica_id,dbo.Priority_Codes.replica_id,dbo.Priority_Complexity.replica_id,dbo.Priority_Review_Position.replica_id,dbo.RAI.replica_id,dbo.Region_Access.replica_id,dbo.Region.replica_id,dbo.SPA_Type.replica_id,dbo.SPW_Status.replica_id,dbo.State_Plan_1115_State_PN.replica_id,dbo.State_Plan_1115_TE.replica_id,dbo.State_Plan_1115.replica_id,dbo.State_Plan_APD_Sub_Type.replica_id,dbo.State_Plan_APD.replica_id,dbo.State_Plan_Early_Alerts.replica_id,dbo.State_Plan_Impact_Funding.replica_id,dbo.State_Plan.replica_id,dbo.States_Officer_Represents.replica_id,dbo.States.replica_id,dbo.Stop_Resume_Dates.replica_id,dbo.Sub_Type.replica_id,dbo.Table_Definition.replica_id,dbo.Title_Type.replica_id,dbo.Type.replica_id,dbo.State_Plan_Service_Types.replica_id,dbo.State_Plan_Service_SubTypes.replica_id",
      "skip.messages.without.change": true,
      "schema.history.internal.kafka.topic": `${process.env.topicNamespace}aws.seatool.debezium.cdc.dbHistory`,
      "schema.history.internal.kafka.bootstrap.servers":
        process.env.bootstrapBrokerStringTls,
      "schema.history.internal.producer.security.protocol": "SSL",
      "schema.history.internal.consumer.security.protocol": "SSL",
      "decimal.handling.mode": "double",
      "database.encrypt": false,
      "poll.interval.ms": 200,
    },
  },
];
