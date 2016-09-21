//This trigger replaces any lookups to Contact with that Contact's ReportTo when the Contact is deleted
//
// KDG 6/5/2013
// PST-00013055

trigger ContactDelete on Contact (before delete) {
  Map<String,List<String>> relMap = new Map<String,List<String>>();
  for(Schema.ChildRelationship rel : Contact.SObjectType.getDescribe().getChildRelationships()) {
        String objectName = String.valueOf(rel.getChildSObject());
        if(!relMap.containsKey(objectName)) {
          relMap.put(objectName, new List<String>{String.valueOf(rel.getField())});
        } else {
          relMap.get(objectName).add(String.valueOf(rel.getField()));
        }
    }
  
  Map<Id,Id> reportsToMap = new Map<Id,Id>();
  
    for(Contact con : Trigger.old) {
      if(con.ReportsToId!=null) {
        reportsToMap.put(con.Id, con.ReportsToId);
      }
    }
    
    List<SObject> allResults = new List<SObject>();
    
    for(String objectName : relMap.keySet()) {
      al.NestableCondition whereCondition = new al.OrCondition();
      for(String rel : relMap.get(objectName)) {
        whereCondition.add(new al.SetCondition(rel).inx(new List<Id>(reportsToMap.keySet())));
      }
      String soql = new al.SOQLBuilder().
           selectx(relMap.get(objectName)).
           fromx(objectName).
           wherex(whereCondition).toSOQL();
        System.debug('Query: '+soql);
        try {
        List<SObject> results = Database.query(soql);
  
        for(SObject result : results) {
          for(String rel : relMap.get(objectName)) {
            Id relId = (Id)result.get(rel);
            if(reportsToMap.keySet().contains(relId)) {
              result.put(rel, reportsToMap.get(relId));
            }
          }
        }
        allResults.addAll(results);
        } catch (System.QueryException e) {
          System.debug(objectName+' did not support query, skipped. <'+e+'>');
        }
    }
    update allResults;
    
}