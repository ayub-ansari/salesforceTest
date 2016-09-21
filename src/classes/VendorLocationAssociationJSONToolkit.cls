global class VendorLocationAssociationJSONToolkit {
    webservice static String toJSON(String vendorLocationID)
    {
        //List<sObject> returnedAssociations = Database.query(query);
        
        List<String> categoryNames = new List<String>();
        
       
        categoryNames.add('Processes');
        categoryNames.add('Products');

        List<Process_Vendor_Location_Association__c> processes = [SELECT Vendor_Location__r.Id, Vendor_Location__r.Name, Process__r.Id, Process__r.Name from Process_Vendor_Location_Association__c where Vendor_Location__r.Id =:vendorLocationID];
        List<Product_Vendor_Location_Association__c> products = [SELECT Vendor_Location__r.Id, Vendor_Location__r.Name, Product__r.Id, Product__r.Name from Product_Vendor_Location_Association__c where Vendor_Location__r.Id =:vendorLocationID];
        

        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'VENDOR LOCATIONS');
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
                           
                         
                         if (categoryName == 'Processes')
                            {
                                for (Process_Vendor_Location_Association__c process : processes)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', process.Process__r.Name);
                                        generator.writeStringField('objectID', process.Process__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Products')
                            {
                                for (Product_Vendor_Location_Association__c product : products)
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