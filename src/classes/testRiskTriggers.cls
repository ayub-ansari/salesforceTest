/*
 * JCM 2012/12/20
 * PST-00005647
 */
@isTest
public class testRiskTriggers
{
    @isTest
    static void testInsertandUpdate()
    {
        Risk__c risk = new Risk__c(
            Expected_Residual_or_Current_Impact__c='1',
            Expected_Residual_or_Current_Likelihood__c='1',
            Expected_Inherent_Impact__c='1',
            Expected_Inherent_Likelihood__c='1',
            Expected_Target_Impact__c='1',
            Expected_Target_Likelihood__c='1'
            );

        insert risk;

        List<Risk_History__c> histories = [
            select
            Expected_Current_Impact_New__c,
            Expected_Current_Likelihood_New__c,
            Expected_Inherent_Impact_New__c,
            Expected_Inherent_Likelihood_New__c,
            Expected_Target_Impact_New__c,
            Expected_Target_Likelihood_New__c,

            Expected_Current_Impact_Old__c,
            Expected_Current_Likelihood_Old__c,
            Expected_Inherent_Impact_Old__c,
            Expected_Inherent_Likelihood_Old__c,
            Expected_Target_Impact_Old__c,
            Expected_Target_Likelihood_Old__c,
            Change_Description__c
            from Risk_History__c
            where Risk__c = :risk.Id
            ];

        // Check for history record for initial insert.
        System.AssertEquals(1, histories.size(), 'Expected 1 history record, found ' + histories.size());
        for (Risk_History__c history : histories)
        {
            System.Assert(history.Change_Description__c.containsIgnoreCase('initial'));
            System.AssertEquals(1, history.Expected_Current_Impact_New__c);
            System.AssertEquals(1, history.Expected_Current_Likelihood_New__c);
            System.AssertEquals(1, history.Expected_Inherent_Impact_New__c);
            System.AssertEquals(1, history.Expected_Inherent_Likelihood_New__c);
            System.AssertEquals(1, history.Expected_Target_Impact_New__c);
            System.AssertEquals(1, history.Expected_Target_Likelihood_New__c);

            System.AssertEquals(1, history.Expected_Current_Impact_Old__c);
            System.AssertEquals(1, history.Expected_Current_Likelihood_Old__c);
            System.AssertEquals(1, history.Expected_Inherent_Impact_Old__c);
            System.AssertEquals(1, history.Expected_Inherent_Likelihood_Old__c);
            System.AssertEquals(1, history.Expected_Target_Impact_Old__c);
            System.AssertEquals(1, history.Expected_Target_Likelihood_Old__c);
        }

        risk.Expected_Residual_or_Current_Impact__c = '5';
        risk.Expected_Residual_or_Current_Likelihood__c = '5';
        risk.Expected_Inherent_Impact__c = '5';
        risk.Expected_Inherent_Likelihood__c = '5';
        risk.Expected_Target_Impact__c = '5';
        risk.Expected_Target_Likelihood__c = '5';

        update risk;

        histories = [
            select
            Expected_Current_Impact_New__c,
            Expected_Current_Impact_Old__c,
            Expected_Inherent_Impact_New__c,
            Expected_Inherent_Impact_Old__c,
            Expected_Target_Impact_New__c,
            Expected_Target_Impact_Old__c,
            Expected_Current_Likelihood_New__c,
            Expected_Current_Likelihood_Old__c,
            Expected_Inherent_Likelihood_New__c,
            Expected_Inherent_Likelihood_Old__c,
            Expected_Target_Likelihood_New__c,
            Expected_Target_Likelihood_Old__c,
            Change_Description__c
            from Risk_History__c
            where Risk__c = :risk.Id
            ];

        Boolean foundChangeHistory = false;

        // Check for history record for updated values.
        System.AssertEquals(2, histories.size(), 'Expected 2 history records, found ' + histories.size());
        for (Risk_History__c history : histories)
        {
            if (history.Change_Description__c.containsIgnoreCase('change'))
            {
                System.AssertEquals(5, history.Expected_Current_Impact_New__c);
                System.AssertEquals(1, history.Expected_Current_Impact_Old__c);
                System.AssertEquals(5, history.Expected_Inherent_Impact_New__c);
                System.AssertEquals(1, history.Expected_Inherent_Impact_Old__c);
                System.AssertEquals(5, history.Expected_Target_Impact_New__c);
                System.AssertEquals(1, history.Expected_Target_Impact_Old__c);

                System.AssertEquals(5, history.Expected_Current_Likelihood_New__c);
                System.AssertEquals(1, history.Expected_Current_Likelihood_Old__c);
                System.AssertEquals(5, history.Expected_Inherent_Likelihood_New__c);
                System.AssertEquals(1, history.Expected_Inherent_Likelihood_Old__c);
                System.AssertEquals(5, history.Expected_Target_Likelihood_New__c);
                System.AssertEquals(1, history.Expected_Target_Likelihood_Old__c);

                foundChangeHistory = true;
            }
        }

        System.Assert(foundChangeHistory, 'Did not find history record for change');
    }    

    @isTest
    static void testInsertandUpdateSomeUnchanged()
    {
        Risk__c risk = new Risk__c(
            Expected_Residual_or_Current_Impact__c='1',
            Expected_Residual_or_Current_Likelihood__c='1',
            Expected_Inherent_Impact__c='1',
            Expected_Inherent_Likelihood__c='1',
            Expected_Target_Impact__c='1',
            Expected_Target_Likelihood__c='1'
            );

        insert risk;

        List<Risk_History__c> histories = [
            select
            Expected_Current_Impact_New__c,
            Expected_Current_Likelihood_New__c,
            Expected_Inherent_Impact_New__c,
            Expected_Inherent_Likelihood_New__c,
            Expected_Target_Impact_New__c,
            Expected_Target_Likelihood_New__c,

            Expected_Current_Impact_Old__c,
            Expected_Current_Likelihood_Old__c,
            Expected_Inherent_Impact_Old__c,
            Expected_Inherent_Likelihood_Old__c,
            Expected_Target_Impact_Old__c,
            Expected_Target_Likelihood_Old__c,
            Change_Description__c
            from Risk_History__c
            where Risk__c = :risk.Id
            ];

        // Check for history record for initial insert.
        System.AssertEquals(1, histories.size(), 'Expected 1 history record, found ' + histories.size());
        for (Risk_History__c history : histories)
        {
            System.Assert(history.Change_Description__c.containsIgnoreCase('initial'));
            System.AssertEquals(1, history.Expected_Current_Impact_New__c);
            System.AssertEquals(1, history.Expected_Current_Likelihood_New__c);
            System.AssertEquals(1, history.Expected_Inherent_Impact_New__c);
            System.AssertEquals(1, history.Expected_Inherent_Likelihood_New__c);
            System.AssertEquals(1, history.Expected_Target_Impact_New__c);
            System.AssertEquals(1, history.Expected_Target_Likelihood_New__c);

            System.AssertEquals(1, history.Expected_Current_Impact_Old__c);
            System.AssertEquals(1, history.Expected_Current_Likelihood_Old__c);
            System.AssertEquals(1, history.Expected_Inherent_Impact_Old__c);
            System.AssertEquals(1, history.Expected_Inherent_Likelihood_Old__c);
            System.AssertEquals(1, history.Expected_Target_Impact_Old__c);
            System.AssertEquals(1, history.Expected_Target_Likelihood_Old__c);
        }

        risk.Expected_Residual_or_Current_Impact__c = '5';
        risk.Expected_Residual_or_Current_Likelihood__c = '5';
        risk.Expected_Inherent_Impact__c = '5';
        risk.Expected_Inherent_Likelihood__c = '5';

        // Leave some fields unchanged.
        //risk.Expected_Target_Impact__c = '5';
        //risk.Expected_Target_Likelihood__c = '5';

        update risk;

        histories = [
            select
            Expected_Current_Impact_New__c,
            Expected_Current_Impact_Old__c,
            Expected_Inherent_Impact_New__c,
            Expected_Inherent_Impact_Old__c,
            Expected_Target_Impact_New__c,
            Expected_Target_Impact_Old__c,
            Expected_Current_Likelihood_New__c,
            Expected_Current_Likelihood_Old__c,
            Expected_Inherent_Likelihood_New__c,
            Expected_Inherent_Likelihood_Old__c,
            Expected_Target_Likelihood_New__c,
            Expected_Target_Likelihood_Old__c,
            Change_Description__c
            from Risk_History__c
            where Risk__c = :risk.Id
            ];

        Boolean foundChangeHistory = false;

        // Check for history record for updated values.
        System.AssertEquals(2, histories.size(), 'Expected 2 history records, found ' + histories.size());
        for (Risk_History__c history : histories)
        {
            if (history.Change_Description__c.containsIgnoreCase('change'))
            {
                System.AssertEquals(5, history.Expected_Current_Impact_New__c);
                System.AssertEquals(1, history.Expected_Current_Impact_Old__c);
                System.AssertEquals(5, history.Expected_Inherent_Impact_New__c);
                System.AssertEquals(1, history.Expected_Inherent_Impact_Old__c);

                System.AssertEquals(5, history.Expected_Current_Likelihood_New__c);
                System.AssertEquals(1, history.Expected_Current_Likelihood_Old__c);
                System.AssertEquals(5, history.Expected_Inherent_Likelihood_New__c);
                System.AssertEquals(1, history.Expected_Inherent_Likelihood_Old__c);

                // Check the unchanged values.
                System.AssertEquals(1, history.Expected_Target_Impact_New__c);
                System.AssertEquals(1, history.Expected_Target_Impact_Old__c);
                System.AssertEquals(1, history.Expected_Target_Likelihood_New__c);
                System.AssertEquals(1, history.Expected_Target_Likelihood_Old__c);

                foundChangeHistory = true;
            }
        }

        System.Assert(foundChangeHistory, 'Did not find history record for change');
    }    

    @isTest
    static void testInsertandUpdateNulls()
    {
        Risk__c risk = new Risk__c(
            Expected_Residual_or_Current_Impact__c=null,
            Expected_Residual_or_Current_Likelihood__c=null,
            Expected_Inherent_Impact__c=null,
            Expected_Inherent_Likelihood__c=null,
            Expected_Target_Impact__c=null,
            Expected_Target_Likelihood__c=null
            );

        insert risk;
        
        List<Risk_History__c> histories = [
            select
            Expected_Current_Impact_New__c,
            Expected_Current_Likelihood_New__c,
            Expected_Inherent_Impact_New__c,
            Expected_Inherent_Likelihood_New__c,
            Expected_Target_Impact_New__c,
            Expected_Target_Likelihood_New__c,

            Expected_Current_Impact_Old__c,
            Expected_Current_Likelihood_Old__c,
            Expected_Inherent_Impact_Old__c,
            Expected_Inherent_Likelihood_Old__c,
            Expected_Target_Impact_Old__c,
            Expected_Target_Likelihood_Old__c,
            Change_Description__c
            from Risk_History__c
            where Risk__c = :risk.Id
            ];

        // Check for history record for initial insert.
        System.AssertEquals(1, histories.size(), 'Expected 1 history record, found ' + histories.size());
        for (Risk_History__c history : histories)
        {
            System.Assert(history.Change_Description__c.containsIgnoreCase('initial'));
            System.AssertEquals(null, history.Expected_Current_Impact_New__c);
            System.AssertEquals(null, history.Expected_Current_Likelihood_New__c);
            System.AssertEquals(null, history.Expected_Inherent_Impact_New__c);
            System.AssertEquals(null, history.Expected_Inherent_Likelihood_New__c);
            System.AssertEquals(null, history.Expected_Target_Impact_New__c);
            System.AssertEquals(null, history.Expected_Target_Likelihood_New__c);

            System.AssertEquals(null, history.Expected_Current_Impact_Old__c);
            System.AssertEquals(null, history.Expected_Current_Likelihood_Old__c);
            System.AssertEquals(null, history.Expected_Inherent_Impact_Old__c);
            System.AssertEquals(null, history.Expected_Inherent_Likelihood_Old__c);
            System.AssertEquals(null, history.Expected_Target_Impact_Old__c);
            System.AssertEquals(null, history.Expected_Target_Likelihood_Old__c);
        }

        risk.Expected_Residual_or_Current_Impact__c = '5';
        risk.Expected_Residual_or_Current_Likelihood__c = '5';
        risk.Expected_Inherent_Impact__c = '5';
        risk.Expected_Inherent_Likelihood__c = '5';
        risk.Expected_Target_Impact__c = '5';
        risk.Expected_Target_Likelihood__c = '5';

        update risk;

        histories = [
            select
            Expected_Current_Impact_New__c,
            Expected_Current_Impact_Old__c,
            Expected_Inherent_Impact_New__c,
            Expected_Inherent_Impact_Old__c,
            Expected_Target_Impact_New__c,
            Expected_Target_Impact_Old__c,
            Expected_Current_Likelihood_New__c,
            Expected_Current_Likelihood_Old__c,
            Expected_Inherent_Likelihood_New__c,
            Expected_Inherent_Likelihood_Old__c,
            Expected_Target_Likelihood_New__c,
            Expected_Target_Likelihood_Old__c,
            Change_Description__c
            from Risk_History__c
            where Risk__c = :risk.Id
            ];

        Boolean foundChangeHistory = false;

        // Check for history record for updated values.
        System.AssertEquals(2, histories.size(), 'Expected 2 history records, found ' + histories.size());
        for (Risk_History__c history : histories)
        {
            if (history.Change_Description__c.containsIgnoreCase('change'))
            {
                System.AssertEquals(5, history.Expected_Current_Impact_New__c);
                System.AssertEquals(0, history.Expected_Current_Impact_Old__c);
                System.AssertEquals(5, history.Expected_Inherent_Impact_New__c);
                System.AssertEquals(0, history.Expected_Inherent_Impact_Old__c);
                System.AssertEquals(5, history.Expected_Target_Impact_New__c);
                System.AssertEquals(0, history.Expected_Target_Impact_Old__c);

                System.AssertEquals(5, history.Expected_Current_Likelihood_New__c);
                System.AssertEquals(0, history.Expected_Current_Likelihood_Old__c);
                System.AssertEquals(5, history.Expected_Inherent_Likelihood_New__c);
                System.AssertEquals(0, history.Expected_Inherent_Likelihood_Old__c);
                System.AssertEquals(5, history.Expected_Target_Likelihood_New__c);
                System.AssertEquals(0, history.Expected_Target_Likelihood_Old__c);

                foundChangeHistory = true;
            }
        }

        System.Assert(foundChangeHistory, 'Did not find history record for change');
    }    
}