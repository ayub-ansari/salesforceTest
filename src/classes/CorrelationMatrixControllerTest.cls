@isTest
public class CorrelationMatrixControllerTest{
    private static testmethod void runTest(){
        List<MLN_Risk__c> riskList = new List<MLN_Risk__c>();
        MLN_Risk__c risk;
        risk = new MLN_Risk__c(Name='Test Risk');
        insert risk;
        
        MLN_Risk__c risk1;
        risk1 = new MLN_Risk__c(Name='Test Risk1');
        insert risk1;
        
        Matrix__c mat = new Matrix__c(Description__c = 'Test',Type_of_Matrix__c='Likelihood');
        insert mat;
        
        Correlation__c cor = new Correlation__c(Correlation__c = 1,Matrix__c=mat.Id,Risk1__c = risk.Id,Risk2__c = risk1.Id);   
        insert cor;
        
        Correlation__c cor1 = new Correlation__c(Correlation__c = 1,Matrix__c=mat.Id,Risk1__c = risk1.Id,Risk2__c = risk.Id);   
        insert cor1;
        
        
        ApexPages.currentPage().getParameters().put('matrixID',mat.id);
        CorrelationMatrixController CMC = new CorrelationMatrixController();
        CMC.getRFoptions();
        CMC.getMXoptions() ;
        CMC.getCorrelationMap();
        CMC.filterRiskList();
        CMC.selCurMat = mat.Id;
        CMC.filterEXTMX();
        //CMC.saveMatrix();
        CMC.resetMatrix();
        CMC.RisksWithFilter();
        CMC.deleteMatrix();
        
        
        
    }
}