@isTest
private class RiskHistoryComponentControllerTest {
    static final Date VALID_DATE = Date.today().addYears(-4);
    static final String RISK_NAME = 'Test Risk';
    static Risk__c risk;

    static {
        risk = new Risk__c(Name = RISK_NAME);
        insert risk;

        List<Risk_History__c> riskhistories = new List<Risk_History__c>();
        Risk_History__c  rh = new Risk_History__c (Expected_Current_Impact_New__c=null,
                                                 Expected_Current_Likelihood_New__c=null,
                                                 Expected_Inherent_Impact_New__c=4,
                                                 Expected_Inherent_Likelihood_New__c=4,
                                                 Expected_Target_Impact_New__c=2,
                                                 Expected_Target_Likelihood_New__c=2,
                                                 Risk__c = risk.Id,
                                                 Valuation_Date__c = VALID_DATE
                                                 );
        riskhistories.add(rh);
        
        Risk_History__c  rh0 = new Risk_History__c (Expected_Current_Impact_New__c=4,
                                                 Expected_Current_Likelihood_New__c=4,
                                                 Expected_Inherent_Impact_New__c=null,
                                                 Expected_Inherent_Likelihood_New__c=null,
                                                 Expected_Target_Impact_New__c=3,
                                                 Expected_Target_Likelihood_New__c=3,
                                                 Risk__c = risk.Id,
                                                 Valuation_Date__c = VALID_DATE
                                                 );
        riskhistories.add(rh0);
        
        Risk_History__c  rh1 = new Risk_History__c (Expected_Current_Impact_New__c=4,
                                                 Expected_Current_Likelihood_New__c=4,
                                                 Expected_Inherent_Impact_New__c=5,
                                                 Expected_Inherent_Likelihood_New__c=5,
                                                 Expected_Target_Impact_New__c=null,
                                                 Expected_Target_Likelihood_New__c=null,
                                                 Risk__c = risk.Id,
                                                 Valuation_Date__c = VALID_DATE
                                                 );
        riskhistories.add(rh1);
        insert riskhistories;
        
        RiskHistoryComponentController.myObject = [Select Id From Risk__c Limit 1];
        RiskHistoryComponentController rhcc = new RiskHistoryComponentController();
        //RiskHistoryComponentController.objectHistoryLine[] ohl = new RiskHistoryComponentController.objectHistoryLine[]{};
        RiskHistoryComponentController.objectHistoryLine[] ohl = rhcc.getCustomHistory();
        
        System.assert(rhcc.listSize == 4);
    }
    
    static testMethod void testNoHistory() {
        List<Risk_History__c> foo = [ SELECT Id FROM Risk_History__c WHERE Risk__c = :risk.Id ];
        delete foo;
        
        RiskHistoryComponentController.myObject = [Select Id From Risk__c Limit 1];
        RiskHistoryComponentController rhcc = new RiskHistoryComponentController();
        RiskHistoryComponentController.objectHistoryLine[] ohl = new RiskHistoryComponentController.objectHistoryLine[]{};
        ohl = rhcc.getCustomHistory ();
        
        System.assert(rhcc.listSize == 0);
    }
}