public class OverrideUGIRisk {
    public UGI_Risk__c risk{get;set;}
    public string riskSource{get;set;}
    
    string retURL;
    public OverrideUGIRisk(ApexPages.standardController std){
        for(UGI_Risk__c r : [select Risk_Source__c from UGI_Risk__c where id =: std.getRecord().Id]){
            riskSource = r.Risk_Source__c;
        }
        
        risk = (UGI_Risk__c)std.getRecord();
        retURL = apexPages.currentPage().getParameters().get('retURL');
    }
    
    public list<riskHistoryWrapper> getRiskHistories(){
        list<riskHistoryWrapper> rHistoryList = new list<riskHistoryWrapper>();
        if(risk != null && risk.Id != null){
            for(UGI_Risk__History h : [Select CreatedDate, CreatedBy.Name, CreatedBy.Id, Field, NewValue, OldValue from UGI_Risk__History where ParentId =: risk.Id order by CreatedDate Desc]){
                rHistoryList.add(new riskHistoryWrapper(h));
            }
        }
        return rHistoryList;
    }
    
    public List<Schema.FieldSetMember> getIAFields() {
        return SObjectType.UGI_Risk__c.FieldSets.IA.getFields();
    }
    
    public List<Schema.FieldSetMember> getSOX_UGI_Energy_ServicesFields() {
        return SObjectType.UGI_Risk__c.FieldSets.SOX_UGI_Energy_Services.getFields();
    }
    
    public List<Schema.FieldSetMember> getAssessmentFields() {
        return SObjectType.UGI_Risk__c.FieldSets.Assessment.getFields();
    }
    
    public List<Schema.FieldSetMember> getSOXAmeriGasPartnersFields() {
        return SObjectType.UGI_Risk__c.FieldSets.SOX.getFields();
    }
    
    
    public List<Schema.FieldSetMember> getSERCFields() {
        return SObjectType.UGI_Risk__c.FieldSets.SERC.getFields();
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference(retURL);
        return pg;
    }
    
    public class riskHistoryWrapper{
        public UGI_Risk__History riskHistory{get;set;}
        public string action{get;set;}
        public riskHistoryWrapper(UGI_Risk__History riskHistory){
            this.riskHistory = riskHistory;
            if(riskHistory.Field == 'created'){
                action = 'Created';
            }else{
                action = 'Changed '+riskHistory.Field.removeEnd('__c');
            }
        }
    }
}