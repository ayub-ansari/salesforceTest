public class PIHeatMapController {

    public String PI_r { get; set; }
    
    public PageReference page = ApexPages.CurrentPage();
    public double cImpact {get;set;}
    public double cLikelihood {get;set;} 
    public String riskListTitle {get;set;}
    public String circle00Display {get;set;}
    public String circle11Display {get;set;}
    public String circle12Display {get;set;}
    public String circle13Display {get;set;}
    public String circle21Display {get;set;}
    public String circle22Display {get;set;}
    public String circle23Display {get;set;}
    public String circle31Display {get;set;}
    public String circle32Display {get;set;}
    public String circle33Display {get;set;}
    
    public Integer circle00Count {get;set;}
    public Integer circle11Count {get;set;}
    public Integer circle12Count {get;set;}
    public Integer circle13Count {get;set;}
    public Integer circle21Count {get;set;}
    public Integer circle22Count {get;set;}
    public Integer circle23Count {get;set;}
    public Integer circle31Count {get;set;}
    public Integer circle32Count {get;set;}
    public Integer circle33Count {get;set;}
    
    private static String DISPLAY_NONE = 'display: none;';
    private static String DISPLAY_BLOCK = 'display: block;';
    
    public List<PI_Risks__c> riskList = new List<PI_Risks__c>();
    
    String riskScore = '';
    String targetRiskScore = '';
    String inherentRiskScore = '';
    String currentRiskScore = '';        
    
    public String ImpactFilter {get;set;}
    public String LikelihoodFilter {get;set;}
    public String RiskTypeFilter {get;set;}
    public String RiskCodeFilter {get;set;}
    
    public PIHeatMapController() {
        resetDisplay();
    }
    
    public String getRiskScore() { return riskScore; }
    
    public List<SelectOption> getImpactFilterOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        options.add(new SelectOption('L','Low'));
        options.add(new SelectOption('M','Medium'));
        options.add(new SelectOption('H','High'));
        /*
        Schema.DescribeFieldResult fieldResult = PI_Risks__c.Impact__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        */
        return options;
    }
    
    public List<SelectOption> getLikelihoodFilterOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        options.add(new SelectOption('L','Low'));
        options.add(new SelectOption('M','Medium'));
        options.add(new SelectOption('H','High'));
        /*
        Schema.DescribeFieldResult fieldResult = PI_Risks__c.Likelihood__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        */
        return options;
    }
    
    public List<SelectOption> getRiskTypeFilterOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        Schema.DescribeFieldResult fieldResult = PI_Risks__c.Risk_type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        return options;
    }
    
    public List<SelectOption> getRiskCodeFilterOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        options.add(new SelectOption('1','1'));
        options.add(new SelectOption('2','2'));
        options.add(new SelectOption('3','3'));
        options.add(new SelectOption('4','4'));
        options.add(new SelectOption('5','5'));
        return options;
    }
    
    public List<PI_Risks__c> getRiskList () {     
    
        String soqlQuery = '';
        
        riskListTitle = 'Risk List '; 
        if (cImpact != null && cLikelihood != null) riskListTitle = riskListTitle + ' - Impact: ' + cImpact + ', Likelihood: ' +  cLikelihood;       
        
        //USE THIS FOR FILTER
        
        Map<String, RecordType> RecordTypeMap = new Map<String, RecordType>();
        
        if (cImpact != null || cLikelihood != null || (cImpact == 0 && cLikelihood == 0)) {
            al.NestableCondition criteria = new al.AndCondition();
            if (ImpactFilter != null) criteria.add(new al.FieldCondition('Impact__c').equals(ImpactFilter));
            if (LikelihoodFilter != null) criteria.add(new al.FieldCondition('Likelihood__c').equals(LikelihoodFilter));
            if (RiskTypeFilter != null) criteria.add(new al.FieldCondition('Risk_type__c').equals(RiskTypeFilter));
            if (RiskCodeFilter != null) criteria.add(new al.FieldCondition('Risk_code__c').equals(Integer.valueOf(RiskCodeFilter)));
            
            criteria.add(new al.FieldCondition('RecordType.Name').equals('Physicians Insurance Risk Assessment'));
            
            
            if (cImpact != null && cImpact != 0) criteria.add(new al.FieldCondition('Impact_number__c').equals(cImpact));
            if (cLikelihood != null && cLikelihood != 0) criteria.add(new al.FieldCondition('Likelihood_number__c').equals(cLikelihood));
            
            soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object>{'Name ','Risk_statement__c','Impact__c','Likelihood__c','Risk_type__c','Risk_code__c','Impact_number__c','Likelihood_number__c','Current_rank__c','Last_year_s_rank__c','Trend_indicator__c'})
                .fromx('PI_Risks__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                )
                .orderByx(new al.OrderBy('Impact_number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Likelihood_number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Risk_type__c').ascending().nullsLast())
                .toSoql(); 
            riskList = Database.query(soqlQuery);
            System.debug('QUERY: ' + soqlQuery);
        }
        else {
            resetDisplay();
            
            al.NestableCondition criteria = new al.AndCondition(); 
            if (ImpactFilter != null) criteria.add(new al.FieldCondition('Impact__c').equals(ImpactFilter));
            if (LikelihoodFilter != null) criteria.add(new al.FieldCondition('Likelihood__c').equals(LikelihoodFilter));
            if (RiskTypeFilter != null) criteria.add(new al.FieldCondition('Risk_type__c').equals(RiskTypeFilter));
            if (RiskCodeFilter != null) criteria.add(new al.FieldCondition('Risk_code__c').equals(Integer.valueOf(RiskCodeFilter)));
            
            criteria.add(new al.FieldCondition('RecordType.Name').equals('Physicians Insurance Risk Assessment'));
            
            if (cImpact != null && cImpact != 0) criteria.add(new al.FieldCondition('Impact_number__c').equals(cImpact));
            if (cLikelihood != null && cLikelihood != 0) criteria.add(new al.FieldCondition('Likelihood_number__c').equals(cLikelihood));
            
            soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object>{'Name ','Risk_statement__c','Impact__c','Likelihood__c','Risk_type__c','Risk_code__c','Impact_number__c','Likelihood_number__c','Current_rank__c','Last_year_s_rank__c','Trend_indicator__c'})
                .fromx('PI_Risks__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                )
                .orderByx(new al.OrderBy('Impact_number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Likelihood_number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Risk_type__c').ascending().nullsLast())
                .toSoql(); 
            riskList = Database.query(soqlQuery);
            System.debug('QUERY: ' + soqlQuery);
            
            for (PI_Risks__c r : riskList) {     
                if ((r.Impact_Number__c == null || r.Impact_number__c == 0 || r.Likelihood_number__c == null || r.Likelihood_number__c == 0)) {
                    if (circle00Display == DISPLAY_NONE) circle00Display = DISPLAY_BLOCK;   
                    circle00Count += 1;            
                }
                if (r.Impact_number__c == 1 && r.Likelihood_number__c == 1) {
                    if (circle11Display == DISPLAY_NONE) circle11Display = DISPLAY_BLOCK;  
                    circle11Count += 1;
                }      
                if (r.Impact_number__c == 1 && r.Likelihood_number__c == 2) {
                    if (circle12Display == DISPLAY_NONE) circle12Display = DISPLAY_BLOCK;
                    circle12Count += 1;
                }       
                if (r.Impact_number__c == 1 && r.Likelihood_number__c == 3) {
                    if (circle13Display == DISPLAY_NONE) circle13Display = DISPLAY_BLOCK;
                    circle13Count += 1;
                }
                
                if (r.Impact_number__c == 2 && r.Likelihood_number__c == 1) {
                    if (circle21Display == DISPLAY_NONE) circle21Display = DISPLAY_BLOCK;
                    circle21Count += 1;                 
                }    
                if (r.Impact_number__c == 2 && r.Likelihood_number__c == 2) {
                    if (circle22Display == DISPLAY_NONE) circle22Display = DISPLAY_BLOCK;
                    circle22Count += 1;                 
                }     
                if (r.Impact_number__c == 2 && r.Likelihood_number__c == 3) {
                    if (circle23Display == DISPLAY_NONE) circle23Display = DISPLAY_BLOCK;
                    circle23Count += 1;                
                }   
                
                if (r.Impact_number__c == 3 && r.Likelihood_number__c == 1) {
                    if (circle31Display == DISPLAY_NONE) circle31Display = DISPLAY_BLOCK;
                    circle31Count += 1;                
                } 
                if (r.Impact_number__c == 3 && r.Likelihood_number__c == 2) {
                    if (circle32Display == DISPLAY_NONE) circle32Display = DISPLAY_BLOCK;
                    circle32Count += 1;                 
                } 
                if (r.Impact_number__c == 3 && r.Likelihood_number__c == 3) {
                    if (circle33Display == DISPLAY_NONE) circle33Display = DISPLAY_BLOCK;
                    circle33Count += 1;                 
                }
            }
        }
        
        return riskList;
    }
    
    String oldImpactFilter;
    String oldLikelihoodFilter;
    String oldRiskTypeFilter;
    String oldRiskCodeFilter;
    
    public PageReference filterRiskList() { 
        cImpact = null;
        cLikelihood = null;         
        riskList = getRiskList();
        oldImpactFilter = ImpactFilter;
        oldLikelihoodFilter = LikelihoodFilter;
        oldRiskTypeFilter = RiskTypeFilter;
        oldRiskCodeFilter = RiskCodeFilter;

        return null;
    }
    
    public PageReference clearfilter() {
        
        cImpact = null;
        cLikelihood = null;        
        
        ImpactFilter = null;
        LikelihoodFilter = null;
        RiskTypeFilter = null;
        RiskCodeFilter = null;
        
        oldImpactFilter = null;
        oldLikelihoodFilter = null;
        oldRiskTypeFilter = null;     
        oldRiskCodeFilter = null;
        
        riskList = getRiskList();
        return null;
    }
    
    public pageReference cancelFilter() {
        cImpact = null;
        cLikelihood = null;        
        
        ImpactFilter = oldImpactFilter;
        LikelihoodFilter = oldLikelihoodFilter;
        RiskTypeFilter = oldRiskTypeFilter;
        RiskCodeFilter = oldRiskCodeFilter;
        
        riskList = getRiskList();
        return null;
    }
    
    public PageReference refreshRiskListWithCoordinates() { 
        riskList = getRiskList();
        return null;
    }
    
    private void resetDisplay() {
        
        circle00Display = DISPLAY_NONE;
        circle11Display = DISPLAY_NONE;
        circle12Display = DISPLAY_NONE;
        circle13Display = DISPLAY_NONE;
        circle21Display = DISPLAY_NONE;
        circle22Display = DISPLAY_NONE;
        circle23Display = DISPLAY_NONE;
        circle31Display = DISPLAY_NONE;
        circle32Display = DISPLAY_NONE;
        circle33Display = DISPLAY_NONE;
        
        circle00Count = 0;
        circle11Count = 0;
        circle12Count = 0;
        circle13Count = 0;
        circle21Count = 0;
        circle22Count = 0;
        circle23Count = 0;
        circle31Count = 0;
        circle32Count = 0;
        circle33Count = 0;
        
        cImpact = null;
        cLikelihood = null;       
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