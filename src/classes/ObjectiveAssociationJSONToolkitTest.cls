@isTest
private class ObjectiveAssociationJSONToolkitTest {

    static final String OBJ_CONST = 'Test Objective';
    static final String GOVERNANCE_CONST = 'Test Governance';
    static final String AUDIT_NAME_CONST = 'Test Audit';
    static final String AUDIT_DESC_CONST = 'Test Audit Description';
    
    
    static String JSONResult;
    
    static {
        Objectives__c objective = new Objectives__c(Name = OBJ_CONST);
        insert objective;
        
        Governance__c governance = new Governance__c(Name = GOVERNANCE_CONST);
        insert governance;
        Governance_Objectives_Association__c governanceRiskAssociation = new Governance_Objectives_Association__c(Objectives__c = objective.Id, Governance__c = governance.Id);
        insert governanceRiskAssociation;
        
        Audit__c audit = new Audit__c(Name = AUDIT_NAME_CONST, Audit_Item_Description__c = AUDIT_DESC_CONST);
        insert audit;
        Audit_Objective_Association__c auditRiskAssociation = new Audit_Objective_Association__c(Objectives__c = objective.Id, Audit__c = audit.Id);
        insert auditRiskAssociation;
        /*
        Internal_Audit_Subtask__c internalauditsubtask = new Internal_Audit_Subtask__c();
        insert internalauditsubtask;
        Internal_Audit_Objective_Association__c internalAuditSubtaskRiskAssociation = new Internal_Audit_Objective_Association__c(Objectives__c = objective.Id, Internal_Audit_Subtask__c = internalauditsubtask.Id);
        insert internalAuditSubtaskRiskAssociation;
        */
        Objectives__c obj = [Select Id From Objectives__c limit 1];
        String objsId = obj.Id;
        JSONResult = ObjectiveAssociationJSONToolkit.toJSON(obj.Id);
    }
    
    
    static testMethod void testObjective() {
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
        
        String governanceName = parser.getText();
        //System.assert(governanceName == GOVERNANCE_CONST);
    }
    
}