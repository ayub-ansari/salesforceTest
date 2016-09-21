public class UpdateQuaterlyReviewStatus {
    String status;
    String riskId;
    public UpdateQuaterlyReviewStatus(){
        riskId = ApexPages.currentPage().getParameters().get('id');
        status= ApexPages.currentPage().getParameters().get('status');        
    }
     public PageReference updateStatus(){ 
         if(riskId != null && status != null){
            MLN_Risk__c risk = [SELECT Id,Quarterly_Review_Status__c,Quarterly_Review_Status_Track__c FROM MLN_Risk__c WHERE Id=:riskId];
            risk.Quarterly_Review_Status__c = status;
            risk.Quarterly_Review_Status_Track__c = status + ' '+system.now().format('MM/dd/yyyy HH:mm:ss');
            update risk;
            return new PageReference('/'+riskId);
         }
         return null;
     }
}