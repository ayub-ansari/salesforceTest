@isTest
public class ContactAssociationJSONToolkitTest {
  static final String VENDOR_LOCATION_CONST = 'Test Vendor Location';
  static final String COMMITTEE_CONST = 'Test Committee';
  static final String COMPLIANCE_CONST = 'Test Compliance';
  static final String GOVERNANCE_CONST = 'Test Governance';
  static final String Location_CONST = 'Test Location';
  static final String RISK_CONST = 'Test Risk';
  
  static String JSONResult;
  
  static {
    
    Contact contact = new Contact(LastName = 'Test');
      insert contact;
      
      Committees__c committee = new Committees__c(Name = COMMITTEE_CONST);
      insert committee;
      Committee_Contact_Association__c a1 = new Committee_Contact_Association__c(Contact__c = contact.Id, Committees__c = committee.Id);
      insert a1;
            
      Compliance__c compliance = new Compliance__c(Name = COMPLIANCE_CONST);
      insert compliance;
      Compliance_Contact_Association__c a2 = new Compliance_Contact_Association__c(Contact__c = contact.Id, Compliance__c = compliance.Id);
      insert a2;
      /*
      Governance__c governance = new Governance__c(Name = GOVERNANCE_CONST);
      insert governance;
      Contact_Governance_Association__c a3 = new Contact_Governance_Association__c(Contact__c = contact.Id, Governance__c = governance.Id);
      insert a3;
      */
      rkl__RK_Hierarchy_Node__c location = new rkl__RK_Hierarchy_Node__c(Name = LOCATION_CONST, rkl__Node_Key__c = '0');
      insert location;
      Location_Contact_Association__c a4 = new Location_Contact_Association__c(Contact__c = contact.Id, RK_Hierarchy__c = location.Id);
      insert a4;
      
      Risk__c risk = new Risk__c(Name = RISK_CONST);
      insert risk;
      Risk_Stakeholder_Association__c a5 = new Risk_Stakeholder_Association__c(Stakeholder__c = contact.Id, Risk__c = risk.Id);
      insert a5;
      
      Contact cntct = [Select Id From Contact limit 1];
        String cntctId = cntct.Id;
        JSONResult = ContactAssociationJSONToolkit.toJSON(cntctId);
  }

  static testMethod void testContact() {
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

    String complianceName = parser.getText();
    //System.assert(complianceName == COMPLIANCE_CONST);
  }

}