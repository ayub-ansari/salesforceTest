public class RiskUpdateFlowController{

    public RiskUpdateFlowController(ApexPages.StandardController controller){}
    private final Risk__c risk {get;set;}
    public Flow.Interview.Risk_Update myflow {get;set;}


    String Id;
    public RiskUpdateFlowController(){
        Id=Apexpages.currentPage().getParameters().get('id');
    }



    public class risksList {
        public String riskName {get; set;}
        public Date lastAssessed {get; set;}
        public String riskDescription {get; set;}
		
		public risksList() {
			
		}
		
    }
    
    // External variables
    public SObject myObject {get; set;}
    
    public risksList[] getRisks () {
	
		List<Risk__c> rList;
		if (myflow != null) {
	        rList= [SELECT Id, Risk_Owner__c, Name, Last_Date_Risk_Assessed__c, Risk_Description__c
	        from Risk__c where Risk_Owner__c =: myflow.varContactId ];
		} else {
			rList = new List<Risk__c>();
		}
       
        
        List<risksList> rL = new List<risksList>();   
        
        if (rList.size() > 0) { 
            for (Risk__c r: rList) {
                risksList r1 = new risksList();
                r1.riskName = r.Name;
                r1.lastAssessed = r.Last_Date_Risk_Assessed__c;
                r1.riskDescription = r.Risk_Description__c;
                rL.add(r1);
            }
        }
        else {
            risksList r1 = new risksList();
            r1.riskName = 'No Risks';
            //r1.lastAssessed = 0;
            rL.add(r1);
        }

        return rL;   
    }

    public String getRender(){ 
        if (myflow == null)
    {
        return 'false' ;
    }
    else
    { 
        return  myflow.varRender;
    }
    }


    public PageReference getEndPage() {

        PageReference pageRef = new Pagereference('http://www.riskonnect.com');

        return pageRef;
     }
}