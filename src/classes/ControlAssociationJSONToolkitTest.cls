@isTest
public class ControlAssociationJSONToolkitTest {
    static final String VENDOR_LOCATION_CONST = 'Test Vendor Location';
    static final String COMPLIANCE_CONST = 'Test Compliance';
    static final String INDICATOR_CONST = 'Test Indicator';
    static final String COMMITTEE_CONST = 'Test Committee';
    static final String AUDIT_CONST = 'Test Audit';
    static final String RISK_CONST = 'Test Risk';
    
    static String JSONResult;
    
    static {
        /*RecordType accountVendorRecordTypeID = [SELECT ID, Name FROM RecordType WHERE Name='rkgrc__Vendor' AND SobjectType='Account' limit 1];*/
        
        Controls__c control = new Controls__c(Name = 'Test');
        insert control;
        
        /*
        Account vendorLocation = new Account(Name = VENDOR_LOCATION_CONST, RecordType=accountVendorRecordTypeID);
        insert vendorLocation;
        Control_Vendor_Association__c controlVendorLocationAssociation = new Control_Vendor_Association__c(Controls__c = control.Id, Vendor__c = vendorLocation.Id);
        insert controlVendorLocationAssociation;
        */
        Compliance__c compliance = new Compliance__c(Name = COMPLIANCE_CONST);
        insert compliance;
        Control_Compliance_Association__c controlComplianceAssociation = new Control_Compliance_Association__c(Controls__c = control.Id, Compliance__c = compliance.Id);
        insert controlComplianceAssociation;
        
        Indicator__c indicator = new Indicator__c(Name = INDICATOR_CONST);
        insert indicator;
        Control_Indicator_Association__c controlIndicatorAssociation = new Control_Indicator_Association__c(Controls__c = control.Id, Indicator__c = indicator.Id);
        insert controlIndicatorAssociation;
        
        Committees__c committee = new Committees__c(Name = COMMITTEE_CONST);
        insert committee;
        Control_Committee_Association__c controlCommitteeAssociation = new Control_Committee_Association__c(Controls__c = control.Id, Committees__c = committee.Id);
        insert controlCommitteeAssociation;
        
        Audit__c audit = new Audit__c(Name = AUDIT_CONST, Audit_Item_Description__c='Test Description');
        insert audit;
        Audit_Control_Association__c controlAuditAssociation = new Audit_Control_Association__c(Controls__c = control.Id, Audit__c = audit.Id);
        insert controlAuditAssociation;
        
        Risk__c risk = new Risk__c(Name = RISK_CONST);
        insert risk;
        Risk_Controls_Association__c controlRiskAssociation = new Risk_Controls_Association__c(Controls__c = control.Id, Risk__c = risk.Id);
        insert controlRiskAssociation;
        
        Controls__c ctrl = [Select Id From Controls__c limit 1];
        String ctrlID = ctrl.Id;
        JSONResult = ControlAssociationJSONToolkit.toJSON(ctrlID);
    }
    
    static testMethod void testVendorLocation() {
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
    }
}