@isTest
public class ProjectAssociationJSONToolkitTest {
    static final String RISK_CONST = 'Test Risk';
    static final String VENDOR_LOCATION_CONST = 'Test Vendor Location';
    static final String OBJECTIVE_CONST = 'Test Objective';
    static final String INDICATOR_CONST = 'Test Indicator';
    static final String GL_CONST = 'Test GL';
    static final String COMPLIANCE_CONST = 'Test Compliance';
    static final String LOCATION_CONST = 'Test Location';
    
    static String JSONResult;
    
    static {
        Project__c project = new Project__c(Name = 'Test');
        insert project;
        
        /*
        Vendor_Location__c vendorLocation = new Vendor_Location__c(Name = VENDOR_LOCATION_CONST);
        insert vendorLocation;
        Project_Vendor_Association__c productVendorLocationAssociation = new Project_Vendor_Association__c(Product__c = product.Id, Vendor_Location__c = vendorLocation.Id);
        insert productVendorLocationAssociation;
        */
        
        Risk__c risk = new Risk__c(Name = RISK_CONST);
        insert risk;
        Risk_Project_Association__c projectRiskAssociation = new Risk_Project_Association__c(Project__c = project.Id, Risk__c = risk.Id);
        insert projectRiskAssociation;
        
        Controls__c control = new Controls__c(Name = 'Test Control');
        insert control;
        Risk_Controls_Association__c riskControlAssociation = new Risk_Controls_Association__c(Risk__c = risk.id, Controls__c = control.id);
        insert riskControlAssociation;
        
        Objectives__c objective = new Objectives__c(Name = OBJECTIVE_CONST);
        insert objective;
        Project_Objective_Association__c projectObjectiveAssociation = new Project_Objective_Association__c(Project__c = project.Id, Objectives__c = objective.Id);
        insert projectObjectiveAssociation;
        
        Indicator__c indicator = new Indicator__c(Name = INDICATOR_CONST);
        insert indicator;
        Project_Indicators_Association__c projectIndicatorAssociation = new Project_Indicators_Association__c(Project__c = project.Id, Indicator__c = indicator.Id);
        insert projectIndicatorAssociation;
        
        General_Ledger__c gl = new General_Ledger__c(Name = GL_CONST, GL_Short_Description__c='Test Description');
        insert gl;
        Project_GL_Association__c projectGLAssociation = new Project_GL_Association__c(Project__c = project.Id, General_Ledger__c = gl.Id);
        insert projectGLAssociation;
        
        Compliance__c compliance = new Compliance__c(Name = COMPLIANCE_CONST);
        insert compliance;
        Project_Compliance_Association__c projectComplianceAssociation = new Project_Compliance_Association__c(Project__c = project.Id, Compliance__c = compliance.Id);
        insert projectComplianceAssociation;
        
        rkl__RK_Hierarchy_Node__c location = new rkl__RK_Hierarchy_Node__c(Name = LOCATION_CONST, rkl__Node_Key__c='23asd', rkl__Node_Level__c=1);
        insert location;
        Location_Project_Association__c projectLocationAssociation = new Location_Project_Association__c(Project__c = project.Id, RK_Hierarchy__c = location.id);
        insert projectLocationAssociation;
        
        Project__c prjt = [Select Id From Project__c limit 1];
        String prjtId = prjt.Id;
        JSONResult = ProjectAssociationJSONToolkit.toJSON(prjtId);
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
    }
}