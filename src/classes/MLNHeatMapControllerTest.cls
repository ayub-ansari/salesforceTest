@isTest
public class MLNHeatMapControllerTest{
    private static testmethod void runTest(){
        List<MLN_Risk__c> riskList = new List<MLN_Risk__c>();
        MLN_Risk__c risk;
        risk = new MLN_Risk__c(Name='Test Risk');
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 1;
        risk.Current_Likelihood_Number__c = 1;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 1;
        risk.Current_Likelihood_Number__c = 2;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 1;
        risk.Current_Likelihood_Number__c = 3;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 1;
        risk.Current_Likelihood_Number__c = 4;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 1;
        risk.Current_Likelihood_Number__c = 5;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 2;
        risk.Current_Likelihood_Number__c = 1;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 2;
        risk.Current_Likelihood_Number__c = 2;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 2;
        risk.Current_Likelihood_Number__c = 3;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 2;
        risk.Current_Likelihood_Number__c = 4;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 2;
        risk.Current_Likelihood_Number__c = 5;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 3;
        risk.Current_Likelihood_Number__c = 1;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 3;
        risk.Current_Likelihood_Number__c = 2;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 3;
        risk.Current_Likelihood_Number__c = 3;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 3;
        risk.Current_Likelihood_Number__c = 4;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 3;
        risk.Current_Likelihood_Number__c = 5;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 4;
        risk.Current_Likelihood_Number__c = 1;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 4;
        risk.Current_Likelihood_Number__c = 2;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 4;
        risk.Current_Likelihood_Number__c = 3;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 4;
        risk.Current_Likelihood_Number__c = 4;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 4;
        risk.Current_Likelihood_Number__c = 5;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 5;
        risk.Current_Likelihood_Number__c = 1;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 5;
        risk.Current_Likelihood_Number__c = 2;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 5;
        risk.Current_Likelihood_Number__c = 3;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 5;
        risk.Current_Likelihood_Number__c = 4;
        riskList.add(risk);
        
        risk = new MLN_Risk__c(Name='Test Risk');
        risk.Current_Impact_Number__c = 5;
        risk.Current_Likelihood_Number__c = 5;
        riskList.add(risk);
        insert riskList;
        MLNHeatMapController MMC = new MLNHeatMapController();
        MMC.getRiskScore();
        MMC.getImpactFilteroptions();
        MMC.getLikelihoodFilteroptions();
        MMC.getPCFilteroptions() ;
        MMC.getRSFilteroptions() ;
        MMC.getRC1Filteroptions();
        MMC.getRiskList () ;
        MMC.filterRiskList() ;
        MMC.clearfilter() ;
        MMC.cancelFilter() ;
        MMC.refreshRiskListWithCoordinates() ;
        MMC.getChooserender() ;
        MMC.deliverAsPDF() ;
    }
}