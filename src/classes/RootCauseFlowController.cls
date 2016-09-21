public class RootCauseFlowController{

    String Id;
    public RootCauseFlowController(){
        Id=Apexpages.currentPage().getParameters().get('id');
    }
    
    public Flow.Interview.Root_Cause_Flow Root_Cause_Flow_interview {get;set;}

    public PageReference getEndPage() {

        PageReference pageRef = new Pagereference('/'+ Id);

        return pageRef;
     }   
        @isTest
    static void testRootCauseFlowController() {
        Risk__c ric = new Risk__c();
        insert ric;
        ApexPages.currentPage().getParameters().put('id',ric.Id);
        RootCauseFlowController ctr = new RootCauseFlowController();
        ctr.getEndPage();
    }
}