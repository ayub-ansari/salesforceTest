@isTest
public class testHeatMapCode {   
    
    @isTest (SeeAllData=true)
    static void testHeatMapController () {

        //RecordType rt = [Select  Id From RecordType
        //                  Where  Name = 'Risk' and SobjectType = 'Risk__c' Limit 1];

        List<Risk__c> risks = new List<Risk__c>();
        Risk__c  r = new Risk__c (Expected_Residual_or_Current_Impact__c = null,
                               Expected_Residual_or_Current_Likelihood__c = null);
        //r.RecordType = rt;           
        risks.add(r);                      
        Risk__c  r0 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '1');
        //r0.RecordType = rt;                               
        risks.add(r0);      
        Risk__c  r1 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '2');
       // r1.RecordType = rt;                              
        risks.add(r1); 
        Risk__c  r2 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '3');
       // r2.RecordType = rt;                               
        risks.add(r2);              
        insert risks;
        
        //Risk__c r3 = [ SELECT Id, RecordType.Name, Expected_Current_Impact_Text__c, Expected_Current_Likelihood_Text__c FROM Risk__c WHERE Id = :r2.Id ];
        
        //System.assertEquals(4, risks.size());
       // System.assertEquals('Risk', r3.RecordType.Name);
        //System.assertEquals('1', r3.Expected_Current_Impact_Text__c);
       // System.assertEquals('3', r2.Expected_Current_Likelihood_Text__c); 
                                     
        HeatMapController hpc = new HeatMapController();
        hpc.cImpact = '1';
        hpc.cLikelihood = '3';
        List<Risk__c> rl = hpc.getRiskList();
        hpc.cImpact = '0';
        hpc.cLikelihood = '0';
        List<Risk__c> rl0 = hpc.getRiskList();
        hpc.cImpact = '';
        hpc.cLikelihood = '';
        List<Risk__c> rl1 = hpc.getRiskList();
        
        OpportunityHeatMapController hpe = new OpportunityHeatMapController();
        hpe.cImpact = '2';
        hpe.cLikelihood = '3';
        List<Risk__c> rl4 = hpe.getRiskList();
        hpe.cImpact = '0';
        hpe.cLikelihood = '0';
        List<Risk__c> rl5 = hpe.getRiskList();
        //hpe.cImpact = '';
        //hpe.cLikelihood = '';
        List<Risk__c> rl6 = hpe.getRiskList();
        
        
        HeatMapController hpc3 = new HeatMapController();
        hpc3.cImpact = ''; 
        hpc3.cLikelihood = '';
        List<Risk__c> rl3 = hpc3.getRiskList();
        hpc3.cImpact = '3'; 
        hpc3.cLikelihood = '4';
        hpc3.risk = r1;
        List<Risk__c> rl7 = hpc3.getRiskList();
        List<SelectOption> test = hpc3.getScoreItems();
        String test2 = hpc3.getRiskScore();
        hpc3.setRiskScore('12');
        List<SelectOption> test5 = hpc3.getValueOptions();
        hpc3.ValueFilter = 'Target';
        List<Risk__c> rl8 = hpc3.getRiskList();
        hpc3.cImpact = '';
        hpc3.cLikelihood = '';
        rl7 = hpc3.getRiskList();
        hpc3.cImpact = '0'; 
        hpc3.cLikelihood = '0';
        rl7 = hpc3.getRiskList();
        hpc3.ValueFilter = 'Inherent';
        hpc3.cImpact = '';
        hpc3.cLikelihood = '';
        rl7 = hpc3.getRiskList();
        hpc3.cImpact = '3'; 
        hpc3.cLikelihood = '4';
        List<Risk__c> rl9 = hpc3.getRiskList();
        hpc3.cImpact = '0'; 
        hpc3.cLikelihood = '0';
        rl7 = hpc3.getRiskList();
        
        OpportunityHeatMapController hpc4 = new OpportunityHeatMapController();
        hpc4.cImpact = ''; 
        hpc4.cLikelihood = '';
        rl9 = hpc4.getRiskList();
        hpc4.cImpact = '3'; 
        hpc4.cLikelihood = '4';
        rl9 = hpc4.getRiskList();
        test = hpc4.getScoreItems();
        test2 = hpc4.getRiskScore();
        hpc4.setRiskScore('12');
        test5 = hpc4.getValueOptions();
        hpc4.ValueFilter = 'Target';
        rl9 = hpc4.getRiskList();
        hpc4.cImpact = '';
        hpc4.cLikelihood = '';
        rl9 = hpc4.getRiskList();
        hpc4.cImpact = '0'; 
        hpc4.cLikelihood = '0';
        rl9 = hpc4.getRiskList();
        hpc4.ValueFilter = 'Inherent';
        hpc4.cImpact = '';
        hpc4.cLikelihood = '';
        rl9 = hpc4.getRiskList();
        hpc4.cImpact = '3'; 
        hpc4.cLikelihood = '4';
        rl9 = hpc4.getRiskList();
        hpc4.cImpact = '0'; 
        hpc4.cLikelihood = '0';
        rl9 = hpc4.getRiskList();
        test2 = hpc4.getChooserender();
        PageReference test45 = hpc4.deliverAsPDF();
        test45 = hpc4.refreshRiskListWithCoordinates();
        test45 = hpc4.refreshRiskList();
        
        PageReference pr = hpc.refreshRiskList();
        PageReference pr0 = hpc.refreshRiskListWithCoordinates(); 
        String s = hpc.getChooserender();
        PageReference pr1 = hpc.deliverAsPDF();
    }


    @isTest (SeeAllData=true)
    static void testHeatMap3x3And10x10Controller () {

        List<Risk__c> risks = new List<Risk__c>();
        Risk__c  r = new Risk__c (Expected_Residual_or_Current_Impact__c = null,
                               Expected_Residual_or_Current_Likelihood__c = null);         
        risks.add(r);                      
        Risk__c  r0 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '1');                              
        risks.add(r0);      
        Risk__c  r1 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '2');                              
        risks.add(r1); 
        Risk__c  r2 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '3');                              
        risks.add(r2);              
        insert risks;
        
        System.assertEquals(4, risks.size()); 
                                     
        HeatMapController hpc = new HeatMapController();
        hpc.cImpact = '2';
        hpc.cLikelihood = '3';
        List<Risk__c> rl = hpc.getRiskList();
        hpc.cImpact = '0';
        hpc.cLikelihood = '0';
        //List<Risk__c> rl0 = hpc.getRiskList();
        hpc.cImpact = '';
        hpc.cLikelihood = '';
        List<Risk__c> rl1 = hpc.getRiskList();
        
        HeatMapController hpc2 = new HeatMapController();
        hpc2.cImpact = '2';
        hpc2.cLikelihood = '3';
        List<Risk__c> rl2 = hpc2.getRiskList();
        hpc2.cImpact = '0';
        hpc2.cLikelihood = '0';
        List<Risk__c> rl0 = hpc2.getRiskList();
        
        HeatMapController hpc3 = new HeatMapController();
        hpc3.cImpact = ''; 
        hpc3.cLikelihood = '';
        List<Risk__c> rl3 = hpc3.getRiskList();
        hpc3.cImpact = '3'; 
        hpc3.cLikelihood = '4';
        List<Risk__c> rl4 = hpc3.getRiskList();
        List<SelectOption> test = hpc3.getScoreItems();
        String test2 = hpc3.getRiskScore();
        hpc3.setRiskScore('12');
        List<SelectOption> test5 = hpc3.getValueOptions();
        hpc3.ValueFilter = 'Target';
        List<Risk__c> rl5 = hpc3.getRiskList();
        hpc3.cImpact = '';
        hpc3.cLikelihood = '';
        rl5 = hpc3.getRiskList();
        hpc3.cImpact = '0'; 
        hpc3.cLikelihood = '0';
        rl5 = hpc3.getRiskList();
        hpc3.ValueFilter = 'Inherent';
        hpc3.cImpact = '';
        hpc3.cLikelihood = '';
        rl5 = hpc3.getRiskList();
        hpc3.cImpact = '3'; 
        hpc3.cLikelihood = '4';
        List<Risk__c> rl6 = hpc3.getRiskList();
        hpc3.cImpact = '0'; 
        hpc3.cLikelihood = '0';
        rl5 = hpc3.getRiskList();
        test2 = hpc3.getChooserender();
        
        HeatMapController hpc6 = new HeatMapController();
        hpc6.cImpact = ''; 
        hpc6.cLikelihood = '';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '3'; 
        hpc6.cLikelihood = '4';
        rl5 = hpc6.getRiskList();
        test = hpc6.getScoreItems();
        test2 = hpc6.getRiskScore();
        hpc6.setRiskScore('12');
        test5 = hpc6.getValueOptions();
        hpc6.ValueFilter = 'Target';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '';
        hpc6.cLikelihood = '';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '0'; 
        hpc6.cLikelihood = '0';
        rl5 = hpc6.getRiskList();
        hpc6.ValueFilter = 'Inherent';
        hpc6.cImpact = '';
        hpc6.cLikelihood = '';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '3'; 
        hpc6.cLikelihood = '4';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '0'; 
        hpc6.cLikelihood = '0';
        rl5 = hpc6.getRiskList();

        PageReference pr = hpc.refreshRiskList();
        PageReference pr0 = hpc.refreshRiskListWithCoordinates(); 
        String s = hpc.getChooserender();
        PageReference pr1 = hpc.deliverAsPDF();

        PageReference pr2 = hpc2.refreshRiskList();
        PageReference pr3 = hpc2.refreshRiskListWithCoordinates(); 
        String s2 = hpc2.getChooserender();
        PageReference pr4 = hpc2.deliverAsPDF();
    }
    
    
    @isTest (SeeAllData=true)
    static void testOpportunityHeatMap3x3And10x10Controller () {

        List<Risk__c> risks = new List<Risk__c>();
        Risk__c  r = new Risk__c (Expected_Residual_or_Current_Impact__c = null,
                               Expected_Residual_or_Current_Likelihood__c = null);         
        risks.add(r);                      
        Risk__c  r0 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '1');                              
        risks.add(r0);      
        Risk__c  r1 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '2');                              
        risks.add(r1); 
        Risk__c  r2 = new Risk__c (Expected_Residual_or_Current_Impact__c = '1',
                               Expected_Residual_or_Current_Likelihood__c = '3');                              
        risks.add(r2);              
        insert risks;
        
        System.assertEquals(4, risks.size()); 
                                     
        OpportunityHeatMapController hpc = new OpportunityHeatMapController();
        hpc.cImpact = '2';
        hpc.cLikelihood = '3';
        List<Risk__c> rl = hpc.getRiskList();
        hpc.cImpact = '0';
        hpc.cLikelihood = '0';
        //List<Risk__c> rl0 = hpc.getRiskList();
        hpc.cImpact = '';
        hpc.cLikelihood = '';
        List<Risk__c> rl1 = hpc.getRiskList();
        
        OpportunityHeatMapController hpc2 = new OpportunityHeatMapController();
        hpc2.cImpact = '2';
        hpc2.cLikelihood = '3';
        List<Risk__c> rl2 = hpc2.getRiskList();
        hpc2.cImpact = '0';
        hpc2.cLikelihood = '0';
        List<Risk__c> rl0 = hpc2.getRiskList();
        
        OpportunityHeatMapController hpc3 = new OpportunityHeatMapController();
        hpc3.cImpact = ''; 
        hpc3.cLikelihood = '';
        List<Risk__c> rl3 = hpc3.getRiskList();
        hpc3.cImpact = '3'; 
        hpc3.cLikelihood = '4';
        List<Risk__c> rl4 = hpc3.getRiskList();
        List<SelectOption> test = hpc3.getScoreItems();
        String test2 = hpc3.getRiskScore();
        hpc3.setRiskScore('12');
        List<SelectOption> test5 = hpc3.getValueOptions();
        hpc3.ValueFilter = 'Target';
        List<Risk__c> rl5 = hpc3.getRiskList();
        hpc3.cImpact = '';
        hpc3.cLikelihood = '';
        rl5 = hpc3.getRiskList();
        hpc3.cImpact = '0'; 
        hpc3.cLikelihood = '0';
        rl5 = hpc3.getRiskList();
        hpc3.ValueFilter = 'Inherent';
        hpc3.cImpact = '';
        hpc3.cLikelihood = '';
        rl5 = hpc3.getRiskList();
        hpc3.cImpact = '3'; 
        hpc3.cLikelihood = '4';
        List<Risk__c> rl6 = hpc3.getRiskList();
        hpc3.cImpact = '0'; 
        hpc3.cLikelihood = '0';
        rl5 = hpc3.getRiskList();
        test2 = hpc3.getChooserender();
        
        OpportunityHeatMapController hpc6 = new OpportunityHeatMapController();
        hpc6.cImpact = ''; 
        hpc6.cLikelihood = '';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '3'; 
        hpc6.cLikelihood = '4';
        rl5 = hpc6.getRiskList();
        test = hpc6.getScoreItems();
        test2 = hpc6.getRiskScore();
        hpc6.setRiskScore('12');
        test5 = hpc6.getValueOptions();
        hpc6.ValueFilter = 'Target';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '';
        hpc6.cLikelihood = '';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '0'; 
        hpc6.cLikelihood = '0';
        rl5 = hpc6.getRiskList();
        hpc6.ValueFilter = 'Inherent';
        hpc6.cImpact = '';
        hpc6.cLikelihood = '';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '3'; 
        hpc6.cLikelihood = '4';
        rl5 = hpc6.getRiskList();
        hpc6.cImpact = '0'; 
        hpc6.cLikelihood = '0';
        rl5 = hpc6.getRiskList();

        PageReference pr = hpc.refreshRiskList();
        PageReference pr0 = hpc.refreshRiskListWithCoordinates(); 
        String s = hpc.getChooserender();
        PageReference pr1 = hpc.deliverAsPDF();

        PageReference pr2 = hpc2.refreshRiskList();
        PageReference pr3 = hpc2.refreshRiskListWithCoordinates(); 
        String s2 = hpc2.getChooserender();
        PageReference pr4 = hpc2.deliverAsPDF();
    }    
}