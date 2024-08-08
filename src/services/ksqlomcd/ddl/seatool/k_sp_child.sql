SET 'auto.offset.reset' = 'earliest';

CREATE TABLE IF NOT EXISTS K_seatool_agg_Action_Officers
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.Action_Officers',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT ao.pk->payload->ID_Number, 
         COLLECT_LIST(o.Officer) as ActionOfficers
    FROM K_seatool_tld_Action_Officers ao
    LEFT JOIN K_seatool_tld_Officers o ON ao.pk->payload->Officer_ID = o.Officer_ID
  GROUP BY ao.pk->payload->ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_Components_StatePlans
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.Components_StatePlans',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT sp.pk->payload->ID_Number,
         COLLECT_LIST(c.Component) as ComponentsStatePlans
    FROM  K_seatool_tld_Components_StatePlans sp
    LEFT JOIN K_seatool_tld_Components c ON sp.pk->payload->Component_ID = c.Component_ID
  GROUP BY sp.pk->payload->ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_State_Plan_1115
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.State_Plan_1115',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT sp.ID_Number,
         STRUCT(
           StatePlan1115 := COLLECT_LIST(sp.STATEPLAN1115),
           TitleType := COLLECT_LIST(tt.TitleType)
         ) as StatePlan1115
    FROM K_seatool_tld_State_Plan_1115 sp
    LEFT JOIN K_seatool_tld_Title_Type tt ON sp.STATEPLAN1115->Title_Type_ID = tt.Title_Type_ID
  GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_State_Plan_APD_Sub_Type
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.State_Plan_APD_Sub_Type',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT sp.pk->payload->ID_Number,
         COLLECT_LIST(st.SubType) as SubType
    FROM  K_seatool_tld_State_Plan_APD_Sub_Type sp
    LEFT JOIN K_seatool_tld_Sub_Type st ON sp.pk->payload->Sub_Type_ID = st.Sub_Type_ID
  GROUP BY sp.pk->payload->ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_State_Plan_Early_Alerts
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.State_Plan_Early_Alerts',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT sp.pk->payload->ID_Number,
         STRUCT(
           EarlyAlert := COLLECT_LIST(sp.STATEPLANEARLYALERT),
           AlertField := COLLECT_LIST(ea.EARLYALERTFIELD)
         ) as StatePlanEarlyAlerts
    FROM K_seatool_tld_State_Plan_Early_Alerts sp
    LEFT JOIN K_seatool_tld_Early_Alert_Fields ea ON sp.pk->payload->EA_Field_ID = ea.EA_Field_ID
  GROUP BY sp.pk->payload->ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_RAI
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.RAI',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT r.pk->payload->ID_Number,
         COLLECT_LIST(r.RAI) as RAI
    FROM  K_seatool_tld_RAI r
  GROUP BY r.pk->payload->ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_State_Plan_APD
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.State_Plan_APD',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT sp.ID_Number,
         COLLECT_LIST(sp.StatePlanAPD) as StatePlanAPD
    FROM  K_seatool_tld_State_Plan_APD sp
  GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_State_Plan_Impact_Funding
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.State_Plan_Impact_Funding',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT sp.ID_Number,
         COLLECT_LIST(sp.ImpactFunding) as StatePlanImpactFunding
    FROM  K_seatool_tld_State_Plan_Impact_Funding sp
  GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_Stop_Resume_Dates
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.Stop_Resume_Dates',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT sr.pk->payload->ID_Number,
         COLLECT_LIST(sr.StopResumeDate) as StopResumeDates
    FROM  K_seatool_tld_Stop_Resume_Dates sr
  GROUP BY sr.pk->payload->ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_Service_Types
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.Service_Types',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT ao.pk->payload->ID_Number, 
         COLLECT_LIST(o.SPAType) as StatePlanServiceType
    FROM K_seatool_tld_State_Plan_Service_Types ao
    LEFT JOIN K_seatool_tld_SPA_Type o ON ao.pk->payload->Service_Type_ID = o.SPA_Type_ID
  GROUP BY ao.pk->payload->ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_agg_State_Plan_Service_SubTypes
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.v2.agg.State_Plan_Service_SubTypes',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
  SELECT ao.pk->payload->ID_Number,
         COLLECT_LIST(o.Type) as StatePlanServiceSubTypes
    FROM  K_seatool_tld_State_Plan_Service_SubTypes ao
    LEFT JOIN  K_seatool_tld_Type o ON ao.pk->payload->Service_SubType_ID = o.Type_Id
  GROUP BY ao.pk->payload->ID_Number
EMIT CHANGES;

