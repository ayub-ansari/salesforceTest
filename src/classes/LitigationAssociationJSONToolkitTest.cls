@isTest
public class LitigationAssociationJSONToolkitTest {
  
  static final String COMPLIANCE_CONST = 'Test Compliance';
  static final String RISK_CONST = 'Test Risk';
  static final String VIOLATION_CONST = 'Test Violation';
  
  static String JSONResult;
  
  
  static {
    Litigation__c litigation = new Litigation__c(Name = 'Test');
      insert litigation;
     
      Risk__c risk = new Risk__c(Name = RISK_CONST);
      insert risk;
      Litigation_Risk_Association__c litigationRiskAssociation = new Litigation_Risk_Association__c(Litigation__c = litigation.Id, Risk__c = risk.Id);
      insert litigationRiskAssociation;
      
      Compliance__c compliance = new Compliance__c(Name = Compliance_CONST);
      insert compliance;
      Litigation_Compliance_Association__c litigationComplianceAssociation = new Litigation_Compliance_Association__c(Litigation__c = litigation.id, Compliance__c = compliance.id);
      insert litigationComplianceAssociation;
     
      Violation__c violation = new Violation__c();
      insert violation;
      Litigation_Violation_Association__c litigationViolationAssociation = new Litigation_Violation_Association__c(Litigation__c = litigation.Id, Violation__c = violation.Id);
      insert litigationViolationAssociation;
      
      JSONResult = LitigationAssociationJSONToolkit.toJSON(litigation.Id);  
      }
      
      
 static testMethod void testLitigation() {
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

    String riskName = parser.getText();
    //System.assert(riskName == RISK_CONST);
  } 

}