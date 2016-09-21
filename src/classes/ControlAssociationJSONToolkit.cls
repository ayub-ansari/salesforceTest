global class ControlAssociationJSONToolkit {
    webservice static String toJSON(String controlID)
    {
        //List<sObject> returnedAssociations = Database.query(query);
        
        List<String> categoryNames = new List<String>();
        categoryNames.add('Compliances');
        categoryNames.add('Vendors');
        categoryNames.add('Indicators');
        categoryNames.add('Committees');
        categoryNames.add('Audits');
        categoryNames.add('Risks');
        
        List<Control_Compliance_Association__c> compliances = [SELECT Controls__r.Id, Controls__r.Name, Compliance__r.Id, Compliance__r.Name from Control_Compliance_Association__c where Controls__r.Id =:controlID];
        List<Control_Vendor_Association__c> vendors = [SELECT Controls__r.Id, Controls__r.Name, Vendor__r.Id, Vendor__r.Name from Control_Vendor_Association__c where Controls__r.Id =:controlID];
        List<Control_Indicator_Association__c> indicators = [SELECT Controls__r.Id, Controls__r.Name, Indicator__r.Id, Indicator__r.Name from Control_Indicator_Association__c where Controls__r.Id =:controlID];
        List<Control_Committee_Association__c> committees = [SELECT Controls__r.Id, Controls__r.Name, Committees__r.Id, Committees__r.Name from Control_Committee_Association__c where Controls__r.Id =:controlID];
        List<Audit_Control_Association__c> audits = [SELECT Controls__r.Id, Controls__r.Name, Audit__r.Id, Audit__r.Name from Audit_Control_Association__c where Controls__r.Id =:controlID];
        List<Risk_Controls_Association__c> risks = [SELECT Risk__r.Id, Risk__r.Name, Controls__r.Id, Controls__r.Name from Risk_Controls_Association__c where Controls__r.Id =:controlID];
        
        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'CONTROL');
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
                                for (Risk_Controls_Association__c risk : risks)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', risk.Risk__r.Name);
                                        generator.writeStringField('objectID', risk.Risk__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Compliances')
                            {
                                for (Control_Compliance_Association__c compliance : compliances)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', compliance.Compliance__r.Name);
                                        generator.writeStringField('objectID', compliance.Compliance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            
                            else if (categoryName == 'Indicators')
                            {
                                for (Control_Indicator_Association__c indicator : indicators)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', indicator.Indicator__r.Name);
                                        generator.writeStringField('objectID', indicator.Indicator__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Committees')
                            {
                                for (Control_Committee_Association__c committee : committees)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', committee.Committees__r.Name);
                                        generator.writeStringField('objectID', committee.Committees__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            
                            else if (categoryName == 'Vendors')
                            {
                                for (Control_Vendor_Association__c vendor : vendors)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', vendor.Vendor__r.Name);
                                        generator.writeStringField('objectID', vendor.Vendor__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Audits')
                            {
                                for (Audit_Control_Association__c audit : audits)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', audit.Audit__r.Name);
                                        generator.writeStringField('objectID', audit.Audit__r.ID);
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