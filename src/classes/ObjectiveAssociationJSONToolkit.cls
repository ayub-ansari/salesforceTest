global class ObjectiveAssociationJSONToolkit {
    webservice static String toJSON(String objectiveID)
    {
        //List<sObject> returnedAssociations = Database.query(query);
        
        List<String> categoryNames = new List<String>();
        
        categoryNames.add('Audits');
        categoryNames.add('Governances');
        //categoryNames.add('Internal Audit Subtasks');
        categoryNames.add('Vendors');
        categoryNames.add('Processes');
        categoryNames.add('Products');
        categoryNames.add('Projects');
        categoryNames.add('Risks');

        List<Audit_Objective_Association__c> audits = [SELECT Objectives__r.Id, Objectives__r.Name, Audit__r.Id, Audit__r.Name from Audit_Objective_Association__c where Objectives__r.Id =:objectiveID];
        List<Governance_Objectives_Association__c> governances = [SELECT Objectives__r.Id, Objectives__r.Name, Governance__r.Id, Governance__r.Name from Governance_Objectives_Association__c where Objectives__r.Id =:objectiveID];
        //List<Internal_Audit_Objective_Association__c> internalauditsubtasks = [SELECT Objectives__r.Id, Objectives__r.Name, Internal_Audit_Subtask__r.Id, Internal_Audit_Subtask__r.Name from Internal_Audit_Objective_Association__c where Objectives__r.Id =:objectiveID];
        List<Objective_Vendor_Association__c> vendors = [SELECT Objective__r.Id, Objective__r.Name, Vendor__r.Id, Vendor__r.Name from Objective_Vendor_Association__c where Objective__r.Id =:objectiveID];
        List<Process_Objective_Association__c> processes = [SELECT Objectives__r.Id, Objectives__r.Name, Process__r.Id, Process__r.Name from Process_Objective_Association__c where Objectives__r.Id =:objectiveID];
        List<Product_Objective_Association__c> products = [SELECT Objectives__r.Id, Objectives__r.Name, Product__r.Id, Product__r.Name from Product_Objective_Association__c where Objectives__r.Id =:objectiveID];
        List<Project_Objective_Association__c> projects = [SELECT Objectives__r.Id, Objectives__r.Name, Project__r.Id, Project__r.Name from Project_Objective_Association__c where Objectives__r.Id =:objectiveID];
        List<Risk_Objective_Association__c> risks = [SELECT Risk__r.Id, Risk__r.Name, Objectives__r.Id, Objectives__r.Name from Risk_Objective_Association__c where Objectives__r.Id =:objectiveID];


        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'OBJECTIVE');
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
                           
                           if (categoryName == 'Audits')
                            {
                                for (Audit_Objective_Association__c audit : audits)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', audit.Audit__r.Name);
                                        generator.writeStringField('objectID', audit.Audit__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Governances')
                            {
                                for (Governance_Objectives_Association__c governance : governances)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', governance.Governance__r.Name);
                                        generator.writeStringField('objectID', governance.Governance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            /*
                            else if (categoryName == 'Internal Audit Subtasks')
                            {
                                for (Internal_Audit_Objective_Association__c internalauditsubtask : internalauditsubtasks)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', internalauditsubtask.Internal_Audit_Subtask__r.Name);
                                        generator.writeStringField('objectID', internalauditsubtask.Internal_Audit_Subtask__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            */
                            else if (categoryName == 'Vendors')
                            {
                                for (Objective_Vendor_Association__c vendor : vendors)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', vendor.Vendor__r.Name);
                                        generator.writeStringField('objectID', vendor.Vendor__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Processes')
                            {
                                for (Process_Objective_Association__c process : processes)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', process.Process__r.Name);
                                        generator.writeStringField('objectID', process.Process__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Products')
                            {
                                for (Product_Objective_Association__c product : products)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', product.Product__r.Name);
                                        generator.writeStringField('objectID', product.Product__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Projects')
                            {
                                for (Project_Objective_Association__c project : projects)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', project.Project__r.Name);
                                        generator.writeStringField('objectID', project.Project__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Risks')
                            {
                                for (Risk_Objective_Association__c risk : risks)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', risk.Risk__r.Name);
                                        generator.writeStringField('objectID', risk.Risk__r.ID);
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
        
        return returnString;
    }
}