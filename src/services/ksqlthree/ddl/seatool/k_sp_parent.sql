SET 'auto.offset.reset' = 'earliest';

CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_ActionTypes
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_ActionTypes',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Action_Type,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         Action_Type := LATEST_BY_OFFSET(payload->after->Action_Type,FALSE)
        ) SP_ActionType
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Action_Type
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Action_Types
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.Action_Types',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(atp.ActionType) as ActionTypes
   FROM K_seatool_tld_SP_ActionTypes sp
   JOIN K_seatool_tld_Action_Types atp ON sp.Action_Type = atp.Action_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_CallHeldReasons
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_CallHeldReasons',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Call_Held_Reason_ID,
        STRUCT (
          ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
          Call_Held_Reason_ID := LATEST_BY_OFFSET(payload->after->Call_Held_Reason_ID,FALSE)
        ) SP_CallHeldReason
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Call_Held_Reason_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_CallHeldReasons
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.CallHeldReasons',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(chr.CallHeldReason) as CallHeldReasons
   FROM K_seatool_tld_SP_CallHeldReasons sp
   JOIN K_seatool_tld_Call_Held_Reasons chr ON sp.Call_Held_Reason_ID = chr.Call_Held_Reason_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_Code_After_Init_Assess
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_Code_After_Init_Assess',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Code_after_init_assess_ID,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         Code_after_init_assess_ID := LATEST_BY_OFFSET(payload->after->Code_after_init_assess_ID,FALSE)
        ) SP_InitAccess
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Code_after_init_assess_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Code_After_Init_Assess
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.Code_after_init_assess',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(ca.InitAssess) as CodeAfterInitAccess
   FROM K_seatool_tld_SP_Code_After_Init_Assess sp
   JOIN K_seatool_tld_Code_After_Init_Assess ca ON sp.Code_after_init_assess_ID = ca.Code_after_init_assess_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_Components
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_Components',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Component_ID,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         Component_ID := LATEST_BY_OFFSET(payload->after->Component_ID,FALSE)
        ) SP_Component
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Component_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Components
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.Components',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(c.Component) as Components
   FROM K_seatool_tld_SP_Components sp
   JOIN K_seatool_tld_Components c ON sp.Component_ID = c.Component_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_OCD_Review
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_OCD_Review',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->OCD_Review_ID,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         OCD_Review_ID := LATEST_BY_OFFSET(payload->after->OCD_Review_ID,FALSE)
        ) SP_OCDReview
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->OCD_Review_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_OCD_Review
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.OCD_Review',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(orv.OCDReview) as OCDReview
   FROM K_seatool_tld_SP_OCD_Review sp
   JOIN K_seatool_tld_OCD_Review orv ON sp.OCD_Review_ID = orv.OCD_Review_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_Officers
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_Officers',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number ,
        ifnull(payload->after->RO_Analyst_ID, -1) RO_Analyst_ID,
        ifnull(payload->after->Backup_Program_Analyst_ID, -1) Backup_Program_Analyst_ID,
        ifnull(payload->after->Backup_FM_Analyst_ID, -1) Backup_FM_Analyst_ID,
        ifnull(payload->after->Lead_Analyst_ID, -1) Lead_Analyst_ID,
        STRUCT (
          ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
          RO_Analyst_ID := LATEST_BY_OFFSET(payload->after->RO_Analyst_ID,FALSE),
          Backup_Program_Analyst_ID := LATEST_BY_OFFSET(payload->after->Backup_Program_Analyst_ID,FALSE),
          Backup_FM_Analyst_ID := LATEST_BY_OFFSET(payload->after->Backup_FM_Analyst_ID,FALSE),
          Lead_Analyst_ID := LATEST_BY_OFFSET(payload->after->Lead_Analyst_ID,FALSE)
         ) SP_Officer
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number,
       ifnull(payload->after->RO_Analyst_ID, -1),
       ifnull(payload->after->Backup_Program_Analyst_ID, -1),
       ifnull(payload->after->Backup_FM_Analyst_ID, -1),
       ifnull(payload->after->Lead_Analyst_ID, -1)
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_RO_Analyst_Officers
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.RAnalyst_Officers',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(o.Officer) as RO_Analyst_Officers
   FROM K_seatool_tld_SP_Officers sp
   JOIN K_seatool_tld_Officers o ON sp.RO_Analyst_ID = o.Officer_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Program_Analyst_Officers
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.ProgramAnalyst_Officers',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(o.Officer) as Program_Analyst_Officers
   FROM K_seatool_tld_SP_Officers sp
   JOIN K_seatool_tld_Officers o ON sp.Backup_Program_Analyst_ID = o.Officer_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_FM_Analyst_Officers
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.FM_Analyst_Officers',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(o.Officer) as FM_Analyst_Officers
   FROM K_seatool_tld_SP_Officers sp
   JOIN K_seatool_tld_Officers o ON sp.Backup_FM_Analyst_ID = o.Officer_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Lead_Analyst_Officers
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.Lead_Analyst_Officers',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(o.Officer) as Lead_Analyst_Officers
   FROM K_seatool_tld_SP_Officers sp
   JOIN K_seatool_tld_Officers o ON sp.Lead_Analyst_ID = o.Officer_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_PriorityCodes
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_PriorityCodes',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Priority_Code_ID,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         Priority_Code_ID := LATEST_BY_OFFSET(payload->after->Priority_Code_ID,FALSE)
        ) SP_PriorityCode
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Priority_Code_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Priority_Codes
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.Priority_Codes',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(pc.PriorityCode) as PriorityCodes
   FROM K_seatool_tld_SP_PriorityCodes sp
   JOIN K_seatool_tld_Priority_Codes pc ON sp.Priority_Code_ID = pc.Priority_Code_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_PriorityComplexity
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_PriorityComplexity',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Priority_Complexity_ID,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         Priority_Complexity_ID := LATEST_BY_OFFSET(payload->after->Priority_Complexity_ID,FALSE)
        ) SP_PriorityComplexity
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Priority_Complexity_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Priority_Complexity
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.Priority_Complexity',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(pc.PriorityComplexity) as PriorityComplexity
   FROM K_seatool_tld_SP_PriorityComplexity sp
   JOIN K_seatool_tld_Priority_Complexity pc ON sp.Priority_Complexity_ID = pc.Priority_Complexity_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_PriorityReviewPosition
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_PriorityReviewPosition',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Review_Position_ID,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         Review_Position_ID := LATEST_BY_OFFSET(payload->after->Review_Position_ID,FALSE)
        ) SP_PriorityReviewPosition
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Review_Position_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Review_Position
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.Review_Position',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(rp.PriorityReviewPosition) as ReviewPosition
   FROM K_seatool_tld_SP_PriorityReviewPosition sp
   JOIN K_seatool_tld_Priority_Review_Position rp ON sp.Review_Position_ID = rp.Review_Position_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_Region
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_Region',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Region_ID,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         Region_ID := LATEST_BY_OFFSET(payload->after->Region_ID,FALSE)
        ) SP_Region
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Region_ID
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_Region
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.Region',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(r.Region) as Region
   FROM K_seatool_tld_SP_Region sp
   JOIN K_seatool_tld_Region r ON sp.Region_ID = r.Region_ID
 GROUP BY sp.ID_Number
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_States
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_States',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->State_Code,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         State_Code := LATEST_BY_OFFSET(payload->after->State_Code,FALSE)
        ) SP_State
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->State_Code
EMIT CHANGES;

CREATE TABLE IF NOT EXISTS K_seatool_agg_States
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.States',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT sp.ID_Number,
        COLLECT_LIST(S.State) as States
   FROM K_seatool_tld_SP_States sp
   JOIN K_seatool_tld_States s ON sp.State_Code = s.State_Code
 GROUP BY sp.ID_Number
EMIT CHANGES;


CREATE TABLE IF NOT EXISTS K_seatool_tld_SP_Type
 WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.tld.SP_Type',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
 SELECT payload->after->ID_Number,
        payload->after->Type_ID,
        STRUCT (
         ID_Number := LATEST_BY_OFFSET(payload->after->ID_Number,FALSE),
         Type_ID := LATEST_BY_OFFSET(payload->after->Type_ID,FALSE)
        ) SP_Type
   FROM K_seatool_State_Plan_stream sp
 GROUP BY payload->after->ID_Number, payload->after->Type_ID
EMIT CHANGES;
