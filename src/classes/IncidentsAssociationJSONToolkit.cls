global class IncidentsAssociationJSONToolkit {
    webservice static String toJSON(String incidentsID)
    {
        //List<sObject> returnedAssociations = Database.query(query);
        
        List<String> categoryNames = new List<String>();
        
        categoryNames.add('GLs');
        categoryNames.add('Risks');
        
        List<Incidents_GL_Association__c> gls = [SELECT Incident__r.Id, Incident__r.Name, General_Ledger__r.Id, General_Ledger__r.Name from Incidents_GL_Association__c where Incident__r.Id =:incidentsID];
        List<Risk_Incidents_Association__c> risks = [SELECT Risk__r.Id, Risk__r.Name, Incident__r.Id, Incident__r.Name from Risk_Incidents_Association__c where Incident__r.Id =:incidentsID];


        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'INCIDENTS');
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
                           
                           if (categoryName == 'GLs')
                            {
                                for (Incidents_GL_Association__c gl : gls)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', gl.General_Ledger__r.Name);
                                        generator.writeStringField('objectID', gl.General_Ledger__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                           
                            else if (categoryName == 'Risks')
                            {
                                for (Risk_Incidents_Association__c risk : risks)
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