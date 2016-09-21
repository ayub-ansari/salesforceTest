global class ProjectAssociationJSONToolkit{
     webservice static String toJSON(String projectID)
    {
        //Project/Compliance Association
        //Project/GL Association
        //Project/Indicators Association
        //Project/Objective Association
        //Project/Vendor Association
        //Risk/Project Association
        //Location/Project Association
        
        
        List<String> categoryNames = new List<String>();
        categoryNames.add('Risks');
        categoryNames.add('Vendors');
        categoryNames.add('Objectives');
        categoryNames.add('Indicators');
        categoryNames.add('GLs');
        categoryNames.add('Compliance');
        categoryNames.add('Locations');
        
        List<Risk_Project_Association__c> risks = [SELECT Risk__r.Id, Risk__r.Name, Project__r.Id, Project__r.Name from Risk_Project_Association__c where Project__r.Id =:projectID];
        List<Project_Vendor_Association__c> vendors = [SELECT Project__r.Id, Project__r.Name, Vendor__r.Id, Vendor__r.Name from Project_Vendor_Association__c where Project__r.Id =:projectID];
        List<Project_Objective_Association__c> objectives = [SELECT Project__r.Id, Project__r.Name, Objectives__r.Id, Objectives__r.Name from Project_Objective_Association__c where Project__r.Id =:projectID];
        List<Project_Indicators_Association__c> indicators = [SELECT Project__r.Id, Project__r.Name, Indicator__r.Id, Indicator__r.Name from Project_Indicators_Association__c where Project__r.Id =:projectID];
        List<Project_GL_Association__c> gls = [SELECT Project__r.Id, Project__r.Name, General_Ledger__r.Id, General_Ledger__r.Name, General_Ledger__r.GL_Short_Description__c from Project_GL_Association__c where Project__r.Id =:projectID];
        List<Project_Compliance_Association__c> compliances = [SELECT Project__r.Id, Project__r.Name, Compliance__r.Id, Compliance__r.Name from Project_Compliance_Association__c where Project__r.Id =:projectID];
        List<Location_Project_Association__c> locations = [SELECT Project__r.Id, Project__r.Name, RK_Hierarchy__r.Id, RK_Hierarchy__r.Name from Location_Project_Association__c where Project__r.Id =:projectID];
        
        List<ID> matchingRiskIDs = new List<ID>();
        for (Risk_Project_Association__c riskProjRelationship : risks)
        {
            matchingRiskIDs.add(riskProjRelationship.Risk__r.Id);
        }
        
        List<Risk_Controls_Association__c> riskControls = [SELECT Risk__r.id, Risk__r.Name, Controls__r.Name, Controls__r.Id from Risk_Controls_Association__c where Risk__r.ID IN :matchingRiskIDs];
        
        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'Project');
            generator.writeStringField('noLink', 'TRUE');
            generator.writeFieldName('children');
            generator.writeStartArray();
                for (String categoryName : categoryNames)
                {
                    generator.writeStartObject();
                        generator.writeStringField('name', categoryName);
                        generator.writeStringField('noLink', 'TRUE');
                        generator.writeFieldName('children');
                        generator.writeStartArray();
                            if (categoryName == 'Risks')
                            {
                                for (Risk_Project_Association__c risk : risks)
                                {
                                    generator.writeStartObject();
                                        generator.writeFieldname('children');
                                        String objectName = risk.Risk__r.Name;
                                        generator.writeStartArray();
                                            for (Risk_Controls_Association__c riskControlAssoc : riskControls)
                                            {
                                                if (riskControlAssoc.Risk__r.ID == risk.Risk__r.ID)
                                                {
                                                    generator.writeStartObject();
                                                        generator.writeStringField('name', riskControlAssoc.Controls__r.Name);
                                                        generator.writeStringField('objectID', riskControlAssoc.Controls__r.ID);
                                                    generator.writeEndObject();
                                                    objectName = risk.Risk__r.Name + ' - Controls';
                                                }
                                            }
                                        generator.writeEndArray();
                                        generator.writeStringField('name', objectName);
                                        generator.writeStringField('objectID', risk.Risk__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Vendors')
                            {
                                for (Project_Vendor_Association__c vendor : vendors)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', vendor.Vendor__r.Name);
                                        generator.writeStringField('objectID', vendor.Vendor__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Objectives')
                            {
                                for (Project_Objective_Association__c objective : objectives)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', objective.Objectives__r.Name);
                                        generator.writeStringField('objectID', objective.Objectives__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Indicators')
                            {
                                for (Project_Indicators_Association__c indicator : indicators)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', indicator.Indicator__r.Name);
                                        generator.writeStringField('objectID', indicator.Indicator__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'GLs')
                            {
                                for (Project_GL_Association__c gl : gls)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', gl.General_Ledger__r.Name);
                                        generator.writeStringField('objectID', gl.General_Ledger__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Compliance')
                            {
                                for (Project_Compliance_Association__c compliance : compliances)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', compliance.Compliance__r.Name);
                                        generator.writeStringField('objectID', compliance.Compliance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Locations')
                            {
                                for (Location_Project_Association__c location : locations)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', location.RK_Hierarchy__r.Name);
                                        generator.writeStringField('objectID', location.RK_Hierarchy__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                        generator.writeEndArray();
                    generator.writeEndObject();
                }
            generator.writeEndArray();
        generator.writeEndObject();
        
        String returnString = generator.getAsString();
        returnString = returnString.replace('\\"', '"');
        returnString = returnString.replace('"{', '{');
        returnString = returnString.replace('}"', '}');
        
        System.debug(returnString);
        return returnString;
    }
}