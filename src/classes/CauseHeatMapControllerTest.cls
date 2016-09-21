@isTest
public class CauseHeatMapControllerTest {
	private static testmethod void runTest(){
        list<Harm__c> harmList = new list<Harm__c>();
        
        Harm__c h1 = new Harm__c(Name='harm 1', Severity_of_Harm__c = 'S1', Probability_of_harm__c = 'Unlikely');
        harmList.add(h1);
        
        Harm__c h2 = new Harm__c(Name='harm 2', Severity_of_Harm__c = 'S2', Probability_of_harm__c = 'Rare');
        harmList.add(h2);
        
        Harm__c h3 = new Harm__c(Name='harm 3', Severity_of_Harm__c = 'S3', Probability_of_harm__c = 'Possible');
        harmList.add(h3);
        
        Harm__c h4 = new Harm__c(Name='harm 4', Severity_of_Harm__c = 'S4', Probability_of_harm__c = 'Likely');
        harmList.add(h4);
        
        Harm__c h5 = new Harm__c(Name='harm 4', Severity_of_Harm__c = 'S5', Probability_of_harm__c = 'Almost Certain');
        harmList.add(h5);
        
        insert harmList;
        
        list<Cause__c> causeList = new List<Cause__c>();
        Cause__c cause;
        cause = new Cause__c(Name='Test Cause 00');
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 11');
        cause.Harm__c = h1.Id;
        cause.Pre_Probability__c = 'Unlikely';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 12');
        cause.Harm__c = h1.Id;
        cause.Pre_Probability__c = 'Possible';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 13');
        cause.Harm__c = h1.Id;
        cause.Pre_Probability__c = 'Occasional';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 14');
        cause.Harm__c = h1.Id;
        cause.Pre_Probability__c = 'Remote';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 15');
        cause.Harm__c = h1.Id;
        cause.Pre_Probability__c = 'Unlikely';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 21');
        cause.Harm__c = h2.Id;
        cause.Pre_Probability__c = 'Possible';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 22');
        cause.Harm__c = h2.Id;
        cause.Pre_Probability__c = 'Occasional';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 23');
        cause.Harm__c = h2.Id;
        cause.Pre_Probability__c = 'Remote';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 24');
        cause.Harm__c = h2.Id;
        cause.Pre_Probability__c = 'Unlikely';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 25');
        cause.Harm__c = h2.Id;
        cause.Pre_Probability__c = 'Possible';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 31');
        cause.Harm__c = h3.Id;
        cause.Pre_Probability__c = 'Occasional';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 32');
        cause.Harm__c = h3.Id;
        cause.Pre_Probability__c = 'Remote';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 33');
        cause.Harm__c = h3.Id;
        cause.Pre_Probability__c = 'Unlikely';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 34');
        cause.Harm__c = h3.Id;
        cause.Pre_Probability__c = 'Possible';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 35');
        cause.Harm__c = h3.Id;
        cause.Pre_Probability__c = 'Occasional';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 41');
        cause.Harm__c = h4.Id;
        cause.Pre_Probability__c = 'Remote';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 42');
        cause.Harm__c = h4.Id;
        cause.Pre_Probability__c = 'Unlikely';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 43');
        cause.Harm__c = h4.Id;
        cause.Pre_Probability__c = 'Possible';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 44');
        cause.Harm__c = h4.Id;
        cause.Pre_Probability__c = 'Occasional';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 45');
        cause.Harm__c = h4.Id;
        cause.Pre_Probability__c = 'Unlikely';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 51');
        cause.Harm__c = h5.Id;
        cause.Pre_Probability__c = 'Possible';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 52');
        cause.Harm__c = h5.Id;
        cause.Pre_Probability__c = 'Occasional';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 53');
        cause.Harm__c = h5.Id;
        cause.Pre_Probability__c = 'Remote';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 54');
        cause.Harm__c = h5.Id;
        cause.Pre_Probability__c = 'Unlikely';
        causeList.add(cause);
        
        cause = new Cause__c(Name='Test Cause 55');
        cause.Harm__c = h5.Id;
        cause.Pre_Probability__c = 'Possible';
        causeList.add(cause);
        
        insert causeList;
        
        CauseHeatMapController MMC = new CauseHeatMapController();
        MMC.getHazardFilteroptions();
        MMC.getHazardSituationFilteroptions();
        MMC.getPreProbabilityFilteroptions() ;
        MMC.getPreProbabilityOfOccOfHarmFilteroptions() ;
        MMC.getSeverityOfHarmFilteroptions();
        MMC.getCauseList () ;
        MMC.cX = 1;
        MMC.cY = 1;
        MMC.getCauseList () ;
        MMC.filterCauseList() ;
        MMC.clearfilter() ;
        MMC.cancelFilter() ;
        MMC.refreshCauseListWithCoordinates() ;
        MMC.getChooserender() ;
        MMC.deliverAsPDF() ;
    }
}