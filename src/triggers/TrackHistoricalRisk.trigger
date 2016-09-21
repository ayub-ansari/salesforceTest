/*
 * JCM 2012/12/20
 * PST-00005647
 */
trigger TrackHistoricalRisk on Risk__c (after insert, after update)
{
    System.Debug('JCM -------- >> TRIGGER');
    List<Risk_History__c> riskHistories = new List<Risk_History__c>();
    Map<String, String> fieldNameMap = new Map<String, String> {
        'Expected_Residual_Impact_Number__c'     => 'Expected_Current_Impact',
        'Expected_Residual_Likelihood_Number__c' => 'Expected_Current_Likelihood',
        'Expected_Inherent_Impact_Number__c'     => 'Expected_Inherent_Impact',
        'Expected_Inherent_Likelihood_Number__c' => 'Expected_Inherent_Likelihood',
        'Expected_Target_Impact_Number__c'       => 'Expected_Target_Impact',
        'Expected_Target_Likelihood_Number__c'   => 'Expected_Target_Likelihood'
    };

    for (Risk__c newRisk : Trigger.new)
    {
        Risk_History__c riskHistory = new Risk_History__c();
        Boolean historyNeeded = false;

        if (Trigger.isInsert)
        {
            System.Debug('JCM -------- Insert');
            System.Debug('JCM -------- Insert RT = ' + newRisk.RecordTypeId);
            for (String riskFieldName : fieldNameMap.keySet())
            {
                Object newValue = newRisk.get(riskFieldName);

                if (newValue != null)
                {
                    String historyFieldNameStub = fieldNameMap.get(riskFieldName);
                    String historyFieldNameOld = historyFieldNameStub + '_Old__c';
                    String historyFieldNameNew = historyFieldNameStub + '_New__c';

                    riskHistory.put(historyFieldNameOld, Decimal.valueOf(String.valueOf(newValue)));
                    riskHistory.put(historyFieldNameNew, Decimal.valueOf(String.valueOf(newValue)));
                }
            }

            riskHistory.Change_Description__c = 'Initial values - ';
            historyNeeded = true;
        }
        else if (Trigger.isUpdate)
        {
            System.Debug('JCM -------- Update');
            Risk__c oldRisk = Trigger.oldMap.get(newRisk.Id);
            System.Debug('JCM -------- Update RT = ' + oldRisk.RecordTypeId);

            for (String riskFieldName : fieldNameMap.keySet())
            {
                Object newValue = newRisk.get(riskFieldName);
                if (newValue == null)
                {
                    newValue = '0';
                }

                Object oldValue = oldRisk.get(riskFieldName);
                if (oldValue == null)
                {
                    oldValue = '0';
                }

                if (oldValue != newValue)
                {
                    String historyFieldNameStub = fieldNameMap.get(riskFieldName);
                    String historyFieldNameOld = historyFieldNameStub + '_Old__c';
                    String historyFieldNameNew = historyFieldNameStub + '_New__c';

                    riskHistory.put(historyFieldNameOld, Decimal.valueOf(string.valueOf(oldValue)));
                    riskHistory.put(historyFieldNameNew, Decimal.valueOf(string.valueOf(newValue)));
                    historyNeeded = true;
                }
            }

            if (historyNeeded)
            {
                // Get a snapshot of the unchanged fields
                // for inclusion in the history record.
                for (String riskFieldName : fieldNameMap.keySet())
                {
                    Object oldValue = oldRisk.get(riskFieldName);
                    if (oldValue == null)
                    {
                        oldValue = '0';
                    }

                    Object newValue = newRisk.get(riskFieldName);
                    if (newValue == null)
                    {
                        newValue = '0';
                    }

                    if (oldValue == newValue)
                    {
                        String historyFieldNameStub = fieldNameMap.get(riskFieldName);
                        String historyFieldNameOld = historyFieldNameStub + '_Old__c';
                        String historyFieldNameNew = historyFieldNameStub + '_New__c';

                        riskHistory.put(historyFieldNameOld, Decimal.valueOf(string.valueOf(oldValue)));
                        riskHistory.put(historyFieldNameNew, Decimal.valueOf(string.valueOf(newValue)));
                    }
                }
            }

            riskHistory.Change_Description__c = 'Values changed - ';
        }

        if (historyNeeded)
        {
            System.Debug('JCM -------- History needed');
            riskHistory.Risk__c = newRisk.Id;
            riskHistory.Valuation_Date__c = Date.today();

            User user = [select Name from User where Id = :UserInfo.getUserId()];
            riskHistory.Change_Description__c += user.Name;
            riskHistories.add(riskHistory);
        }
    }

    insert riskHistories;
    System.Debug('JCM -------- << TRIGGER');
}