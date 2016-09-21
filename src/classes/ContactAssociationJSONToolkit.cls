global class ContactAssociationJSONToolkit {
    webservice static String toJSON(String contactID)
    {
        //List<sObject> returnedAssociations = Database.query(query);
        
        List<String> categoryNames = new List<String>();
        
        categoryNames.add('Committees');
        categoryNames.add('Compliances');
        //categoryNames.add('Governances');
        categoryNames.add('Locations');
        categoryNames.add('Risks');
                
        List<Committee_Contact_Association__c> committees = [SELECT Contact__r.Id, Contact__r.Name, Committees__r.Id, Committees__r.Name from Committee_Contact_Association__c where Contact__r.Id =:contactID];
        List<Compliance_Contact_Association__c> compliances = [SELECT Contact__r.Id, Contact__r.Name, Compliance__r.Id, Compliance__r.Name from Compliance_Contact_Association__c where Contact__r.Id =:contactID];
        //List<Contact_Governance_Association__c> governances = [SELECT Contact__r.Id, Contact__r.Name, Governance__r.Id, Governance__r.Name from Contact_Governance_Association__c where Contact__r.Id =:contactID];
        List<Location_Contact_Association__c> locations = [SELECT Contact__r.Id, Contact__r.Name, RK_Hierarchy__r.Id, RK_Hierarchy__r.Name from Location_Contact_Association__c where Contact__r.Id =:contactID];
        List<Risk_Stakeholder_Association__c> risks = [SELECT Risk__r.Id, Risk__r.Name, Stakeholder__r.Id, Stakeholder__r.Name from Risk_Stakeholder_Association__c where Stakeholder__r.Id =:contactID];
        

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

                            
                            if (categoryName == 'Committees')
                            {
                                for (Committee_Contact_Association__c committee : committees)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', committee.Committees__r.Name);
                                        generator.writeStringField('objectID', committee.Committees__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            
                            else if (categoryName == 'Compliances')
                            {
                                for (Compliance_Contact_Association__c compliance : compliances)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', compliance.Compliance__r.Name);
                                        generator.writeStringField('objectID', compliance.Compliance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            /*
                            else if (categoryName == 'Governances')
                            {
                                for (Contact_Governance_Association__c governance : governances)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', governance.Governance__r.Name);
                                        generator.writeStringField('objectID', governance.Governance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            */
                            
                            else if (categoryName == 'Locations')
                            {
                                for (Location_Contact_Association__c location : locations)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', location.RK_Hierarchy__r.Name);
                                        generator.writeStringField('objectID', location.RK_Hierarchy__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            
                            else if (categoryName == 'Risks')
                            {
                                for (Risk_Stakeholder_Association__c risk : risks)
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