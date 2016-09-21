global class GovernanceAssociationJSONToolkit {
  webservice static String toJSON(String governanceID) {

    List<String> categoryNames = new List<String>();
    categoryNames.add('Compliances');
    categoryNames.add('Indicators');
    categoryNames.add('Objectives');
    categoryNames.add('Risks');
    categoryNames.add('Products');

    List<Governance_Compliance_Association__c> compliances = [SELECT Governance__r.Id, Governance__r.Name, Compliance__r.Id, Compliance__r.Name FROM Governance_Compliance_Association__c WHERE Governance__r.Id =: governanceID];
    List<Governance_Indicators_Association__c> indicators = [SELECT Governance__r.Id, Governance__r.Name, Indicator__r.Id, Indicator__r.Name FROM Governance_Indicators_Association__c WHERE Governance__r.Id =: governanceID];
    List<Governance_Objectives_Association__c> objectives = [SELECT Governance__r.Id, Governance__r.Name, Objectives__r.Id, Objectives__r.Name FROM Governance_Objectives_Association__c WHERE Governance__r.Id =: governanceID];
    List<Governance_Risk_Association__c> risks = [SELECT Governance__r.Id, Governance__r.Name, Risks__r.Id, Risks__r.Name FROM Governance_Risk_Association__c WHERE Governance__r.Id =: governanceID];
    List<Product_Governance_Association__c> products = [SELECT Governance__r.Id, Governance__r.Name, Product__r.Id, Product__r.Name FROM Product_Governance_Association__c WHERE Governance__r.Id =: governanceID];

    JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'GOVERNANCE');
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
                                for (Governance_Compliance_Association__c compliance : compliances)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', compliance.Compliance__r.Name);
                                        generator.writeStringField('objectID', compliance.Compliance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Indicators')
                            {
                                for (Governance_Indicators_Association__c indicator : indicators)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', indicator.Indicator__r.Name);
                                        generator.writeStringField('objectID', indicator.Indicator__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Objectives')
                            {
                                for (Governance_Objectives_Association__c objective : objectives)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', objective.Objectives__r.Name);
                                        generator.writeStringField('objectID', objective.Objectives__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Risks')
                            {
                                for (Governance_Risk_Association__c risk : risks)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', risk.Risks__r.Name);
                                        generator.writeStringField('objectID', risk.Risks__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Products')
                            {
                                for (Product_Governance_Association__c product : products)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', product.Product__r.Name);
                                        generator.writeStringField('objectID', product.Product__r.ID);
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