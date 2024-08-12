SET 'auto.offset.reset' = 'earliest';

CREATE STREAM IF NOT EXISTS K_seatool_Action_Officers_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar, Officer_ID integer>> KEY,
  payload STRUCT <after STRUCT<
      ID_Number varchar,
      Officer_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Action_Officers',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Action_Types_stream (
  PK STRUCT <payload STRUCT <Action_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Action_ID integer,
    Action_Name varchar,
    Plan_Type_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Action_Types',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_aspnet_Users_stream (
  PK STRUCT <payload STRUCT <UserId varchar>> KEY,
  payload STRUCT <after STRUCT<
    ApplicationId varchar,
    UserId varchar,
    UserName varchar,
    LoweredUserName varchar,
    MobileAlias varchar,
    IsAnonymous boolean,
    LastActivityDate timestamp>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.aspnet_Users',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Call_Held_Reasons_stream (
  PK STRUCT <payload STRUCT <Call_Held_Reason_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Call_Held_Reason_ID integer,
    Reason_Description varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Call_Held_Reasons',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Code_After_Init_Assess_stream (
  PK STRUCT <payload STRUCT <Code_after_init_assess_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Code_after_init_assess_ID integer,
    Code_after_init_assess_Desc varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Code_After_Init_Assess',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Components_stream (
  PK STRUCT <payload STRUCT <Component_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Component_ID integer,
    Component_Name varchar,
    Alerts_Inbox_Address varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Components',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Components_StatePlans_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar, Component_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    Component_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Components_StatePlans',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Early_Alert_Field_Types_stream (
  PK STRUCT <payload STRUCT <EA_Type_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    EA_Type_ID integer,
    EA_Type_Description varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Early_Alert_Field_Types',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Early_Alert_Fields_stream (
  PK STRUCT <payload STRUCT <EA_Field_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    EA_Field_ID integer,
    EA_Label varchar,
    EA_Type_ID integer,
    EA_Drop_Down_Values varchar,
    Priority_Value varchar,
    Priority_Operator varchar,
    Priority_Code_ID integer,
    Active boolean,
    Is_APD boolean>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Early_Alert_Fields',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_EmailDistribution_stream (
  PK STRUCT <payload STRUCT <EmailDistributionID integer>> KEY,
  payload STRUCT <after STRUCT<
    EmailDistributionID integer,
    EmailID integer,
    EmailAddress varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.EmailDistribution',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Email_stream (
  PK STRUCT <payload STRUCT <EmailID integer>> KEY,
  payload STRUCT <after STRUCT<
    EmailID integer,
    EmailName varchar,
    FileName varchar,
    DisplayInAdmin boolean>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Email',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_OCD_Review_stream (
  PK STRUCT <payload STRUCT <OCD_Review_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    OCD_Review_ID integer,
    OCD_Review_Description varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.OCD_Review',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Officers_stream (
  PK STRUCT <payload STRUCT <Officer_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Officer_ID integer,
    First_Name varchar,
    Last_Name varchar,
    Initials varchar,
    Telephone varchar,
    Position_ID integer,
    Email varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Officers',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_SPA_Type_stream (
  PK STRUCT <payload STRUCT <SPA_Type_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    SPA_Type_ID integer,
    SPA_Type_Name varchar,
    Plan_Type_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.SPA_Type',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Position_stream (
  PK STRUCT <payload STRUCT <Position_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Position_ID integer,
    Position_Name varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Position',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Priority_Codes_stream (
  PK STRUCT <payload STRUCT <Priority_Code_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Priority_Code_ID integer,
    Priority_Code varchar,
    Priority_Code_Description varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Priority_Codes',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Priority_Complexity_stream (
  PK STRUCT <payload STRUCT <Priority_Complexity_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Priority_Complexity_ID integer,
    Priority_Complexity_Value varchar,
    Priority_Complexity_Description varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Priority_Complexity',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Priority_Review_Position_stream (
  PK STRUCT <payload STRUCT <Review_Position_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Review_Position_ID integer,
    Review_Position_Code varchar,
    Review_Position_Description varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Priority_Review_Position',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_RAI_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar, RAI_Requested_Date timestamp>> KEY,
  payload STRUCT < 
    after STRUCT<
      ID_Number varchar,
      RAI_Requested_Date timestamp,
      RAI_Received_Date timestamp,
      RAI_Withdrawn_Date timestamp>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.RAI',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Region_stream (
  PK STRUCT <payload STRUCT <Region_ID varchar>> KEY,
  payload STRUCT <after STRUCT<
    Region_ID varchar,
    Region_Name varchar,
    Alerts_Inbox_Address varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Region',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Region_Access_stream (
  PK STRUCT <payload STRUCT <UserId varchar, Region_ID varchar>> KEY,
  payload STRUCT <after STRUCT<
    UserId varchar,
    Region_ID varchar,
    Type_Of_Access varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Region_Access',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_State_Plan_Service_Types_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar, Service_Type_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    Service_Type_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.State_Plan_Service_Types',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_State_Plan_1115_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    Title_Type_ID integer,
    Waiver_Number varchar,
    Application_Complete_Date timestamp,
    Application_Complete_PN timestamp,
    Analyst_Surname_Content_Complete integer,
    Analyst_Surname_PN_Content_Complete integer,
    Day_15_Letter_Date timestamp,
    Day_15_Letter_Type varchar,
    Posted_To_Medicaid_Gov_Date timestamp,
    State_Proposed_Effective_Date timestamp,
    Disaster_Exemption_Approval_Date timestamp,
    FRT_Response_Deadline timestamp,
    Disapproval_Track boolean>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.State_Plan_1115',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_State_Plan_APD_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    CALT_Location varchar,
    Sharepoint_Link varchar,
    Email_Sent boolean>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.State_Plan_APD',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_State_Plan_APD_Sub_Type_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar, Sub_Type_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    Sub_Type_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.State_Plan_APD_Sub_Type',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_State_Plan_Early_Alerts_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar, EA_Field_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    EA_Field_ID integer,
    Yes_No_Val boolean, 
    Text_DD_Val varchar,
    Email_Sent boolean>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.State_Plan_Early_Alerts',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_State_Plan_Impact_Funding_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    Impact_Year_1 integer,
    Impact_Year_1_Value double(18,0),
    Impact_Year_2 integer,
    Impact_Year_2_Value double(18,0),
    Impact_Year_3 integer,
    Impact_Year_3_Value double(18,0),
    Appropriations boolean,
    IGT boolean,
    CPE boolean,
    Provider_Tax boolean,
    Other boolean>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.State_Plan_Impact_Funding',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_States_stream (
  PK STRUCT <payload STRUCT <State_Code varchar>> KEY,
  payload STRUCT <after STRUCT<
    State_Code varchar,
    Region_ID varchar,
    State_Name varchar,
    Priority_Flag boolean>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.States',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Stop_Resume_Dates_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar, Stop_Date timestamp>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    Stop_Date timestamp,
    Resume_Date timestamp>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Stop_Resume_Dates',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Sub_Type_stream (
  PK STRUCT <payload STRUCT <Sub_Type_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Sub_Type_ID integer,
    Sub_Type_Name varchar,
    Type_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Sub_Type',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Title_Type_stream (
  PK STRUCT <payload STRUCT <Title_Type_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    Title_Type_ID integer,
    Title_Type_Description varchar>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Title_Type',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_Type_stream (
  PK STRUCT <payload STRUCT <Type_Id integer>> KEY,
  payload STRUCT <after STRUCT<
    Type_Id integer,
    Type_Name varchar,
    Type_Class integer,
    Plan_Type_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.Type',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_State_Plan_Service_SubTypes_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar, Service_SubType_ID integer>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    Service_SubType_ID integer>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.State_Plan_Service_SubTypes',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

CREATE STREAM IF NOT EXISTS K_seatool_State_Plan_stream (
  PK STRUCT <payload STRUCT <ID_Number varchar>> KEY,
  payload STRUCT <after STRUCT<
    ID_Number varchar,
    Submission_Date timestamp,
    Start_Clock_Date timestamp,
    Region_ID varchar,
    Component_ID integer,
    State_Code varchar,
    Proposed_Date timestamp,
    Plan_Type integer,
    Action_Type integer,
    CO_Submission_Date timestamp,
    Lead_Analyst_ID integer,
    Approval_Status_Type varchar,
    Approved_Effective_Date timestamp,
    Actual_Effective_Date timestamp,
    Days_Extension_Number integer,
    Title_Name varchar,
    Alert_90_Days_Date timestamp,
    Alert_Milestone1_Days integer,
    Alert_Milestone2_Days integer,
    Alert_Milestone3_Days integer,
    Alert_Milestone4_Days integer,
    End_Date timestamp,
    Remarks_Memo varchar,
    Status_Memo varchar,
    Summary_Memo varchar,
    Priority_Comments_Memo varchar,
    Budget_Neutrality_Established_Flag boolean,
    Budget_Neutrality_Status_Memo varchar,
    Budget_Impact boolean,
    Budget_Impact_Value varchar,
    SPA_Type_ID integer,
    Type_Id integer,
    Status_Date timestamp,
    SPW_Status_ID integer,
    Priority_Code_ID integer,
    Priority_Complexity_ID integer,
    Review_Position_ID integer,
    FRT_Date timestamp,
    Current_Waiver_TE boolean,
    Current_Waiver_Expires_Date timestamp,
    TE_End_Date timestamp,
    OCD_Review_ID integer,
    OCD_Review_Comments_Memo varchar,
    Companion_Letter_Requested_Date timestamp,
    Companion_Letter_Received_Date timestamp,
    RO_Analyst_ID integer,
    SPW_Import boolean,
    MMDL_Import boolean,
    Approval_Docs_Received boolean,
    Blocking_SPAs_Memo varchar,
    Call_Held boolean,
    Call_Held_Reason_ID integer,
    Code_after_init_assess_ID integer,
    Date_of_coding_change timestamp,
    Initial_submission_complete boolean,
    Missing_information varchar,
    Backup_Program_Analyst_ID integer,
    Backup_FM_Analyst_ID integer,
    Pending_Concurrence_Date timestamp,
    GAP double,
    Attached_SPA boolean,
    UPL_Accepted boolean,
    Template_Issues boolean,
    Template_Issues_Memo varchar,
    Template_Issues_Resolved boolean,
    GAP2 double,
    GAP3 double,
    GAP_NA boolean,
    GAP2_NA boolean,
    GAP3_NA boolean,
    Guidance_Docs_Submitted boolean,
    PublicHealth_StateEmergency boolean,
    Submission_Type varchar,
    Fiscal_Year integer,
    Fiscal_Quarter integer,
    Date_Sent_PSCCAS timestamp,
    Eliminated_Cost boolean,
    Added_Cost boolean,
    Organization_Change boolean>>
)
WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.debezium.cdc.SEA.dbo.State_Plan',VALUE_FORMAT='JSON',KEY_FORMAT='JSON');

