@isTest
private class RiskAssociationJSONToolkitTest {
    static final String CONTROL_CONST = 'Test Control';
    static final String PROCESS_CONST = 'Test Process';
    static final String OBJECTIVE_CONST = 'Test Objective';
    static final String INDICATOR_CONST = 'Test Indicator';
    static final String INCIDENT_CONST = 'Test Incident';
    static final String COMMITTEE_CONST = 'Test Committee';
    static final String ASSUMPTION_CONST = 'Test Assumption';
    static final String GENERAL_LEDGER_CONST = 'Test General Ledger';
    static final String PROJECT_CONST = 'Test Project';
    static final String LITIGATION_CONST = 'Test Litigation';
    static final String GOVERNANCE_CONST = 'Test Governance';
    static final String AUDIT_NAME_CONST = 'Test Audit';
    static final String AUDIT_DESC_CONST = 'Test Audit Description';
    static final String CONTACT_FIRST_NAME = 'John';
    static final String CONTACT_LAST_NAME = 'Shmoe';
    static final String HIERARCHY_NODE_KEY = 'Foo';
    static final Integer HIERARCHY_NODE_LEVEL = 1;
    static final String RISK_CONST = 'Test Risk';
    
    static String JSONResult;
    
    static {
        Risk__c risk = new Risk__c(Name = RISK_CONST);
        insert risk;
        
        Controls__c control = new Controls__c(Name = CONTROL_CONST);
        insert control;
        Risk_Controls_Association__c riskControlsAssociation = new Risk_Controls_Association__c(Risk__c = risk.Id, Controls__c = control.Id);
        insert riskControlsAssociation;
        
        Process__c processObj = new Process__c(Name = PROCESS_CONST);
        insert processObj;
        Risk_Process_Association__c riskProcessAssociation = new Risk_Process_Association__c(Risk__c = risk.Id, Process__c = processObj.Id);
        insert riskProcessAssociation;
        
        Objectives__c objective = new Objectives__c(Name = OBJECTIVE_CONST);
        insert objective;
        Risk_Objective_Association__c riskObjectiveAssociation = new Risk_Objective_Association__c(Risk__c = risk.Id, Objectives__c = objective.Id);
        insert riskObjectiveAssociation;
        
        Indicator__c indicator = new Indicator__c(Name = INDICATOR_CONST);
        insert indicator;
        Risk_Indicator_Association__c riskIndicatorAssociation = new Risk_Indicator_Association__c(Risk__c = risk.Id, Indicator__c = indicator.Id);
        insert riskIndicatorAssociation;
        
        Incident__c incident = new Incident__c(Name = INCIDENT_CONST);
        insert incident;
        Risk_Incidents_Association__c riskIncidentsAssociation = new Risk_Incidents_Association__c(Risk__c = risk.Id, Incident__c = incident.Id);
        insert riskIncidentsAssociation;
        
        Committees__c committee = new Committees__c(Name = COMMITTEE_CONST);
        insert committee;
        Risk_Committee_Association__c riskCommitteeAssociation = new Risk_Committee_Association__c(Risk__c = risk.Id, Committees__c = committee.Id);
        insert riskCommitteeAssociation;
        
        Assumption__c assumption = new Assumption__c(Name = ASSUMPTION_CONST);
        insert assumption;
        Risk_Assumption_Association__c riskAssumptionAssociation = new Risk_Assumption_Association__c(Risks__c = risk.Id, Assumptions__c = assumption.Id);
        insert riskAssumptionAssociation;
        
        General_Ledger__c generalLedger = new General_Ledger__c(Name = GENERAL_LEDGER_CONST, GL_Short_Description__c=GENERAL_LEDGER_CONST);
        insert generalLedger;
        Risk_GL_Association__c riskGLAssociation = new Risk_GL_Association__c(Risk__c = risk.Id, General_Ledger__c = generalLedger.Id);
        insert riskGLAssociation;
        
        Project__c project = new Project__c(Name = PROJECT_CONST);
        insert project;
        Risk_Project_Association__c riskProjectAssociation = new Risk_Project_Association__c(Risk__c = risk.Id, Project__c = project.Id);
        insert riskProjectAssociation;
        
        Litigation__c litigation = new Litigation__c(Name = LITIGATION_CONST);
        insert litigation;
        Litigation_Risk_Association__c litigationRiskAssociation = new Litigation_Risk_Association__c(Risk__c = risk.Id, Litigation__c = litigation.Id);
        insert litigationRiskAssociation;
        
        Governance__c governance = new Governance__c(Name = GOVERNANCE_CONST);
        insert governance;
        Governance_Risk_Association__c governanceRiskAssociation = new Governance_Risk_Association__c(Risks__c = risk.Id, Governance__c = governance.Id);
        insert governanceRiskAssociation;
        
        Audit__c audit = new Audit__c(Name = AUDIT_NAME_CONST, Audit_Item_Description__c = AUDIT_DESC_CONST);
        insert audit;
        Audit_Risk_Association__c auditRiskAssociation = new Audit_Risk_Association__c(Risk__c = risk.Id, Audit__c = audit.Id);
        insert auditRiskAssociation;
        
        Contact contact = new Contact(FirstName = CONTACT_FIRST_NAME, LastName = CONTACT_LAST_NAME);
        insert contact;
        Risk_Stakeholder_Association__c riskStakeholderAssociation = new Risk_Stakeholder_Association__c(Risk__c = risk.Id, Stakeholder__c = contact.Id);
        insert riskStakeholderAssociation;
        
        rkl__RK_Hierarchy_Node__c node = new rkl__RK_Hierarchy_Node__c(rkl__Node_Key__c = HIERARCHY_NODE_KEY, rkl__Node_Level__c = HIERARCHY_NODE_LEVEL);
        insert node;
        Location_Risk_Association__c locationRiskAssociation = new Location_Risk_Association__c(Risk__c = risk.Id, RK_Hierarchy__c = node.Id);
        insert locationRiskAssociation;
        
        Risk_Correlation__c riskCorrelation = new Risk_Correlation__c(Risk_Name_1__c = risk.Id, Risk_Name_2__c = risk.Id, Risk_Correlation__c = 1.0);
        insert riskCorrelation;
        
        Risk__c risk2 = new Risk__c(Name = RISK_CONST);
        insert risk2;
        
        Risk_Correlation__c riskCorrelation2 = new Risk_Correlation__c(Risk_Name_1__c = risk2.Id, Risk_Name_2__c = risk.Id, Risk_Correlation__c = 1.0);
        insert riskCorrelation2;
        
        Risk__c rsk = [Select Id From Risk__c limit 1];
        String rksId = rsk.Id;
        JSONResult = RiskAssociationJSONToolkit.toJSON(rsk.Id);
    }
    
    static testMethod void testControl() {
        Integer i = 0;
        JSONParser parser = JSON.createParser(JSONResult);
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'name') {
                i++;
                if (i == 3) {
                    parser.nextToken();
                    break;
                }
            }
        }
        
        String controlName = parser.getText();
        System.assert(controlName == CONTROL_CONST);
    }
}