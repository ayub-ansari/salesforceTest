global class LitigationAssociationJSONToolkit {
    webservice static String toJSON(String litigationID)
    {
        //List<sObject> returnedAssociations = Database.query(query);
        
        List<String> categoryNames = new List<String>();
        
        categoryNames.add('Compliances');
        categoryNames.add('Risks');
        categoryNames.add('Violations');
        
        List<Litigation_Compliance_Association__c> compliances = [SELECT Litigation__r.Id, Litigation__r.Name, Compliance__r.Id, Compliance__r.Name from Litigation_Compliance_Association__c where Litigation__r.Id =:litigationID];
        List<Litigation_Risk_Association__c> risks = [SELECT Risk__r.Id, Risk__r.Name, Litigation__r.Id, Litigation__r.Name from Litigation_Risk_Association__c where Litigation__r.Id =:litigationID];
        List<Litigation_Violation_Association__c> violations = [SELECT Litigation__r.Id, Litigation__r.Name, Violation__r.Id, Violation__r.Name from Litigation_Violation_Association__c where Litigation__r.Id =:litigationID];
  


        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'LITIGATION');
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
                           
                           
                            if (categoryName == 'Compliances')
                            {
                                for (Litigation_Compliance_Association__c compliance: compliances)
                                {
                                    generator.writeStartObject();
                                       generator.writeStringField('name', compliance.Compliance__r.Name);
                                       generator.writeStringField('objectID', compliance.Compliance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Violation')
                            {
                                for (Litigation_Violation_Association__c violation : violations)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', violation.Violation__r.Name);
                                        generator.writeStringField('objectID', violation.Violation__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Risks')
                            {
                                for (Litigation_Risk_Association__c risk : risks)
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