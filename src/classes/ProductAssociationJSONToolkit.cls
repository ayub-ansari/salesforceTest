global class ProductAssociationJSONToolkit {
    webservice static String toJSON(String productId)
    {
        //List<sObject> returnedAssociations = Database.query(query);
        
        List<String> categoryNames = new List<String>();
        categoryNames.add('Vendor Locations');
        categoryNames.add('Governances');
        categoryNames.add('Committees');
        categoryNames.add('Objectives');

        
        List<Product_Vendor_Location_Association__c> vendorLocations = [SELECT Product__r.Id, Product__r.Name, Vendor_Location__r.Id, Vendor_Location__r.Name from Product_Vendor_Location_Association__c where Product__r.Id =:productId];
        List<Product_Governance_Association__c> governances = [SELECT Product__r.Id, Product__r.Name, Governance__r.Id, Governance__r.Name from Product_Governance_Association__c where Product__r.Id =:productId];
        List<Product_Committee_Association__c> committees = [SELECT Product__r.Id, Product__r.Name, Committees__r.Id, Committees__r.Name from Product_Committee_Association__c where Product__r.Id =:productId];
        List<Product_Objective_Association__c> objectives = [SELECT Product__r.Id, Product__r.Name, Objectives__r.Id, Objectives__r.Name from Product_Objective_Association__c where Product__r.Id =:productId];

        
        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'PRODUCT');
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
                            if (categoryName == 'Vendor Locations')
                            {
                                for (Product_Vendor_Location_Association__c vendorLocation : vendorLocations)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', vendorLocation.Vendor_Location__r.Name);
                                        generator.writeStringField('objectID', vendorLocation.Vendor_Location__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Governances')
                            {
                                for (Product_Governance_Association__c governance : governances)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', governance.Governance__r.Name);
                                        generator.writeStringField('objectID', governance.Governance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Committees')
                            {
                                for (Product_Committee_Association__c committee : committees)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', committee.Committees__r.Name);
                                        generator.writeStringField('objectID', committee.Committees__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Objectives')
                            {
                                for (Product_Objective_Association__c objective : objectives)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', objective.Objectives__r.Name);
                                        generator.writeStringField('objectID', objective.Objectives__r.ID);
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