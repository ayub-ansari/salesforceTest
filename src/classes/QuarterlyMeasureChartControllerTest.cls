@isTest
public class QuarterlyMeasureChartControllerTest{
    public static testmethod  void runTest(){
        Key_Objective__c key = new Key_Objective__c(Name='Test Key',Category__c = 'Balance Sheet and Capital',Description__c = 'Test',Measured_Unit__c = 'Ratio%');
        insert key;
        List<Quarterly_Measure__c> qmList = new List<Quarterly_Measure__c>();
        Quarterly_Measure__c qm = new Quarterly_Measure__c(Key_Objective__c = key.id,Evaluation_Date__c = system.today().addDays(5),Quarterly_Goal__c = 1000,Quarterly_Measure__c = 100);
        qmList.add(qm);
        Quarterly_Measure__c qm1 = new Quarterly_Measure__c(Key_Objective__c = key.id,Evaluation_Date__c = system.today().addDays(5),Quarterly_Goal__c = null,Quarterly_Measure__c = 100);
        qmList.add(qm1);
        insert qmList;
        ApexPages.StandardController sc = new ApexPages.StandardController (key);
        QuarterlyMeasureChartController QMCC = new QuarterlyMeasureChartController(sc);
    }
}