export const connectors = [
  {
    name: "source.debezium.aws.seatool.cmcs",
    config: {
      "connector.class": "io.debezium.connector.sqlserver.SqlServerConnector",
      "database.hostname": process.env.legacydbIp,
      "database.port": process.env.legacydbPort,
      "database.user": process.env.legacydbUser,
      "database.password": process.env.legacydbPassword,
      "database.dbname": "SEA",
      "database.server.name": `${process.env.topicNamespace}aws.seatool.cmcs`,
      "table.include.list":
        "dbo.Action_Officers, dbo.Action_Types, dbo.Aspnet_Users, dbo.Call_Held_Reasons, dbo.Code_After_Init_Assess, dbo.Column_Definition, dbo.Components_StatePlans, dbo.Components, dbo.Early_Alert_Field_Types, dbo.Early_Alert_Fields, dbo.Email, dbo.EmailDistribution, dbo.Holiday, dbo.OCD_Review, dbo.Officers, dbo.Plan_Types, dbo.Position, dbo.Priority_Codes, dbo.Priority_Complexity, dbo.Priority_Review_Position, dbo.RAI, dbo.Region_Access, dbo.Region, dbo.SPA_Type, dbo.SPW_Status, dbo.State_Plan_1115_State_PN, dbo.State_Plan_1115_TE, dbo.State_Plan_1115, dbo.State_Plan_APD_Sub_Type, dbo.State_Plan_APD, dbo.State_Plan_Early_Alerts, dbo.State_Plan_Impact_Funding, dbo.State_Plan, // table stream topics dbo.States_Officer_Represents, dbo.States, dbo.Stop_Resume_Dates, dbo.Sub_Type, dbo.Table_Definition, dbo.Title_Type, dbo.Type, dbo.State_Plan_Service_Types, dbo.State_Plan_Service_SubTypes",
      "database.history.kafka.topic": `${process.env.topicNamespace}aws.seatool.cmcs.dbHistory`,
      "database.history.kafka.bootstrap.servers":
        process.env.bootstrapBrokerStringTls,
      "database.history.producer.security.protocol": "SSL",
      "database.history.consumer.security.protocol": "SSL",
      "decimal.handling.mode": "double",
    },
  },
];
