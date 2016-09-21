public class RiskHistoryComponentController {
 
    public class objectHistoryLine {
        public Date valuationDate {get; set;}
        public Decimal currentRiskScore {get; set;}
        public Decimal currentRiskScoreInherent {get; set;}
        public Decimal currentRiskScoreTarget {get; set;}                
    }
        
    // External variables
    public static SObject myObject {get; set;}
    public Integer listSize {get; set;}
    
    public objectHistoryLine[] getCustomHistory () {
        Id riskId = String.valueOf(myObject.get('Id'));
        List<Risk_History__c> rhList = [Select   Expected_Current_Impact_New__c, 
                                                 Expected_Current_Likelihood_New__c,
                                                 Expected_Inherent_Impact_New__c,
                                                 Expected_Inherent_Likelihood_New__c,
                                                 Expected_Target_Impact_New__c,
                                                 Expected_Target_Likelihood_New__c,
                                                 Valuation_Date__c,
                                                 Risk__c
                                        From     Risk_History__c
                                        Where    Risk__c =: riskId  
                                        And      Valuation_Date__c >= LAST_N_YEARS:5
                                        Order By Valuation_Date__c];
        
        List<objectHistoryLine> ohl = new List<objectHistoryLine>();   
        listSize = rhList.size();
        
        if (rhList.size() > 0) { 
            for (Risk_History__c h: rhList) {
                objectHistoryLine h1 = new objectHistoryLine();
                h1.valuationDate = h.Valuation_Date__c;
                if (h.Expected_Current_Impact_New__c != null && h.Expected_Current_Likelihood_New__c != null) {
                    h1.currentRiskScore = h.Expected_Current_Impact_New__c * h.Expected_Current_Likelihood_New__c;}
                else h1.currentRiskScore = 0;
                if (h.Expected_Inherent_Impact_New__c != null && h.Expected_Inherent_Likelihood_New__c != null) {    
                    h1.currentRiskScoreInherent = h.Expected_Inherent_Impact_New__c * h.Expected_Inherent_Likelihood_New__c;}
                else h1.currentRiskScoreInherent = 0;
                if (h.Expected_Target_Impact_New__c != null && h.Expected_Target_Likelihood_New__c != null) {   
                    h1.currentRiskScoreTarget = h.Expected_Target_Impact_New__c * h.Expected_Target_Likelihood_New__c;}
                else h1.currentRiskScoreTarget = 0;
                ohl.add(h1);
            }
        }
        else {
            objectHistoryLine h1 = new objectHistoryLine();
            h1.currentRiskScore = 0;
            h1.currentRiskScoreInherent = 0;
            h1.currentRiskScoreTarget = 0;
            ohl.add(h1);
        }
/*
        for (Risk_History__c h: rhList) {
            if (h.Expected_Inherent_Impact_New__c != null && h.Expected_Inherent_Likelihood_New__c != null) {
                objectHistoryLine h1 = new objectHistoryLine();
                h1.valuationDate = h.Valuation_Date__c;
                h1.currentRiskScoreInherent = h.Expected_Inherent_Impact_New__c * h.Expected_Inherent_Likelihood_New__c;
                ohl.add(h1);
            }
        }

        for (Risk_History__c h: rhList) {
            if (h.Expected_Target_Impact_New__c != null && h.Expected_Target_Likelihood_New__c != null) {
                objectHistoryLine h1 = new objectHistoryLine();
                h1.valuationDate = h.Valuation_Date__c;
                h1.currentRiskScoreTarget = h.Expected_Target_Impact_New__c * h.Expected_Target_Likelihood_New__c;
                ohl.add(h1);
            }
        }
*/
        return ohl;   
    }
}