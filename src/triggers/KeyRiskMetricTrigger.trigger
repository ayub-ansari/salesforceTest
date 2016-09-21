/**
Name  :  KeyRiskMetricTrigger
Details  :  Changes the parent Risk Appetite Statement when Category is changed
**/
trigger KeyRiskMetricTrigger on Key_Risk_Metric__c (before insert, before update) {
  map<String,Id> riskAppetiteStatements = new map<String,Id>();
  
  //Return only 5 records. 1 for each of the 5 record types.
  for(Risk_Appetite_Statement__c rsa : [select Id, RecordTypeId, RecordType.Name from Risk_Appetite_Statement__c]){
    riskAppetiteStatements.put(rsa.RecordType.Name,rsa.Id);
  }
  
  for(Key_Risk_Metric__c krm : trigger.new){
    if(krm.Category__c != null && riskAppetiteStatements.get(krm.Category__c) != null){
      krm.Risk_Appetite__c = riskAppetiteStatements.get(krm.Category__c);
    }
  }
}