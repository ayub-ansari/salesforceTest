public class QuarterlyMeasureChartController{
  
    public List<String> chartData {get; set;}
    
    public QuarterlyMeasureChartController(ApexPages.StandardController stdController){
        Key_Objective__c ko = (Key_Objective__c)stdController.getRecord();
        
        chartData = new List<String>();
        
        Integer currentYear = date.today().year();
        Integer previousYear = date.today().year()-1;
        
        for(Quarterly_Measure__c r:[select id, Key_Objective__r.Measured_Unit__c,Quarterly_Goal__c, Name, Evaluation_Date__c, Key_Objective__c, Quarterly_Measure__c from Quarterly_Measure__c where Key_Objective__c =: ko.id AND (CALENDAR_YEAR(Evaluation_Date__c) =: currentYear OR CALENDAR_YEAR(Evaluation_Date__c) =: previousYear) order by Evaluation_Date__c]){
            string dateFormat = string.valueOf(r.Evaluation_Date__c.format());
            
            List<string> dateFormatSplit = dateFormat.split('00:');
            
            if(r.Quarterly_Goal__c == null){
                r.Quarterly_Goal__c = 0;   
            }
            
            if(r.Key_Objective__r.Measured_Unit__c == 'Ratio%'){
                r.Quarterly_Goal__c /= 100;
                r.Quarterly_Measure__c /= 100;
            }
            
            string data = ',["' + dateFormatSplit[0] + '", ' + r.Quarterly_Measure__c + ',' + r.Quarterly_Goal__c + ']';
            chartData.add(data);
        }
        
    }

}