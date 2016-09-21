public with sharing class RiskAppetiteStatementController {
  public list<Risk_Appetite_Statement__c> riskAppetiteList{get;set;}
  public boolean editable{get;set;}
  public RiskAppetiteStatementController(){
    riskAppetiteList = [Select r.Risk_Appetite_Statement__c, r.RecordType.Name, r.RecordTypeId, r.Id, 
              (Select Id, Name, Description__c From Key_Risk_Metrics__r order by Name) 
              From Risk_Appetite_Statement__c r order by Name];
    editable = false;
    Apexpages.currentPage().getHeaders().put( 'content-disposition', 'inline; filename=RiskAppetiteStatement.pdf' );
  }
  
  public void showEditable(){
    editable = true;
  }
  public PageReference hideEditable(){
    PageReference pg = new PageReference('/apex/RiskAppetiteStatement');
    pg.setRedirect(true);
    return pg;
  }
  public PageReference saveData(){
    list<Key_Risk_Metric__c> krmUpdate = new list<Key_Risk_Metric__c>();
    for(Risk_Appetite_Statement__c ras : riskAppetiteList){
      krmUpdate.addAll(ras.Key_Risk_Metrics__r);
    }
    try{
      update riskAppetiteList;
      update krmUpdate;
    }catch(Exception e){
      system.debug('ERROR : '+e.getMessage());
    }
    PageReference pg = new PageReference('/apex/RiskAppetiteStatement');
    pg.setRedirect(true);
    return pg;
  }
  public PageReference viewAll(){
    PageReference pg = new PageReference('/'+Schema.SObjectType.Risk_Appetite_Statement__c.getKeyPrefix());
    pg.setRedirect(true);
    return pg;
  }
  public PageReference back(){
    PageReference pg = new PageReference('/home/home.jsp');
    pg.setRedirect(true);
    return pg;
  }
}