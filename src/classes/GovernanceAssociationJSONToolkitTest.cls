@isTest
public class GovernanceAssociationJSONToolkitTest {
  static final String COMPLIANCE_CONST = 'Test Compliance';
  static final String INDICATOR_CONST = 'Test Indicator';
  static final String OBJECTIVE_CONST = 'Test Objective';
  static final String RISK_CONST = 'Test Risk';
  static final String PRODUCT_CONST = 'Test Product';

  static String JSONResult;

  static {
    Governance__c governance = new Governance__c(Name = 'Test Governance');
    insert governance;

    Compliance__c compliance = new Compliance__c(Name = COMPLIANCE_CONST);
    insert compliance;
    Governance_Compliance_Association__c governanceComplianceAssoc = new Governance_Compliance_Association__c(Governance__c = governance.Id, Compliance__c = compliance.Id);
    insert governanceComplianceAssoc;

    Indicator__c indicator = new Indicator__c(Name = INDICATOR_CONST);
    insert indicator;
    Governance_Indicators_Association__c governanceIndicatorsAssoc = new Governance_Indicators_Association__c(Governance__c = governance.Id, Indicator__c = indicator.Id);
    insert governanceIndicatorsAssoc;

    Objectives__c objective = new Objectives__c(Name = OBJECTIVE_CONST);
    insert objective;
    Governance_Objectives_Association__c governanceObjectivesAssoc = new Governance_Objectives_Association__c(Governance__c = governance.Id, Objectives__c = objective.Id);
    insert governanceObjectivesAssoc;

    Risk__c risk = new Risk__c(Name = RISK_CONST);
    insert risk;
    Governance_Risk_Association__c governanceRiskAssoc = new Governance_Risk_Association__c(Governance__c = governance.Id, Risks__c = risk.Id);
    insert governanceRiskAssoc;

    Product__c product = new Product__c(Name = PRODUCT_CONST);
    insert product;
    Product_Governance_Association__c productGovernanceAssoc = new Product_Governance_Association__c(Governance__c = governance.Id, Product__c = product.Id);
    insert productGovernanceAssoc;

    JSONResult = GovernanceAssociationJSONToolkit.toJSON(governance.Id);
  }

  static testMethod void testGovernance() {
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
    System.assert(complianceName == COMPLIANCE_CONST);
  }
}