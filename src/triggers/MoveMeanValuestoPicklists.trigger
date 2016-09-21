trigger MoveMeanValuestoPicklists on Risk__c (after insert, after update) {


for (Risk__c newRisk : Trigger.new)
    {

Decimal MCL = newRisk.Mean_Current_Likelihood__c;
Decimal RMCL = MCL.round();
String SRMCL = RMCL.toPlainString();

Decimal MCI = newRisk.Mean_Current_Impact__c;
Decimal RMCI = MCL.round();
String SRMCI = RMCL.toPlainString();

        if (newRisk.RecordType.Name == 'Normal')
        {
            newRisk.Expected_Residual_or_Current_Impact__c = SRMCL;
            newRisk.Expected_Residual_or_Current_Likelihood__c = SRMCI;


}
}
}