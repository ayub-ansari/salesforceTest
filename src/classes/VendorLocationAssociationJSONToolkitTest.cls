@isTest
public class VendorLocationAssociationJSONToolkitTest {
  static final String VENDOR_LOCATION_CONST = 'Test Vendor Location';
  static final String PROCESS_CONST = 'Test Process';
  static final String PRODUCT_CONST = 'Test Product';
  
  
  static String JSONResult;
  
  static {
    Vendor_Location__c vendorLocation = new Vendor_Location__c(Name = 'Test');
      insert vendorLocation;
       
      Process__c processes = new Process__c(Name = PROCESS_CONST);
      insert processes;
      Process_Vendor_Location_Association__c processVendorLocationAssociation = new Process_Vendor_Location_Association__c(Vendor_Location__c = vendorLocation.Id, Process__c = processes.Id);
      insert processVendorLocationAssociation;
      
     Product__c product = new Product__c(Name = 'Test Product');
      insert product;
      Product_Vendor_Location_Association__c productVendorLocationAssociation = new Product_Vendor_Location_Association__c(Vendor_Location__c = vendorLocation.id, Product__c = product.id);
      insert productVendorLocationAssociation;
      
      JSONResult = VendorLocationAssociationJSONToolkit.toJSON(vendorLocation.Id);  
      }
      
      
 static testMethod void testVendorLocation() {
    Integer i = 0;
    JSONParser parser = JSON.createParser(JSONResult);
    while (parser.nextToken() != null) {
      if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'name') {
        i++;
        if (i == 3) {
          parser.nextToken();
          break;
        }
      }
    }

    String processName = parser.getText();
    System.assert(processName == PROCESS_CONST);
  } 
}