public class ReconciliationMemoController{
    
    public ERM_to_FM__c erm {get; set;}
    public MLN_Risk__c newRiskFactor {get; set;}
    public ERM_to_FM_Risk__c addRiskFactor {get; set;}
    
    ID ermID = ApexPages.currentPage().getParameters().get('Id');
    
    public ReconciliationMemoController(ApexPages.StandardController con){
        ERM_to_FM__c erm = [Select e.Name, e.Memo_Description__c, e.Memo_Date__c, e.Memo_Created_By__c, e.Id From ERM_to_FM__c e where ID =:ermID];
        newRiskFactor = new MLN_Risk__c();
        addRiskFactor = new ERM_to_FM_Risk__c();
    }
    
    public List<ERM_to_FM_Risk__c> ermList{get; set;}
    
    public List<ERM_to_FM_Risk__c> getEList(){
        ermList = [Select Id, Name, Model_Approach__c, Detailed_Structural_Stochastic_Model__c, FM_Specific_Risks__c, ERM_Risks__c, ERM_to_FM__c, Explanation__c, Residual_Standard_Deviation__c, Risk__c, Risk__r.Name, Simple_Stochastic_Model__c, ERM_Program_Identified_Risks__c From ERM_to_FM_Risk__c 
        			where ERM_to_FM__r.id =:ermID  ORDER BY Risk__r.Name NULLS LAST];
        return ermList;        
    }
    
    public pageReference saveChanges(){
     	update ermList;
        PageReference pageRef = new PageReference('/apex/ReconciliationMemo?id='+ermID);
        return pageRef;
    }
    
    public pageReference saveNewRF(){
        insert newRiskFactor;
        addRiskFactor.ERM_to_FM__c = ermID;
        addRiskFactor.Risk__c = newRiskFactor.id;
        insert addRiskFactor;
        newRiskFactor = new MLN_Risk__c();
        addRiskFactor = new ERM_to_FM_Risk__c();
        return null;
    }
    
    public pageReference addNewRF(){
        addRiskFactor.ERM_to_FM__c = ermID;
        insert addRiskFactor;        
        addRiskFactor = new ERM_to_FM_Risk__c();
        return null;
    }
    
    public string selectedRFId {get; set;}
    
    public void DeleteRiskFactor()
    {
        ERM_to_FM_Risk__c del = new ERM_to_FM_Risk__c(ID=selectedRFId);
        delete del;
    }   

}