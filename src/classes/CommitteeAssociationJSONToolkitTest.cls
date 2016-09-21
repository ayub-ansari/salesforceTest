@isTest
public class CommitteeAssociationJSONToolkitTest {
  
  static final String CONTACT_CONST = 'Test Contact';
  static final String INDICATOR_CONST = 'Test Indicator';
  static final String CONTROL_CONST = 'Test Control';
  static final String RISK_CONST = 'Test Risk';
  static final String PRODUCT_CONST = 'Test Product';
  
  static String JSONResult;
  
  
  static {
    Committees__c committee = new Committees__c(Name = 'Test');
      insert committee;
     
      Risk__c risk = new Risk__c(Name = RISK_CONST);
      insert risk;
      Risk_Committee_Association__c riskCommitteeAssociation = new Risk_Committee_Association__c(Committees__c = committee.Id, Risk__c = risk.Id);
      insert riskCommitteeAssociation;
      
      Contact contact = new Contact (LastName = CONTACT_CONST);
      insert contact;
      Committee_Contact_Association__c committeeContactAssociation = new Committee_Contact_Association__c(Committees__c = committee.id, Contact__c = contact.id);
      insert committeeContactAssociation;
     
      Controls__c control = new Controls__c(Name = CONTROL_CONST);
      insert control;
      Control_Committee_Association__c controlCommitteeAssociation = new Control_Committee_Association__c(Committees__c = committee.Id, Controls__c = control.Id);
      insert controlCommitteeAssociation;
      
      Indicator__c indicator = new Indicator__c(Name = INDICATOR_CONST);
      insert indicator;
      Indicator_Committee_Association__c indicatorCommitteeAssociation = new Indicator_Committee_Association__c(Committees__c = committee.Id, Indicator__c = indicator.Id);
      insert indicatorCommitteeAssociation;
      
      Product__c product = new Product__c(Name = Product_CONST);
      insert product;
      Product_Committee_Association__c productCommitteeAssociation = new Product_Committee_Association__c(Committees__c = committee.Id, Product__c = product.Id);
      insert productCommitteeAssociation;
      
      JSONResult = CommitteeAssociationJSONToolkit.toJSON(committee.Id);  
      }
      
      
 static testMethod void testCommittee() {
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

    String contactName = parser.getText();
    System.assert(contactName == CONTACT_CONST);
  }      
}