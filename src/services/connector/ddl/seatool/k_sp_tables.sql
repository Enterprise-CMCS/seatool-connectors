SET 'auto.offset.reset' = 'earliest';

CREATE TABLE IF NOT EXISTS K_seatool_tld_Action_Officers
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Action_Officers',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk, LATEST_BY_OFFSET(payload->after, FALSE) as ActionOfficer
    FROM K_seatool_Action_Officers_stream
GROUP BY pk
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Action_Types
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Action_Types',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Action_ID, LATEST_BY_OFFSET(payload->after, FALSE) as ActionType
    FROM K_seatool_Action_Types_stream
GROUP BY pk->payload->Action_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_aspnet_Users
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.aspnet_Users',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->UserId, LATEST_BY_OFFSET(payload->after, FALSE) as aspnetUser
    FROM K_seatool_aspnet_Users_stream
GROUP BY pk->payload->UserId
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Call_Held_Reasons
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Call_Held_Reasons',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Call_Held_Reason_ID, LATEST_BY_OFFSET(payload->after, FALSE) as CallHeldReason
    FROM K_seatool_Call_Held_Reasons_stream
GROUP BY pk->payload->Call_Held_Reason_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Code_After_Init_Assess
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Code_After_Init_Assess',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Code_after_init_assess_ID, LATEST_BY_OFFSET(payload->after, FALSE) as InitAssess
    FROM K_seatool_Code_After_Init_Assess_stream
GROUP BY pk->payload->Code_after_init_assess_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Components
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Components',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Component_ID, LATEST_BY_OFFSET(payload->after, FALSE) as Component
    FROM K_seatool_Components_stream
GROUP BY pk->payload->Component_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Components_StatePlans
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Components_StatePlans',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk, LATEST_BY_OFFSET(payload->after, FALSE) as ComponentStatePlan
    FROM K_seatool_Components_StatePlans_stream
GROUP BY pk
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Early_Alert_Fields
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Early_Alert_Fields',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->EA_Field_ID, LATEST_BY_OFFSET(payload->after, FALSE) as EarlyAlertField
    FROM K_seatool_Early_Alert_Fields_stream
GROUP BY pk->payload->EA_Field_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_EmailDistribution
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.EmailDistribution',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->EmailDistributionID, LATEST_BY_OFFSET(payload->after, FALSE) as EmailDistribution
    FROM K_seatool_EmailDistribution_stream
GROUP BY pk->payload->EmailDistributionID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Email
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Email',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->EmailID, LATEST_BY_OFFSET(payload->after, FALSE) as Email
    FROM K_seatool_Email_stream
GROUP BY pk->payload->EmailID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_OCD_Review
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.OCD_Review',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->OCD_Review_ID, LATEST_BY_OFFSET(payload->after, FALSE) as OCDReview
    FROM K_seatool_OCD_Review_stream
GROUP BY pk->payload->OCD_Review_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Officers
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Officers',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Officer_ID, LATEST_BY_OFFSET(payload->after, FALSE) as Officer
    FROM K_seatool_Officers_stream
GROUP BY pk->payload->Officer_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Plan_Types
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Plan_Types',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Plan_Type_ID, LATEST_BY_OFFSET(payload->after, FALSE) as PlanType
    FROM K_seatool_Plan_Types_stream
GROUP BY pk->payload->Plan_Type_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Position
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Position',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Position_ID, LATEST_BY_OFFSET(payload->after, FALSE) as Position
    FROM K_seatool_Position_stream
GROUP BY pk->payload->Position_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Priority_Codes
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Priority_Codes',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Priority_Code_ID, LATEST_BY_OFFSET(payload->after, FALSE) as PriorityCode
    FROM K_seatool_Priority_Codes_stream
GROUP BY pk->payload->Priority_Code_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Priority_Complexity
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Priority_Complexity',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Priority_Complexity_ID, LATEST_BY_OFFSET(payload->after, FALSE) as PriorityComplexity
    FROM K_seatool_Priority_Complexity_stream
GROUP BY pk->payload->Priority_Complexity_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Priority_Review_Position
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Priority_Review_Position',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Review_Position_ID, LATEST_BY_OFFSET(payload->after, FALSE) as PriorityReviewPosition
    FROM K_seatool_Priority_Review_Position_stream
GROUP BY pk->payload->Review_Position_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_RAI
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.RAI',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk, LATEST_BY_OFFSET(payload->after, FALSE) as RAI
    FROM K_seatool_RAI_stream
GROUP BY pk
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Region
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Region',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Region_ID, LATEST_BY_OFFSET(payload->after, FALSE) as Region
    FROM K_seatool_Region_stream
GROUP BY pk->payload->Region_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Region_Access
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Region_Access',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk, LATEST_BY_OFFSET(payload->after, FALSE) as RegionAccess
    FROM K_seatool_Region_Access_stream
GROUP BY pk
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_SPA_Type
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.SPA_Type',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->SPA_Type_ID, LATEST_BY_OFFSET(payload->after, FALSE) as SPAType
    FROM K_seatool_SPA_Type_stream
GROUP BY pk->payload->SPA_Type_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_SPW_Status
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.SPW_Status',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->SPW_Status_ID, LATEST_BY_OFFSET(payload->after, FALSE) as SPWStatus
    FROM K_seatool_SPW_Status_stream
GROUP BY pk->payload->SPW_Status_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_State_Plan_1115
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.State_Plan_1115',KEY_FORMAT='JSON') AS
  SELECT pk->payload->ID_Number, 
         LATEST_BY_OFFSET(payload->after, FALSE) as StatePlan1115
    FROM K_seatool_State_Plan_1115_stream
GROUP BY pk->payload->ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_State_Plan_APD
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.State_Plan_APD',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->ID_Number, LATEST_BY_OFFSET(payload->after, FALSE) as StatePlanAPD
    FROM K_seatool_State_Plan_APD_stream
GROUP BY pk->payload->ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_State_Plan_APD_Sub_Type
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.State_Plan_APD_Sub_Type',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk, LATEST_BY_OFFSET(payload->after, FALSE) as APDSubType
    FROM K_seatool_State_Plan_APD_Sub_Type_stream
GROUP BY pk
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Early_Alert_Field_Types
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Early_Alert_Field_Types',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->EA_Type_ID, LATEST_BY_OFFSET(payload->after, FALSE) as FieldType
    FROM K_seatool_Early_Alert_Field_Types_stream
GROUP BY pk->payload->EA_Type_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_State_Plan_Early_Alerts
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.State_Plan_Early_Alerts',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk, LATEST_BY_OFFSET(payload->after, FALSE) as StatePlanEarlyAlert
    FROM K_seatool_State_Plan_Early_Alerts_stream
GROUP BY pk
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_State_Plan_Impact_Funding
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.State_Plan_Impact_Funding',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->ID_Number, LATEST_BY_OFFSET(payload->after, FALSE) as ImpactFunding
    FROM K_seatool_State_Plan_Impact_Funding_stream
GROUP BY pk->payload->ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_States
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.States',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->State_Code, LATEST_BY_OFFSET(payload->after, FALSE) as State
    FROM K_seatool_States_stream
GROUP BY pk->payload->State_Code
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Stop_Resume_Dates
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Stop_Resume_Dates',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk, LATEST_BY_OFFSET(payload->after, FALSE) as StopResumeDate
    FROM K_seatool_Stop_Resume_Dates_stream
GROUP BY pk
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Sub_Type
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Sub_Type',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Sub_Type_ID, LATEST_BY_OFFSET(payload->after, FALSE) as SubType
    FROM K_seatool_Sub_Type_stream
GROUP BY pk->payload->Sub_Type_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Title_Type
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Title_Type',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Title_Type_ID, LATEST_BY_OFFSET(payload->after, FALSE) as TitleType
    FROM K_seatool_Title_Type_stream
GROUP BY pk->payload->Title_Type_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_Type
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.Type',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Type_Id, LATEST_BY_OFFSET(payload->after, FALSE) as Type
    FROM K_seatool_Type_stream
GROUP BY pk->payload->Type_Id
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_State_Plan_Service_Types
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.State_Plan_Service_Types',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->Id_Number, LATEST_BY_OFFSET(payload->after, FALSE) as StatePlanServiceType
    FROM K_seatool_State_Plan_Service_Types_stream
GROUP BY pk->payload->ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_State_Plan_Service_SubTypes
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.State_Plan_Service_SubTypes',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk, LATEST_BY_OFFSET(payload->after, FALSE) as StatePlanServiceSubType
    FROM K_seatool_State_Plan_Service_SubTypes_stream
GROUP BY pk
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_State_Plan
  WITH (KAFKA_TOPIC='aws.ksqldb.seatool.tld.State_Plan',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT pk->payload->ID_Number, LATEST_BY_OFFSET(payload->after, FALSE) as StatePlan
    FROM K_seatool_State_Plan_stream
GROUP BY pk->payload->ID_Number
EMIT CHANGES;

