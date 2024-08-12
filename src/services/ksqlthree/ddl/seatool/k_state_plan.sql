SET 'auto.offset.reset' = 'earliest';

CREATE TABLE IF NOT EXISTS K_SEATool_agg_State_Plan
  WITH (KAFKA_TOPIC='${param:topicNamespace}aws.seatool.ksql.onemac.three.agg.State_Plan',KEY_FORMAT='JSON',WRAP_SINGLE_VALUE=FALSE) AS
    SELECT sp.ID_Number as ID_Number,
      STRUCT(
        State_Plan := sp.StatePlan,
        Action_Officers := ao.ActionOfficers,
        Components_SP := cs.ComponentsStatePlans,
        SP1115 := s1.StatePlan1115,
        SP_APD_Sub_Type := st.SubType,
        SP_Early_Alerts := ea.StatePlanEarlyAlerts,
        RAI := r.RAI,
        SP_APD := sa.StatePlanAPD,
        SP_Impact_Funding := sf.StatePlanImpactFunding,
        Stop_Resume_Dates := sd.StopResumeDates,
        ActionTypes := atp.ActionTypes,
        CallHeldReasons := chr.CallHeldReasons,
        CodeAfterInitAccess := ca.CodeAfterInitAccess,
        Components := c.Components,
        OCD_Review := orv.OCDReview,
        RO_Analyst := ro.RO_Analyst_Officers,
        Program_Analyst := pa.Program_Analyst_Officers,
        FM_Analyst := fm.FM_Analyst_Officers,
        Lead_Analyst := la.Lead_Analyst_Officers,
        Priority_Codes := pc.PriorityCodes,
        Priority_Complexity := px.PriorityComplexity, 
        Review_Position := p.ReviewPosition, 
        Region := rg.Region,
        States := s.States,
        State_Plan_ServiceTypes := spst.StatePlanServiceType,
        State_Plan_Service_SubTypes := spss.StatePlanServiceSubTypes
      ) as SP
      FROM K_seatool_tld_State_Plan sp
        LEFT JOIN K_seatool_agg_Action_Officers ao ON sp.ID_Number = ao.ID_Number
        LEFT JOIN K_seatool_agg_Components_StatePlans cs ON sp.ID_Number = cs.ID_Number
        LEFT JOIN K_seatool_agg_State_Plan_1115 s1 ON sp.ID_Number = s1.ID_Number
        LEFT JOIN K_seatool_agg_State_Plan_APD_Sub_Type st ON sp.ID_Number = st.ID_Number
        LEFT JOIN K_seatool_agg_State_Plan_Early_Alerts ea ON sp.ID_Number = ea.ID_Number
        LEFT JOIN K_seatool_agg_RAI r ON sp.ID_Number = r.ID_Number
        LEFT JOIN K_seatool_agg_State_Plan_APD sa ON sp.ID_Number = sa.ID_Number
        LEFT JOIN K_seatool_agg_State_Plan_Impact_Funding sf ON sp.ID_Number = sf.ID_Number
        LEFT JOIN K_seatool_agg_Stop_Resume_Dates sd ON sp.ID_Number = sd.ID_Number   
        LEFT JOIN K_seatool_agg_Action_Types atp ON sp.ID_Number = atp.ID_Number
        LEFT JOIN K_seatool_agg_CallHeldReasons chr ON sp.ID_Number = chr.ID_Number
        LEFT JOIN K_seatool_agg_Code_After_Init_Assess ca ON sp.ID_Number = ca.ID_Number
        LEFT JOIN K_seatool_agg_Components c ON sp.ID_Number = c.ID_Number
        LEFT JOIN K_seatool_agg_OCD_Review orv ON sp.ID_Number = orv.ID_Number
        LEFT JOIN K_seatool_agg_RO_Analyst_Officers ro ON sp.ID_Number = ro.ID_Number
        LEFT JOIN K_seatool_agg_Program_Analyst_Officers pa  ON sp.ID_Number = pa.ID_Number
        LEFT JOIN K_seatool_agg_FM_Analyst_Officers fm ON sp.ID_Number = fm.ID_Number
        LEFT JOIN K_seatool_agg_Lead_Analyst_Officers la ON sp.ID_Number = la.ID_Number
        LEFT JOIN K_seatool_agg_Priority_Codes pc ON sp.ID_Number = pc.ID_Number
        LEFT JOIN K_seatool_agg_Priority_Complexity px ON sp.ID_Number = px.ID_Number
        LEFT JOIN K_seatool_agg_Review_Position p ON sp.ID_Number = p.ID_Number
        LEFT JOIN K_seatool_agg_Region rg ON sp.ID_Number = rg.ID_Number
        LEFT JOIN K_seatool_agg_States s ON sp.ID_Number = s.ID_Number
        LEFT JOIN K_seatool_agg_Service_Types spst ON sp.ID_Number = spst.ID_Number
        LEFT JOIN K_seatool_agg_State_Plan_Service_SubTypes spss ON sp.ID_Number = spss.ID_Number
     WHERE sp.ID_Number IS NOT NULL
    PARTITION BY sp.ID_Number
EMIT CHANGES;
