public with sharing class KeyRiskMeasureChartController {
  public List<String> chartData {get; set;}
    
    public KeyRiskMeasureChartController(ApexPages.StandardController stdController){
        Key_Risk_Metric__c krm = (Key_Risk_Metric__c)stdController.getRecord();
        chartData = new List<String>();
        Integer currentYear = date.today().year();
        
        for(Key_Risk_Metric_Measure__c r : [Select Upper_Limit__c, Lower_Limit__c, Actual__c, YTD__c, Key_Risk_Metric__r.Measured_Unit__c, Key_Risk_Metric__c, Id, Evaluation_Date__c From Key_Risk_Metric_Measure__c k where Key_Risk_Metric__c =: krm.id AND CALENDAR_YEAR(Evaluation_Date__c) =: currentYear order by Evaluation_Date__c]){
            string dateFormat = string.valueOf(r.Evaluation_Date__c.format());
            List<string> dateFormatSplit = dateFormat.split('00:');
            
          if(r.Upper_Limit__c == null) r.Upper_Limit__c = 0;
            if(r.Lower_Limit__c == null) r.Lower_Limit__c = 0;
            if(r.Actual__c == null) r.Actual__c = 0;
            if(r.YTD__c == null) r.YTD__c = 0;
            
            if(r.Key_Risk_Metric__r.Measured_Unit__c == 'Ratio%'){
              r.Lower_Limit__c /= 100;
                r.Upper_Limit__c /= 100;
                r.Actual__c /= 100;
                r.YTD__c /= 100;
            }
            
            string cdata = ',["' + dateFormatSplit[0] + '", ' + r.Upper_Limit__c + ',' + r.Actual__c + ','+ r.YTD__c+ ','+ r.Lower_Limit__c + ']';
            chartData.add(cdata);
        }
    }
}