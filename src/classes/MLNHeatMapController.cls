public class MLNHeatMapController {
    
    public PageReference page = ApexPages.CurrentPage();
    public double cImpact {get;set;}
    public double cLikelihood {get;set;} 
    public String riskListTitle {get;set;}
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
    
    public List<MLN_Risk__c> riskList = new List<MLN_Risk__c>();
    
    String riskScore = '';
    String targetRiskScore = '';
    String inherentRiskScore = '';
    String currentRiskScore = '';        
    
    public String ImpactFilter {get;set;}
    public String LikelihoodFilter {get;set;}
    public String ParentCategoryFilter {get;set;}
    public String RiskStatusFilter {get;set;}
    public String RiskCategory1Filter {get;set;}
    
    public MLNHeatMapController() {
        resetDisplay();
    }
    
    public String getRiskScore() { return riskScore; }
    
    public List<SelectOption> getImpactFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        
        Schema.DescribeFieldResult fieldResult = MLN_Risk__c.Current_Risk_Impact__c.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        return options;
    }
    
    public List<SelectOption> getLikelihoodFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        
        Schema.DescribeFieldResult fieldResult = MLN_Risk__c.Current_Risk_Likelihood__c.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        return options;
    }
    
    public List<SelectOption> getPCFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        
        Schema.DescribeFieldResult fieldResult = MLN_Risk__c.Parent_Category__c.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        return options;
    }
    
    public List<SelectOption> getRSFilteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        
        Schema.DescribeFieldResult fieldResult = MLN_Risk__c.Risk_Status__c.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        return options;
    }
    
    public List<SelectOption> getRC1Filteroptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-None-'));
        
        Schema.DescribeFieldResult fieldResult = MLN_Risk__c.Risk_Category_One__c.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getValue(), f.getValue()));
        }
        return options;
    }
    
    public List<MLN_Risk__c> getRiskList () {     
    
        String soqlQuery = '';
        
        riskListTitle = 'Risk List '; 
        if (cImpact != null && cLikelihood != null) riskListTitle = riskListTitle + ' - Impact: ' + cImpact + ', Likelihood: ' +  cLikelihood;       
        
        //USE THIS FOR FILTER
        
        Map<String, RecordType> RecordTypeMap = new Map<String, RecordType>();
        
        /*for(RecordType rt:  [select Id, Name from RecordType where SobjectType = 'MLN_Risk__c'])
        {
            system.debug('rt.Name--'+rt.Name);
            system.debug('rt--'+rt);
            RecordTypeMap.put(rt.Name, rt);
        }
        
        RecordType raRecordType = null;
        
        if (RecordTypeFilter != null) {
            raRecordType = RecordTypeMap.get(RecordTypeFilter);
        }*/
                
        if (cImpact != null || cLikelihood != null || (cImpact == 0 && cLikelihood == 0)) {
            //if (cImpact == '0' && cLikelihood == '0') {
            //    cImpact = null; 
            //    cLikelihood = null;
            //}
            
            al.NestableCondition criteria = new al.AndCondition();
            if (ImpactFilter != null) criteria.add(new al.FieldCondition('Current_Risk_Impact__c').equals(ImpactFilter));
            if (LikelihoodFilter != null) criteria.add(new al.FieldCondition('Current_Risk_Likelihood__c').equals(LikelihoodFilter));
            if (ParentCategoryFilter != null) criteria.add(new al.FieldCondition('Parent_Category__c').equals(ParentCategoryFilter));
            if (RiskStatusFilter != null) criteria.add(new al.FieldCondition('Risk_Status__c').equals(RiskStatusFilter));
            if (RiskCategory1Filter != null) criteria.add(new al.FieldCondition('Risk_Category_One__c').equals(RiskCategory1Filter));
            
            //if (raRecordType != null) criteria.add(new al.FieldCondition('RecordType.id').equals(raRecordType.id));
  
            /*if(cImpact == 0 || cLikelihood == 0)
            {
                criteria.add(
                    new al.OrCondition()
                    .add(new al.FieldCondition('Current_Impact_Number__c').equals(cImpact))
                    .add(new al.FieldCondition('Current_Likelihood_Number__c').equals(cLikelihood))
                );
            }
            else*/
            //{               
                if (cImpact != null && cImpact != 0) criteria.add(new al.FieldCondition('Current_Impact_Number__c').equals(cImpact));
                if (cLikelihood != null && cLikelihood != 0) criteria.add(new al.FieldCondition('Current_Likelihood_Number__c').equals(cLikelihood));
            //}
            
            soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object>{'Id', 'Parent_Category__c', 'Name', 'Speed_to_onset__c', 'Description__c', 'Risk_Category_One__c', 'Risk_Status__c', 'Current_Impact__c','Current_Risk_Impact__c', 'Current_Impact_Number__c', 'Parent_Category__c', 'Business_Synergy__c', 'Current_Likelihood__c','Current_Risk_Likelihood__c', 'Preparedness_Confidence_Level__c', 'Current_Likelihood_Number__c', 'Current_Risk_Rating__c'})
                .fromx('MLN_Risk__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                )
                .orderByx(new al.OrderBy('Current_Risk_Rating__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Current_Impact_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Current_Likelihood_Number__c').descending().nullsLast())
                .toSoql(); 
            riskList = Database.query(soqlQuery);
            System.debug('QUERY: ' + soqlQuery);           
        }
        else {
            resetDisplay();
            
            al.NestableCondition criteria = new al.AndCondition(); 
            if (ImpactFilter != null) criteria.add(new al.FieldCondition('Current_Risk_Impact__c').equals(ImpactFilter));
            if (LikelihoodFilter != null) criteria.add(new al.FieldCondition('Current_Risk_Likelihood__c').equals(LikelihoodFilter));
            if (ParentCategoryFilter != null) criteria.add(new al.FieldCondition('Parent_Category__c').equals(ParentCategoryFilter));
            if (RiskStatusFilter != null) criteria.add(new al.FieldCondition('Risk_Status__c').equals(RiskStatusFilter));
            if (RiskCategory1Filter != null) criteria.add(new al.FieldCondition('Risk_Category_One__c').equals(RiskCategory1Filter));
            
            //if (raRecordType != null) criteria.add(new al.FieldCondition('RecordType.id').equals(raRecordType.id));
  
            if (cImpact != null && cImpact != 0) criteria.add(new al.FieldCondition('Current_Impact_Number__c').equals(cImpact));
            if (cLikelihood != null && cLikelihood != 0) criteria.add(new al.FieldCondition('Current_Likelihood_Number__c').equals(cLikelihood));
            
            soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object>{'Id', 'Parent_Category__c', 'Name', 'Speed_to_onset__c', 'Description__c', 'Risk_Category_One__c', 'Risk_Status__c', 'Current_Impact__c','Current_Risk_Impact__c', 'Current_Impact_Number__c', 'Parent_Category__c', 'Business_Synergy__c', 'Current_Likelihood__c','Current_Risk_Likelihood__c', 'Preparedness_Confidence_Level__c', 'Current_Likelihood_Number__c', 'Current_Risk_Rating__c'})
                .fromx('MLN_Risk__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                )
                .orderByx(new al.OrderBy('Current_Risk_Rating__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Current_Impact_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Current_Likelihood_Number__c').descending().nullsLast())                         
                .toSoql(); 
            riskList = Database.query(soqlQuery);
            System.debug('QUERY: ' + soqlQuery);  
            for (MLN_Risk__c r : riskList) {     
                
                if ((r.Current_Impact_Number__c == null || r.Current_Impact_Number__c == 0 || r.Current_Likelihood_Number__c == null || r.Current_Likelihood_Number__c == 0)) {
                    if (circle00Display == DISPLAY_NONE) circle00Display = DISPLAY_BLOCK;   
                    circle00Count += 1;            
                }
                if (r.Current_Impact_Number__c == 1 && r.Current_Likelihood_Number__c == 1) {
                    if (circle11Display == DISPLAY_NONE) circle11Display = DISPLAY_BLOCK;  
                    circle11Count += 1;
                }      
                if (r.Current_Impact_Number__c == 1 && r.Current_Likelihood_Number__c == 2) {
                    if (circle12Display == DISPLAY_NONE) circle12Display = DISPLAY_BLOCK;
                    circle12Count += 1;
                }       
                if (r.Current_Impact_Number__c == 1 && r.Current_Likelihood_Number__c == 3) {
                    if (circle13Display == DISPLAY_NONE) circle13Display = DISPLAY_BLOCK;
                    circle13Count += 1;
                }       
                if (r.Current_Impact_Number__c == 1 && r.Current_Likelihood_Number__c == 4) {
                    if (circle14Display == DISPLAY_NONE) circle14Display = DISPLAY_BLOCK;
                    circle14Count += 1;
                }       
                if (r.Current_Impact_Number__c == 1 && r.Current_Likelihood_Number__c == 5) {
                    if (circle15Display == DISPLAY_NONE) circle15Display = DISPLAY_BLOCK;
                    circle15Count += 1;
                }       
                if (r.Current_Impact_Number__c == 2 && r.Current_Likelihood_Number__c == 1) {
                    if (circle21Display == DISPLAY_NONE) circle21Display = DISPLAY_BLOCK;
                    circle21Count += 1;                 
                }    
                if (r.Current_Impact_Number__c == 2 && r.Current_Likelihood_Number__c == 2) {
                    if (circle22Display == DISPLAY_NONE) circle22Display = DISPLAY_BLOCK;
                    circle22Count += 1;                 
                }     
                if (r.Current_Impact_Number__c == 2 && r.Current_Likelihood_Number__c == 3) {
                    if (circle23Display == DISPLAY_NONE) circle23Display = DISPLAY_BLOCK;
                    circle23Count += 1;                
                }   
                if (r.Current_Impact_Number__c == 2 && r.Current_Likelihood_Number__c == 4) {
                    if (circle24Display == DISPLAY_NONE) circle24Display = DISPLAY_BLOCK;
                    circle24Count += 1;                
                }    
                if (r.Current_Impact_Number__c == 2 && r.Current_Likelihood_Number__c == 5) {
                    if (circle25Display == DISPLAY_NONE) circle25Display = DISPLAY_BLOCK;
                    circle25Count += 1;                
                }    
                if (r.Current_Impact_Number__c == 3 && r.Current_Likelihood_Number__c == 1) {
                    if (circle31Display == DISPLAY_NONE) circle31Display = DISPLAY_BLOCK;
                    circle31Count += 1;                
                } 
                if (r.Current_Impact_Number__c == 3 && r.Current_Likelihood_Number__c == 2) {
                    if (circle32Display == DISPLAY_NONE) circle32Display = DISPLAY_BLOCK;
                    circle32Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 3 && r.Current_Likelihood_Number__c == 3) {
                    if (circle33Display == DISPLAY_NONE) circle33Display = DISPLAY_BLOCK;
                    circle33Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 3 && r.Current_Likelihood_Number__c == 4) {
                    if (circle34Display == DISPLAY_NONE) circle34Display = DISPLAY_BLOCK;
                    circle34Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 3 && r.Current_Likelihood_Number__c == 5) {
                    if (circle35Display == DISPLAY_NONE) circle35Display = DISPLAY_BLOCK;
                    circle35Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 4 && r.Current_Likelihood_Number__c == 1) {
                    if (circle41Display == DISPLAY_NONE) circle41Display = DISPLAY_BLOCK;
                    circle41Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 4 && r.Current_Likelihood_Number__c == 2) {
                    if (circle42Display == DISPLAY_NONE) circle42Display = DISPLAY_BLOCK;
                    circle42Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 4 && r.Current_Likelihood_Number__c == 3) {
                    if (circle43Display == DISPLAY_NONE) circle43Display = DISPLAY_BLOCK;
                    circle43Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 4 && r.Current_Likelihood_Number__c == 4) {
                    if (circle44Display == DISPLAY_NONE) circle44Display = DISPLAY_BLOCK;
                    circle44Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 4 && r.Current_Likelihood_Number__c == 5) {
                    if (circle45Display == DISPLAY_NONE) circle45Display = DISPLAY_BLOCK;
                    circle45Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 5 && r.Current_Likelihood_Number__c == 1) {
                    if (circle51Display == DISPLAY_NONE) circle51Display = DISPLAY_BLOCK;
                    circle51Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 5 && r.Current_Likelihood_Number__c == 2) {
                    if (circle52Display == DISPLAY_NONE) circle52Display = DISPLAY_BLOCK;
                    circle52Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 5 && r.Current_Likelihood_Number__c == 3) {
                    if (circle53Display == DISPLAY_NONE) circle53Display = DISPLAY_BLOCK;
                    circle53Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 5 && r.Current_Likelihood_Number__c == 4) {
                    if (circle54Display == DISPLAY_NONE) circle54Display = DISPLAY_BLOCK;
                    circle54Count += 1;                 
                } 
                if (r.Current_Impact_Number__c == 5 && r.Current_Likelihood_Number__c == 5) {
                    if (circle55Display == DISPLAY_NONE) circle55Display = DISPLAY_BLOCK;
                    circle55Count += 1;                 
                }
                
            }
        }
        
        return riskList;
    }
    
    String oldImpactFilter;
    String oldLikelihoodFilter;
    String oldParentCategoryFilter;
    String oldRiskStatusFilter;
    String oldRiskCategory1Filter;
    
    public PageReference filterRiskList() { 
        cImpact = null;
        cLikelihood = null;         
        riskList = getRiskList();
        oldImpactFilter = ImpactFilter;
        oldLikelihoodFilter = LikelihoodFilter;
        oldParentCategoryFilter = ParentCategoryFilter;
        oldRiskStatusFilter = RiskStatusFilter;
        oldRiskCategory1Filter = RiskCategory1Filter;

        return null;
    }
    
    public PageReference clearfilter() {
        
        cImpact = null;
        cLikelihood = null;        
        
        ImpactFilter = null;
        LikelihoodFilter = null;
        ParentCategoryFilter = null;
        RiskStatusFilter = null;
        RiskCategory1Filter = null;
        
        oldImpactFilter = null;
        oldLikelihoodFilter = null;
        oldParentCategoryFilter = null;
        oldRiskStatusFilter = null;     
        oldRiskCategory1Filter = null;
        
        riskList = getRiskList();
        return null;
    }
    
    public pageReference cancelFilter() {
        cImpact = null;
        cLikelihood = null;        
        
        ImpactFilter = oldImpactFilter;
        LikelihoodFilter = oldLikelihoodFilter;
        ParentCategoryFilter = oldParentCategoryFilter;
        RiskStatusFilter = oldRiskStatusFilter;
        RiskCategory1Filter = oldRiskCategory1Filter;
        
        
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