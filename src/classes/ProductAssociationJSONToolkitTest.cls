@isTest
private class ProductAssociationJSONToolkitTest {
	static final String VENDOR_LOCATION_CONST = 'Test Vendor Location';
	static final String GOVERNANCE_CONST = 'Test Governance';
	static final String COMMITTEE_CONST = 'Test Committee';
	static final String OBJECTIVE_CONST = 'Test Objective';
	
	static String JSONResult;
	
	static {
		Product__c product = new Product__c(Name = 'Test');
    	insert product;
    	
    	Vendor_Location__c vendorLocation = new Vendor_Location__c(Name = VENDOR_LOCATION_CONST);
    	insert vendorLocation;
    	Product_Vendor_Location_Association__c productVendorLocationAssociation = new Product_Vendor_Location_Association__c(Product__c = product.Id, Vendor_Location__c = vendorLocation.Id);
    	insert productVendorLocationAssociation;
    	
    	Governance__c governance = new Governance__c(Name = GOVERNANCE_CONST);
    	insert governance;
    	Product_Governance_Association__c productGovernanceAssociation = new Product_Governance_Association__c(Product__c = product.Id, Governance__c = governance.Id);
    	insert productGovernanceAssociation;
    	
    	Committees__c committee = new Committees__c(Name = COMMITTEE_CONST);
    	insert committee;
    	Product_Committee_Association__c productCommitteeAssociation = new Product_Committee_Association__c(Product__c = product.Id, Committees__c = committee.Id);
    	insert productCommitteeAssociation;
    	
    	Objectives__c objective = new Objectives__c(Name = OBJECTIVE_CONST);
    	insert objective;
    	Product_Objective_Association__c productObjectiveAssociation = new Product_Objective_Association__c(Product__c = product.Id, Objectives__c = objective.Id);
    	insert productObjectiveAssociation;
    	
    	Product__c prd = [Select Id From Product__c limit 1];
        String prdId = prd.Id;
        JSONResult = ProductAssociationJSONToolkit.toJSON(prd.Id);
	}
	
    static testMethod void testVendorLocation() {
        Integer i = 0;
        JSONParser parser = JSON.createParser(JSONResult);
        while (parser.nextToken() != null) {
        	if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'name') {
				i++;
				if (i == 3) {
					parser.nextToken();
					break;
				}
        	}
        }
        
        String vendorName = parser.getText();
        System.assert(vendorName == VENDOR_LOCATION_CONST);
    }
}