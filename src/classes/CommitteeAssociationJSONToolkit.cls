global class CommitteeAssociationJSONToolkit {
    webservice static String toJSON(String committeeID) {

        List<String> categoryNames = new List<String>();
        categoryNames.add('Contacts');
        categoryNames.add('Indicators');
        categoryNames.add('Controls');
        categoryNames.add('Risks');
        categoryNames.add('Products');

        List<Committee_Contact_Association__c> contacts = [SELECT Committees__r.Id, Committees__r.Name, Contact__r.Id, Contact__r.Name FROM Committee_Contact_Association__c WHERE Committees__r.Id =: committeeID];
        List<Indicator_Committee_Association__c> indicators = [SELECT Committees__r.Id, Committees__r.Name, Indicator__r.Id, Indicator__r.Name FROM Indicator_Committee_Association__c WHERE Committees__r.Id =: committeeID];
        List<Control_Committee_Association__c> controls = [SELECT Committees__r.Id, Committees__r.Name, Controls__r.Id, Controls__r.Name FROM Control_Committee_Association__c WHERE Committees__r.Id =: committeeID];
        List<Risk_Committee_Association__c> risks = [SELECT Committees__r.Id, Committees__r.Name, Risk__r.Id, Risk__r.Name FROM Risk_Committee_Association__c WHERE Committees__r.Id =: committeeID];
        List<Product_Committee_Association__c> products = [SELECT Committees__r.Id, Committees__r.Name, Product__r.Id, Product__r.Name FROM Product_Committee_Association__c WHERE Committees__r.Id =: committeeID];

        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'COMMITTEE');
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
                            if (categoryName == 'Contacts')
                            {
                                for (Committee_Contact_Association__c contact : contacts)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', contact.Contact__r.Name);
                                        generator.writeStringField('objectID', contact.Contact__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Indicators')
                            {
                                for (Indicator_Committee_Association__c indicator : indicators)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', indicator.Indicator__r.Name);
                                        generator.writeStringField('objectID', indicator.Indicator__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Controls')
                            {
                                for (Control_Committee_Association__c control : controls)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', control.Controls__r.Name);
                                        generator.writeStringField('objectID', control.Controls__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Risks')
                            {
                                for (Risk_Committee_Association__c risk : risks)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', risk.Risk__r.Name);
                                        generator.writeStringField('objectID', risk.Risk__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Products')
                            {
                                for (Product_Committee_Association__c product : products)
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