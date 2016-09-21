trigger ModelManagementScoring on Model__c (before insert, before Update) {
    for(Model__c model : trigger.new){
        IF(model.Total_Score_2__c >= 8 && model.Total_Grade__c == 'A'){
            model.Total_Section_Level__c = 'Mature';
        }else if(model.Total_Score_2__c >= 5.5 && (model.Total_Grade__c == 'A' || model.Total_Grade__c == 'B')){
            model.Total_Section_Level__c = 'Intermediate';
        }else{
            model.Total_Section_Level__c = 'Initial';
        }
    }
}