public class CauseHeatMapController {
public PageReference page = ApexPages.CurrentPage();
    public double cX {get;set;}
    public double cY {get;set;} 
    public String causeListTitle {get;set;}
    public String circle00Display {get;set;}
    public String circle11Display {get;set;}
    public String circle12Display {get;set;}
    public String circle13Display {get;set;}
    public String circle14Display {get;set;}
    public String circle15Display {get;set;}
    
    public String circle21Display {get;set;}
    public String circle22Display {get;set;}
    public String circle23Display {get;set;}
    public String circle24Display {get;set;}
    public String circle25Display {get;set;}
    
    public String circle31Display {get;set;}
    public String circle32Display {get;set;}
    public String circle33Display {get;set;}
    public String circle34Display {get;set;}
    public String circle35Display {get;set;}
    
    public String circle41Display {get;set;}
    public String circle42Display {get;set;}
    public String circle43Display {get;set;}
    public String circle44Display {get;set;}
    public String circle45Display {get;set;}
    
    public String circle51Display {get;set;}
    public String circle52Display {get;set;}
    public String circle53Display {get;set;}
    public String circle54Display {get;set;}
    public String circle55Display {get;set;}
    
    public Integer circle00Count {get;set;}
    public Integer circle11Count {get;set;}
    public Integer circle12Count {get;set;}
    public Integer circle13Count {get;set;}
    public Integer circle14Count {get;set;}
    public Integer circle15Count {get;set;}
    
    public Integer circle21Count {get;set;}
    public Integer circle22Count {get;set;}
    public Integer circle23Count {get;set;}
    public Integer circle24Count {get;set;}
    public Integer circle25Count {get;set;}
    
    public Integer circle31Count {get;set;}
    public Integer circle32Count {get;set;}
    public Integer circle33Count {get;set;}
    public Integer circle34Count {get;set;}
    public Integer circle35Count {get;set;}
    
    public Integer circle41Count {get;set;}
    public Integer circle42Count {get;set;}
    public Integer circle43Count {get;set;}
    public Integer circle44Count {get;set;}
    public Integer circle45Count {get;set;}
    
    public Integer circle51Count {get;set;}
    public Integer circle52Count {get;set;}
    public Integer circle53Count {get;set;}
    public Integer circle54Count {get;set;}
    public Integer circle55Count {get;set;}
    
    private static String DISPLAY_NONE = 'display: none;';
    private static String DISPLAY_BLOCK = 'display: block;';
    
    public List<Cause__c> causeList = new List<Cause__c>();
    
    public String HazardName {get;set;}
    public String HazardSituation {get;set;}
    public String PreProbability {get;set;}
    public String ProbabilityOccuranceHarm {get;set;}
    public String SeverityOfHarm {get;set;}
    
    public CauseHeatMapController() {
        resetDisplay();
    }
    
    public List<SelectOption> getHazardFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        
        for( Hazard__c h : [select id, Name from Hazard__c order by Name])
        {
            options.add(new SelectOption(h.Id, h.Name));
        }
        return options;
    }
    
    public List<SelectOption> getHazardSituationFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        
        for( Hazard_Situation__c h : [select id, Name from Hazard_Situation__c order by Name])
        {
            options.add(new SelectOption(h.Id, h.Name));
        }
        return options;
    }
    
    public List<SelectOption> getPreProbabilityFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        
        Schema.DescribeFieldResult fieldResult = Cause__c.Pre_Probability__c.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        return options;
    }
    public List<SelectOption> getPreProbabilityOfOccOfHarmFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        options.add(new SelectOption('P1','P1'));
        options.add(new SelectOption('P2','P2'));
        options.add(new SelectOption('P3','P3'));
        options.add(new SelectOption('P4','P4'));
        options.add(new SelectOption('P5','P5'));
        return options;
    }
    
    public List<SelectOption> getSeverityOfHarmFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        options.add(new SelectOption('S1','S1'));
        options.add(new SelectOption('S2','S2'));
        options.add(new SelectOption('S3','S3'));
        options.add(new SelectOption('S4','S4'));
        options.add(new SelectOption('S5','S5'));
        return options;
    }
    
    //public List<MLN_Risk__c> getRiskList () {     
    public List<Cause__c> getCauseList () {
        String soqlQuery = '';
        
        causeListTitle = 'Cause List '; 
        if (cX != null && cY != null) causeListTitle = causeListTitle + ' - Severity Of Harm: ' + cX + ', Pre-Probability of Occurrence of Harm: ' +  cY;       
        
        //USE THIS FOR FILTER
        
        //Map<String, RecordType> RecordTypeMap = new Map<String, RecordType>();
        
        if (cX != null || cY != null || (cX == 0 && cY == 0)) {
            al.NestableCondition criteria = new al.AndCondition();
            if (HazardName != null) criteria.add(new al.FieldCondition('Hazard__c').equals(HazardName));
            if (HazardSituation != null) criteria.add(new al.FieldCondition('Hazardous_Situation__c').equals(HazardSituation));
            if (PreProbability != null) criteria.add(new al.FieldCondition('Pre_Probability__c').equals(PreProbability));
            if (ProbabilityOccuranceHarm != null) criteria.add(new al.FieldCondition('Probability_of_Occurrence_of_Harm__c').equals(ProbabilityOccuranceHarm));
            if (SeverityOfHarm != null) criteria.add(new al.FieldCondition('SH__c').equals(SeverityOfHarm));
            if (cX != null && cX != 0) criteria.add(new al.FieldCondition('SH_Number__c').equals(cX));
            if (cY != null && cY != 0) criteria.add(new al.FieldCondition('Pre_Prob_of_Occ_of_Harm_Number__c').equals(cY));
            
            soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object>{'SH__c', 'SH_Number__c', 'Risk_Level__c', 'Probability_of_Occurrence_of_Harm__c', 'Pre_Probability__c', 'Pre_Prob_of_Occ_of_Harm_Number__c', 'Name', 'Hazardous_Situation__r.Name', 'Hazardous_Situation__c', 'Hazard__r.Name', 'Hazard__c', 'Harm__r.Name', 'Harm__c'})
                .fromx('Cause__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                )
                .orderByx(new al.OrderBy('SH_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Pre_Prob_of_Occ_of_Harm_Number__c').descending().nullsLast())
                .toSoql(); 
            causeList = Database.query(soqlQuery);
            System.debug('QUERY: ' + soqlQuery);           
        }
        else {
            resetDisplay();
            
            al.NestableCondition criteria = new al.AndCondition(); 
            if (HazardName != null) criteria.add(new al.FieldCondition('Hazard__c').equals(HazardName));
            if (HazardSituation != null) criteria.add(new al.FieldCondition('Hazardous_Situation__c').equals(HazardSituation));
            if (PreProbability != null) criteria.add(new al.FieldCondition('Pre_Probability__c').equals(PreProbability));
            if (ProbabilityOccuranceHarm != null) criteria.add(new al.FieldCondition('Probability_of_Occurrence_of_Harm__c').equals(ProbabilityOccuranceHarm));
            if (SeverityOfHarm != null) criteria.add(new al.FieldCondition('SH__c').equals(SeverityOfHarm));
            if (cX != null && cX != 0) criteria.add(new al.FieldCondition('SH_Number__c').equals(cX));
            if (cY != null && cY != 0) criteria.add(new al.FieldCondition('Pre_Prob_of_Occ_of_Harm_Number__c').equals(cY));
            
            soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object>{'SH__c', 'SH_Number__c', 'Risk_Level__c', 'Probability_of_Occurrence_of_Harm__c', 'Pre_Probability__c', 'Pre_Prob_of_Occ_of_Harm_Number__c', 'Name', 'Hazardous_Situation__r.Name', 'Hazardous_Situation__c', 'Hazard__r.Name', 'Hazard__c', 'Harm__r.Name', 'Harm__c'})
                .fromx('Cause__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                )
                .orderByx(new al.OrderBy('SH_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Pre_Prob_of_Occ_of_Harm_Number__c').descending().nullsLast())
                .toSoql(); 
            causeList = Database.query(soqlQuery);
            System.debug('QUERY: ' + soqlQuery);  
            for (Cause__c r : causeList) {     
                
                if ((r.SH_Number__c == null || r.SH_Number__c == 0 || r.Pre_Prob_of_Occ_of_Harm_Number__c == null || r.Pre_Prob_of_Occ_of_Harm_Number__c == 0)) {
                    if (circle00Display == DISPLAY_NONE) circle00Display = DISPLAY_BLOCK;   
                    circle00Count += 1;            
                }
                if (r.SH_Number__c == 1 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 1) {
                    if (circle11Display == DISPLAY_NONE) circle11Display = DISPLAY_BLOCK;  
                    circle11Count += 1;
                }      
                if (r.SH_Number__c == 1 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 2) {
                    if (circle12Display == DISPLAY_NONE) circle12Display = DISPLAY_BLOCK;
                    circle12Count += 1;
                }       
                if (r.SH_Number__c == 1 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 3) {
                    if (circle13Display == DISPLAY_NONE) circle13Display = DISPLAY_BLOCK;
                    circle13Count += 1;
                }       
                if (r.SH_Number__c == 1 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 4) {
                    if (circle14Display == DISPLAY_NONE) circle14Display = DISPLAY_BLOCK;
                    circle14Count += 1;
                }
                if (r.SH_Number__c == 1 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 5) {
                    if (circle15Display == DISPLAY_NONE) circle15Display = DISPLAY_BLOCK;
                    circle15Count += 1;
                }
                       
                if (r.SH_Number__c == 2 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 1) {
                    if (circle21Display == DISPLAY_NONE) circle21Display = DISPLAY_BLOCK;
                    circle21Count += 1;                 
                }    
                if (r.SH_Number__c == 2 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 2) {
                    if (circle22Display == DISPLAY_NONE) circle22Display = DISPLAY_BLOCK;
                    circle22Count += 1;                 
                }     
                if (r.SH_Number__c == 2 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 3) {
                    if (circle23Display == DISPLAY_NONE) circle23Display = DISPLAY_BLOCK;
                    circle23Count += 1;                
                }   
                if (r.SH_Number__c == 2 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 4) {
                    if (circle24Display == DISPLAY_NONE) circle24Display = DISPLAY_BLOCK;
                    circle24Count += 1;                
                }
                if (r.SH_Number__c == 2 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 5) {
                    if (circle25Display == DISPLAY_NONE) circle25Display = DISPLAY_BLOCK;
                    circle25Count += 1;
                }
                    
                if (r.SH_Number__c == 3 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 1) {
                    if (circle31Display == DISPLAY_NONE) circle31Display = DISPLAY_BLOCK;
                    circle31Count += 1;                
                } 
                if (r.SH_Number__c == 3 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 2) {
                    if (circle32Display == DISPLAY_NONE) circle32Display = DISPLAY_BLOCK;
                    circle32Count += 1;                 
                } 
                if (r.SH_Number__c == 3 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 3) {
                    if (circle33Display == DISPLAY_NONE) circle33Display = DISPLAY_BLOCK;
                    circle33Count += 1;                 
                } 
                if (r.SH_Number__c == 3 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 4) {
                    if (circle34Display == DISPLAY_NONE) circle34Display = DISPLAY_BLOCK;
                    circle34Count += 1;                 
                }
                if (r.SH_Number__c == 3 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 5) {
                    if (circle35Display == DISPLAY_NONE) circle35Display = DISPLAY_BLOCK;
                    circle35Count += 1;
                }
                 
                if (r.SH_Number__c == 4 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 1) {
                    if (circle41Display == DISPLAY_NONE) circle41Display = DISPLAY_BLOCK;
                    circle41Count += 1;                 
                } 
                if (r.SH_Number__c == 4 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 2) {
                    if (circle42Display == DISPLAY_NONE) circle42Display = DISPLAY_BLOCK;
                    circle42Count += 1;                 
                } 
                if (r.SH_Number__c == 4 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 3) {
                    if (circle43Display == DISPLAY_NONE) circle43Display = DISPLAY_BLOCK;
                    circle43Count += 1;                 
                } 
                if (r.SH_Number__c == 4 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 4) {
                    if (circle44Display == DISPLAY_NONE) circle44Display = DISPLAY_BLOCK;
                    circle44Count += 1;                 
                }
                if (r.SH_Number__c == 4 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 5) {
                    if (circle45Display == DISPLAY_NONE) circle45Display = DISPLAY_BLOCK;
                    circle45Count += 1;
                }
                
                if (r.SH_Number__c == 5 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 1) {
                    if (circle51Display == DISPLAY_NONE) circle51Display = DISPLAY_BLOCK;
                    circle51Count += 1;                 
                } 
                if (r.SH_Number__c == 5 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 2) {
                    if (circle52Display == DISPLAY_NONE) circle52Display = DISPLAY_BLOCK;
                    circle52Count += 1;                 
                } 
                if (r.SH_Number__c == 5 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 3) {
                    if (circle53Display == DISPLAY_NONE) circle53Display = DISPLAY_BLOCK;
                    circle53Count += 1;                 
                } 
                if (r.SH_Number__c == 5 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 4) {
                    if (circle54Display == DISPLAY_NONE) circle54Display = DISPLAY_BLOCK;
                    circle54Count += 1;                 
                }
                if (r.SH_Number__c == 5 && r.Pre_Prob_of_Occ_of_Harm_Number__c == 5) {
                    if (circle55Display == DISPLAY_NONE) circle55Display = DISPLAY_BLOCK;
                    circle55Count += 1;
                }
            }
        }
        return causeList;
    }
    
    String oldHazardName;
    String oldHazardSituation;
    String oldPreProbability;
    String oldProbabilityOccuranceHarm;
    String oldSeverityOfHarm;
    
    public PageReference filterCauseList() { 
        cX = null;
        cY = null;         
        causeList = getCauseList();
        oldHazardName = HazardName;
        oldHazardSituation = HazardSituation;
        oldPreProbability = PreProbability;
        oldProbabilityOccuranceHarm = ProbabilityOccuranceHarm;
        oldSeverityOfHarm = SeverityOfHarm;

        return null;
    }
    
    public PageReference clearfilter() {
        
        cX = null;
        cY = null;        
        HazardName = null;
        HazardSituation = null;
        PreProbability = null;
        ProbabilityOccuranceHarm = null;
        SeverityOfHarm = null;
        
        oldHazardName = null;
        oldHazardSituation = null;
        oldPreProbability = null;
        oldProbabilityOccuranceHarm = null;     
        oldSeverityOfHarm = null;
        
        causeList = getCauseList();
        return null;
    }
    
    public pageReference cancelFilter() {
        cX = null;
        cY = null;        
        HazardName = oldHazardName;
        HazardSituation = oldHazardSituation;
        PreProbability = oldPreProbability;
        ProbabilityOccuranceHarm = oldProbabilityOccuranceHarm;
        SeverityOfHarm = oldSeverityOfHarm;
        
        causeList = getCauseList();
        return null;
    }
    
    public PageReference refreshCauseListWithCoordinates() { 
        causeList = getCauseList();
        return null;
    }
    
    private void resetDisplay() {
        
        circle00Display = DISPLAY_NONE;
        circle11Display = DISPLAY_NONE;
        circle12Display = DISPLAY_NONE;
        circle13Display = DISPLAY_NONE;
        circle14Display = DISPLAY_NONE;
        circle15Display = DISPLAY_NONE;
        circle21Display = DISPLAY_NONE;
        circle22Display = DISPLAY_NONE;
        circle23Display = DISPLAY_NONE;
        circle24Display = DISPLAY_NONE;
        circle25Display = DISPLAY_NONE;
        circle31Display = DISPLAY_NONE;
        circle32Display = DISPLAY_NONE;
        circle33Display = DISPLAY_NONE;
        circle34Display = DISPLAY_NONE;
        circle35Display = DISPLAY_NONE;
        circle41Display = DISPLAY_NONE;
        circle42Display = DISPLAY_NONE;
        circle43Display = DISPLAY_NONE;
        circle44Display = DISPLAY_NONE;
        circle45Display = DISPLAY_NONE;
        circle51Display = DISPLAY_NONE;
        circle52Display = DISPLAY_NONE;
        circle53Display = DISPLAY_NONE;
        circle54Display = DISPLAY_NONE;
        circle55Display = DISPLAY_NONE;
        
        circle00Count = 0;
        circle11Count = 0;
        circle12Count = 0;
        circle13Count = 0;
        circle14Count = 0;
        circle15Count = 0;
        circle21Count = 0;
        circle22Count = 0;
        circle23Count = 0;
        circle24Count = 0;
        circle25Count = 0;
        circle31Count = 0;
        circle32Count = 0;
        circle33Count = 0;
        circle34Count = 0;
        circle35Count = 0;
        circle41Count = 0;
        circle42Count = 0;
        circle43Count = 0;
        circle44Count = 0;
        circle45Count = 0;
        circle51Count = 0;
        circle52Count = 0;
        circle53Count = 0;
        circle54Count = 0;
        circle55Count = 0;
        
        cX = null;
        cY = null;       
    }   
    
    public String getChooserender() {
        if (ApexPages.currentPage().getParameters().get('p') != null) return 'pdf';
        else return null;
    }
    
    public PageReference deliverAsPDF() {
        page.getParameters().put('p','p');
        return page;
    }
}