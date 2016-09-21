public class OpportunityHeatMapController {
    public PageReference page = ApexPages.CurrentPage();
    public Risk__c risk {get; set;}
    public String cImpact {get; set;}
    public String cLikelihood {get; set;}
    public String riskListTitle {get; set;}

  public String circle00Display {get; set;}
    public String circle11Display {get; set;}
    public String circle12Display {get; set;}
    public String circle13Display {get; set;}
    public String circle14Display {get; set;}
    public String circle15Display {get; set;}
    public String circle16Display {get; set;}
    public String circle17Display {get; set;}
    public String circle18Display {get; set;}
    public String circle19Display {get; set;}
    public String circle110Display {get; set;}

    public String circle21Display {get; set;}
    public String circle22Display {get; set;}
    public String circle23Display {get; set;}
    public String circle24Display {get; set;}
    public String circle25Display {get; set;}
    public String circle26Display {get; set;}
    public String circle27Display {get; set;}
    public String circle28Display {get; set;}
    public String circle29Display {get; set;}
    public String circle210Display {get; set;}

    public String circle31Display {get; set;}
    public String circle32Display {get; set;}
    public String circle33Display {get; set;}
    public String circle34Display {get; set;}
    public String circle35Display {get; set;}
  public String circle36Display {get; set;}  
    public String circle37Display {get; set;}
    public String circle38Display {get; set;}
    public String circle39Display {get; set;}
    public String circle310Display {get; set;}

    public String circle41Display {get; set;}
    public String circle42Display {get; set;}
    public String circle43Display {get; set;}
    public String circle44Display {get; set;}
    public String circle45Display {get; set;}
    public String circle46Display {get; set;}
    public String circle47Display {get; set;}
    public String circle48Display {get; set;}
    public String circle49Display {get; set;}
    public String circle410Display {get; set;}

    public String circle51Display {get; set;}
    public String circle52Display {get; set;}
    public String circle53Display {get; set;}
    public String circle54Display {get; set;}
    public String circle55Display {get; set;}
    public String circle56Display {get; set;}
    public String circle57Display {get; set;}
    public String circle58Display {get; set;}
    public String circle59Display {get; set;}
    public String circle510Display {get; set;}

    public String circle61Display {get; set;}
    public String circle62Display {get; set;}
    public String circle63Display {get; set;}
    public String circle64Display {get; set;}
    public String circle65Display {get; set;}
    public String circle66Display {get; set;}
    public String circle67Display {get; set;}
    public String circle68Display {get; set;}
    public String circle69Display {get; set;}
    public String circle610Display {get; set;}

    public String circle71Display {get; set;}
    public String circle72Display {get; set;}
    public String circle73Display {get; set;}
    public String circle74Display {get; set;}
    public String circle75Display {get; set;}
    public String circle76Display {get; set;}
    public String circle77Display {get; set;}
    public String circle78Display {get; set;}
    public String circle79Display {get; set;}
    public String circle710Display {get; set;}

    public String circle81Display {get; set;}
    public String circle82Display {get; set;}
    public String circle83Display {get; set;}
    public String circle84Display {get; set;}
    public String circle85Display {get; set;}
    public String circle86Display {get; set;}
    public String circle87Display {get; set;}
    public String circle88Display {get; set;}
    public String circle89Display {get; set;}
    public String circle810Display {get; set;}

    public String circle91Display {get; set;}
    public String circle92Display {get; set;}
    public String circle93Display {get; set;}
    public String circle94Display {get; set;}
    public String circle95Display {get; set;}
    public String circle96Display {get; set;}
    public String circle97Display {get; set;}
    public String circle98Display {get; set;}
    public String circle99Display {get; set;}
    public String circle910Display {get; set;}

    public String circle101Display {get; set;}
    public String circle102Display {get; set;}
    public String circle103Display {get; set;}
    public String circle104Display {get; set;}
    public String circle105Display {get; set;}
    public String circle106Display {get; set;}
    public String circle107Display {get; set;}
    public String circle108Display {get; set;}
    public String circle109Display {get; set;}
    public String circle1010Display {get; set;}

  public Integer circle00Count {get; set;}
    public Integer circle11Count {get; set;}
    public Integer circle12Count {get; set;}
    public Integer circle13Count {get; set;}
    public Integer circle14Count {get; set;}
    public Integer circle15Count {get; set;}
    public Integer circle16Count {get; set;}
    public Integer circle17Count {get; set;}
    public Integer circle18Count {get; set;}
    public Integer circle19Count {get; set;}
    public Integer circle110Count {get; set;}

    public Integer circle21Count {get; set;}
    public Integer circle22Count {get; set;}
    public Integer circle23Count {get; set;}
    public Integer circle24Count {get; set;}
    public Integer circle25Count {get; set;}
    public Integer circle26Count {get; set;}
    public Integer circle27Count {get; set;}
    public Integer circle28Count {get; set;}
    public Integer circle29Count {get; set;}
    public Integer circle210Count {get; set;}

    public Integer circle31Count {get; set;}
    public Integer circle32Count {get; set;}
    public Integer circle33Count {get; set;}
    public Integer circle34Count {get; set;}
    public Integer circle35Count {get; set;}
  public Integer circle36Count {get; set;}  
    public Integer circle37Count {get; set;}
    public Integer circle38Count {get; set;}
    public Integer circle39Count {get; set;}
    public Integer circle310Count {get; set;}

    public Integer circle41Count {get; set;}
    public Integer circle42Count {get; set;}
    public Integer circle43Count {get; set;}
    public Integer circle44Count {get; set;}
    public Integer circle45Count {get; set;}
    public Integer circle46Count {get; set;}
    public Integer circle47Count {get; set;}
    public Integer circle48Count {get; set;}
    public Integer circle49Count {get; set;}
    public Integer circle410Count {get; set;}

    public Integer circle51Count {get; set;}
    public Integer circle52Count {get; set;}
    public Integer circle53Count {get; set;}
    public Integer circle54Count {get; set;}
    public Integer circle55Count {get; set;}
    public Integer circle56Count {get; set;}
    public Integer circle57Count {get; set;}
    public Integer circle58Count {get; set;}
    public Integer circle59Count {get; set;}
    public Integer circle510Count {get; set;}

    public Integer circle61Count {get; set;}
    public Integer circle62Count {get; set;}
    public Integer circle63Count {get; set;}
    public Integer circle64Count {get; set;}
    public Integer circle65Count {get; set;}
    public Integer circle66Count {get; set;}
    public Integer circle67Count {get; set;}
    public Integer circle68Count {get; set;}
    public Integer circle69Count {get; set;}
    public Integer circle610Count {get; set;}

    public Integer circle71Count {get; set;}
    public Integer circle72Count {get; set;}
    public Integer circle73Count {get; set;}
    public Integer circle74Count {get; set;}
    public Integer circle75Count {get; set;}
    public Integer circle76Count {get; set;}
    public Integer circle77Count {get; set;}
    public Integer circle78Count {get; set;}
    public Integer circle79Count {get; set;}
    public Integer circle710Count {get; set;}

    public Integer circle81Count {get; set;}
    public Integer circle82Count {get; set;}
    public Integer circle83Count {get; set;}
    public Integer circle84Count {get; set;}
    public Integer circle85Count {get; set;}
    public Integer circle86Count {get; set;}
    public Integer circle87Count {get; set;}
    public Integer circle88Count {get; set;}
    public Integer circle89Count {get; set;}
    public Integer circle810Count {get; set;}

    public Integer circle91Count {get; set;}
    public Integer circle92Count {get; set;}
    public Integer circle93Count {get; set;}
    public Integer circle94Count {get; set;}
    public Integer circle95Count {get; set;}
    public Integer circle96Count {get; set;}
    public Integer circle97Count {get; set;}
    public Integer circle98Count {get; set;}
    public Integer circle99Count {get; set;}
    public Integer circle910Count {get; set;}

    public Integer circle101Count {get; set;}
    public Integer circle102Count {get; set;}
    public Integer circle103Count {get; set;}
    public Integer circle104Count {get; set;}
    public Integer circle105Count {get; set;}
    public Integer circle106Count {get; set;}
    public Integer circle107Count {get; set;}
    public Integer circle108Count {get; set;}
    public Integer circle109Count {get; set;}
    public Integer circle1010Count {get; set;}

    private static String DISPLAY_NONE = 'display: none;';
    private static String DISPLAY_BLOCK = 'display: block;';

    public List<Risk__c> riskList = new List<Risk__c>();
    public String getRiskOwnerDept { get; set; }

    String riskScore = '';
    String targetRiskScore = '';
    String inherentRiskScore = '';
    String currentRiskScore = '';

    public String customColorsSetting {get; set;}

    public OpportunityHeatMapController() {
        resetDisplay();
        risk = new Risk__c();
        risk.Executive_Owner__c = null;
        risk.Risk_Owner__c = null;
        risk.Risk_Status__c = null;
        risk.Risk_Category__c = null;
        customColorsSetting = HeatMapSettings__c.getInstance().OpportunityHeatMapColorStops__c;
        ValueFilter = 'Current';
        resetDisplay();
    }

    public String getRiskScore() {
        return riskScore;
    }


    public void setRiskScore(String riskScore) {
        this.riskScore = riskScore;
        targetRiskScore = '';
        inherentRiskScore = '';
        currentRiskScore = '';
        /*
        if(this.riskScore == 'Target_Risk_Score__c') this.targetRiskScore = 'Target_Risk_Score__c';
        else if(this.riskScore == 'Inherent_Risk_Score__c') this.inherentRiskScore = 'Inherent_Risk_Score__c';
        else if(this.riskScore == 'Current_Risk_Score__c') this.currentRiskScore = 'Current_Risk_Score__c';
        */
    }


    public List<SelectOption> getScoreItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '--None--'));
        options.add(new SelectOption('Inherent_Risk_Score__c', 'Inherent Risk Score'));
        options.add(new SelectOption('Current_Risk_Score__c', 'Current Risk Score'));
        options.add(new SelectOption('Target_Risk_Score__c', 'Target Risk Score'));
        return options;
    }
    
    
    public String ValueFilter {get;set;}
        
      public List<SelectOption> getValueOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Inherent','Inherent'));
        options.add(new SelectOption('Current','Current'));
        options.add(new SelectOption('Target','Target'));
        return options;
    }

    public List<Risk__c> getRiskList () {
        String riskOwner = '';
        String riskExecOwner = '';
        String riskOwnerDept = '';
        String riskStatus = '';
        String riskCategory = '';
        String riskDirection = '';
        String riskVelocity = '';
        String soqlQuery = '';

        riskListTitle = 'Risk Register ';
        if (cImpact != '' && cLikelihood != '') riskListTitle = riskListTitle + ' - Impact: ' + cImpact + ', Likelihood: ' +  cLikelihood;

        if (risk != null) {
            riskExecOwner = risk.Executive_Owner__c;
            riskOwner = risk.Risk_Owner__c;
            if (getRiskOwnerDept != '') riskOwnerDept = getRiskOwnerDept;
            else riskOwnerDept = null;
            riskStatus = risk.Risk_Status__c;
            riskCategory = risk.Risk_Category__c;
            riskDirection = risk.Risk_Direction__c;
            riskVelocity = risk.Risk_Clockspeed__c;
        }

        if (cImpact != '' || cLikelihood != '' || (cImpact == '0' && cLikelihood == '0')) {
            //if (cImpact == '0' && cLikelihood == '0') {
            //    cImpact = null;
            //    cLikelihood = null;
            //}

            al.NestableCondition criteria = new al.AndCondition();
            if (riskVelocity != null) criteria.add(new al.FieldCondition('Risk_Clockspeed__c').equals(riskVelocity));
            if (riskDirection != null) criteria.add(new al.FieldCondition('Risk_Direction__c').equals(riskDirection));
            //if (targetRiskScore != '') criteria.add(new al.FieldCondition('Target_Risk_Score__c', al.Operator.GREATER_THAN_OR_EQUAL_TO, 1));
            //if (inherentRiskScore != '') criteria.add(new al.FieldCondition('Inherent_Risk_Score__c', al.Operator.GREATER_THAN_OR_EQUAL_TO, 1));
            //if (currentRiskScore != '') criteria.add(new al.FieldCondition('Current_Risk_Score__c', al.Operator.GREATER_THAN_OR_EQUAL_TO, 1));
            if (riskStatus != null) criteria.add(new al.FieldCondition('Risk_Status__c').equals(riskStatus));
            if (riskExecOwner != null) criteria.add(new al.FieldCondition('Executive_Owner__c').equals(riskExecOwner));
            if (riskOwner != null) criteria.add(new al.FieldCondition('Risk_Owner__c').equals(riskOwner));
            if (riskOwnerDept != null) criteria.add(new al.FieldCondition('Risk_Owner__r.Department').equals(riskOwnerDept));
            if (riskCategory != null) criteria.add(new al.FieldCondition('Risk_Category__c').equals(riskCategory));
            //if (cImpact != '' || cImpact != null) criteria.add(new al.FieldCondition('Expected_Current_Impact_Text__c').equals(cImpact));
            //if (cLikelihood != '' || cLikelihood != null) criteria.add(new al.FieldCondition('Expected_Current_Likelihood_Text__c').equals(cLikelihood));

            if (ValueFilter == 'Current'){
                if (cImpact == '0' && cLikelihood == '0') {
                    al.NestableCondition impact = new al.OrCondition().add(new al.FieldCondition('Expected_Current_Impact_Text__c').equals(cImpact)).add(new al.FieldCondition('Expected_Current_Impact_Text__c').equals(''));
                    al.NestableCondition likelihood = new al.OrCondition().add(new al.FieldCondition('Expected_Current_Likelihood_Text__c').equals(cLikelihood)).add(new al.FieldCondition('Expected_Current_Likelihood_Text__c').equals(''));
                    if(cImpact != null) criteria.add(impact);
                    if(cLikelihood != null) criteria.add(likelihood);
                } else {
                    al.FieldCondition impact = new al.FieldCondition('Expected_Current_Impact_Text__c').equals(cImpact);
                    al.FieldCondition likelihood = new al.FieldCondition('Expected_Current_Likelihood_Text__c').equals(cLikelihood);
                    if(cImpact != null) criteria.add(impact);
                    if(cLikelihood != null) criteria.add(likelihood);
                }
            }else if (ValueFilter == 'Target'){
                if (cImpact == '0' && cLikelihood == '0') {
                    al.NestableCondition impact = new al.OrCondition().add(new al.FieldCondition('Expected_Target_Impact_Text__c').equals(cImpact)).add(new al.FieldCondition('Expected_Target_Impact_Text__c').equals(''));
                    al.NestableCondition likelihood = new al.OrCondition().add(new al.FieldCondition('Expected_Target_Likelihood_Text__c').equals(cLikelihood)).add(new al.FieldCondition('Expected_Target_Likelihood_Text__c').equals(''));
                    if(cImpact != null) criteria.add(impact);
                    if(cLikelihood != null) criteria.add(likelihood);
                } else {
                    al.FieldCondition impact = new al.FieldCondition('Expected_Target_Impact_Text__c').equals(cImpact);
                    al.FieldCondition likelihood = new al.FieldCondition('Expected_Target_Likelihood_Text__c').equals(cLikelihood);
                    if(cImpact != null) criteria.add(impact);
                    if(cLikelihood != null) criteria.add(likelihood);
                }
            }else if (ValueFilter == 'Inherent'){
                if (cImpact == '0' && cLikelihood == '0') {
                    al.NestableCondition impact = new al.OrCondition().add(new al.FieldCondition('Expected_Inherent_Impact_Text__c').equals(cImpact)).add(new al.FieldCondition('Expected_Inherent_Impact_Text__c').equals(''));
                    al.NestableCondition likelihood = new al.OrCondition().add(new al.FieldCondition('Expected_Inherent_Likelihood_Text__c').equals(cLikelihood)).add(new al.FieldCondition('Expected_Inherent_Likelihood_Text__c').equals(''));
                    if(cImpact != null) criteria.add(impact);
                    if(cLikelihood != null) criteria.add(likelihood);
                } else {
                    al.FieldCondition impact = new al.FieldCondition('Expected_Inherent_Impact_Text__c').equals(cImpact);
                    al.FieldCondition likelihood = new al.FieldCondition('Expected_Inherent_Likelihood_Text__c').equals(cLikelihood);
                    if(cImpact != null) criteria.add(impact);
                    if(cLikelihood != null) criteria.add(likelihood);
                }
            }


            if(ValueFilter == 'Current') {
                soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object> {'Id', 'Name', 'Risk_Clockspeed__c', 'Risk_Direction__c', 'Target_Risk_Score__c', 'Inherent_Risk_Score__c', 'Current_Risk_Score__c', 'Risk_Category__c', 'Risk_Owner__r.Name', 'Executive_Owner__r.Name', 'Risk_Status__c', 'Risk_Owner__r.Department', 'Risk_Description__c', 'Expected_Current_Impact_Text__c', 'Expected_Current_Likelihood_Text__c', 'Expected_Target_Impact_Text__c', 'Expected_Target_Likelihood_Text__c', 'Expected_Inherent_Impact_Text__c', 'Expected_Inherent_Likelihood_Text__c', 'Expected_Residual_Impact_Number__c', 'Expected_Residual_Likelihood_Number__c', 'Expected_Target_Impact_Number__c', 'Expected_Target_Likelihood_Number__c', 'Expected_Inherent_Impact_Number__c', 'Expected_Inherent_Likelihood_Number__c', 'Risk__c.X10_K_Risk__c' })
                .fromx('Risk__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                    .add(
                        new al.OrCondition()
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Normal'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Triangular'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Expected'))
                    )
                )
                .orderByx(new al.OrderBy('Current_Risk_Score__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Residual_Impact_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Residual_Likelihood_Number__c').descending().nullsLast())
                .toSoql();
                riskList = Database.query(soqlQuery);
                System.debug('QUERY: ' + soqlQuery);
            }
    
            else if(ValueFilter == 'Target') {
                soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object> {'Id', 'Name', 'Risk_Clockspeed__c', 'Risk_Direction__c', 'Target_Risk_Score__c', 'Inherent_Risk_Score__c', 'Current_Risk_Score__c', 'Risk_Category__c', 'Risk_Owner__r.Name', 'Executive_Owner__r.Name', 'Risk_Status__c', 'Risk_Owner__r.Department', 'Risk_Description__c', 'Expected_Current_Impact_Text__c', 'Expected_Current_Likelihood_Text__c', 'Expected_Target_Impact_Text__c', 'Expected_Target_Likelihood_Text__c', 'Expected_Inherent_Impact_Text__c', 'Expected_Inherent_Likelihood_Text__c', 'Expected_Residual_Impact_Number__c', 'Expected_Residual_Likelihood_Number__c', 'Expected_Target_Impact_Number__c', 'Expected_Target_Likelihood_Number__c', 'Expected_Inherent_Impact_Number__c', 'Expected_Inherent_Likelihood_Number__c', 'Risk__c.X10_K_Risk__c' })
                .fromx('Risk__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                    .add(
                        new al.OrCondition()
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Normal'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Triangular'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Expected'))
                    )
                )
                .orderByx(new al.OrderBy('Target_Risk_Score__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Target_Impact_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Target_Likelihood_Number__c').descending().nullsLast())
                .toSoql();
                riskList = Database.query(soqlQuery);
                System.debug('QUERY: ' + soqlQuery);            
            }
            
            else if(ValueFilter == 'Inherent') {
                soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object> {'Id', 'Name', 'Risk_Clockspeed__c', 'Risk_Direction__c', 'Target_Risk_Score__c', 'Inherent_Risk_Score__c', 'Current_Risk_Score__c', 'Risk_Category__c', 'Risk_Owner__r.Name', 'Executive_Owner__r.Name', 'Risk_Status__c', 'Risk_Owner__r.Department', 'Risk_Description__c', 'Expected_Current_Impact_Text__c', 'Expected_Current_Likelihood_Text__c', 'Expected_Target_Impact_Text__c', 'Expected_Target_Likelihood_Text__c', 'Expected_Inherent_Impact_Text__c', 'Expected_Inherent_Likelihood_Text__c', 'Expected_Residual_Impact_Number__c', 'Expected_Residual_Likelihood_Number__c', 'Expected_Target_Impact_Number__c', 'Expected_Target_Likelihood_Number__c', 'Expected_Inherent_Impact_Number__c', 'Expected_Inherent_Likelihood_Number__c', 'Risk__c.X10_K_Risk__c' })
                .fromx('Risk__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                    .add(
                        new al.OrCondition()
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Normal'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Triangular'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Expected'))
                    )
                )
                .orderByx(new al.OrderBy('Inherent_Risk_Score__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Inherent_Impact_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Inherent_Likelihood_Number__c').descending().nullsLast())
                .toSoql();
                riskList = Database.query(soqlQuery);
                System.debug('QUERY: ' + soqlQuery);
            }

            
        } else {
            resetDisplay();

            al.NestableCondition criteria = new al.AndCondition();
            if (riskVelocity != null) criteria.add(new al.FieldCondition('Risk_Clockspeed__c').equals(riskVelocity));
            if (riskDirection != null) criteria.add(new al.FieldCondition('Risk_Direction__c').equals(riskDirection));
            //if (targetRiskScore != '') criteria.add(new al.FieldCondition('Target_Risk_Score__c', al.Operator.GREATER_THAN_OR_EQUAL_TO, 1));
            //if (inherentRiskScore != '') criteria.add(new al.FieldCondition('Inherent_Risk_Score__c', al.Operator.GREATER_THAN_OR_EQUAL_TO, 1));
            //if (currentRiskScore != '') criteria.add(new al.FieldCondition('Current_Risk_Score__c', al.Operator.GREATER_THAN_OR_EQUAL_TO, 1));
            if (riskStatus != null) criteria.add(new al.FieldCondition('Risk_Status__c').equals(riskStatus));
            if (riskExecOwner != null) criteria.add(new al.FieldCondition('Executive_Owner__c').equals(riskExecOwner));
            if (riskOwner != null) criteria.add(new al.FieldCondition('Risk_Owner__c').equals(riskOwner));
            if (riskOwnerDept != null) criteria.add(new al.FieldCondition('Risk_Owner__r.Department').equals(riskOwnerDept));
            if (riskCategory != null) criteria.add(new al.FieldCondition('Risk_Category__c').equals(riskCategory));

            if(ValueFilter == 'Current') {
                soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object> {'Id', 'Name', 'Risk_Clockspeed__c', 'Risk_Direction__c', 'Target_Risk_Score__c', 'Inherent_Risk_Score__c', 'Current_Risk_Score__c', 'Risk_Category__c', 'Risk_Owner__r.Name', 'Executive_Owner__r.Name', 'Risk_Status__c', 'Risk_Owner__r.Department', 'Risk_Description__c', 'Expected_Current_Impact_Text__c', 'Expected_Current_Likelihood_Text__c', 'Expected_Target_Impact_Text__c', 'Expected_Target_Likelihood_Text__c', 'Expected_Inherent_Impact_Text__c', 'Expected_Inherent_Likelihood_Text__c', 'Expected_Residual_Impact_Number__c', 'Expected_Residual_Likelihood_Number__c', 'Expected_Target_Impact_Number__c', 'Expected_Target_Likelihood_Number__c', 'Expected_Inherent_Impact_Number__c', 'Expected_Inherent_Likelihood_Number__c', 'Risk__c.X10_K_Risk__c' })
                .fromx('Risk__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                    .add(
                        new al.OrCondition()
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Normal'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Triangular'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Expected'))
                    )
                )
                .orderByx(new al.OrderBy('Current_Risk_Score__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Residual_Impact_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Residual_Likelihood_Number__c').descending().nullsLast())
                .toSoql();
                riskList = Database.query(soqlQuery);
                System.debug('QUERY: ' + soqlQuery);
            }
    
            else if(ValueFilter == 'Target') {
                soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object> {'Id', 'Name', 'Risk_Clockspeed__c', 'Risk_Direction__c', 'Target_Risk_Score__c', 'Inherent_Risk_Score__c', 'Current_Risk_Score__c', 'Risk_Category__c', 'Risk_Owner__r.Name', 'Executive_Owner__r.Name', 'Risk_Status__c', 'Risk_Owner__r.Department', 'Risk_Description__c', 'Expected_Current_Impact_Text__c', 'Expected_Current_Likelihood_Text__c', 'Expected_Target_Impact_Text__c', 'Expected_Target_Likelihood_Text__c', 'Expected_Inherent_Impact_Text__c', 'Expected_Inherent_Likelihood_Text__c', 'Expected_Residual_Impact_Number__c', 'Expected_Residual_Likelihood_Number__c', 'Expected_Target_Impact_Number__c', 'Expected_Target_Likelihood_Number__c', 'Expected_Inherent_Impact_Number__c', 'Expected_Inherent_Likelihood_Number__c', 'Risk__c.X10_K_Risk__c' })
                .fromx('Risk__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                    .add(
                        new al.OrCondition()
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Normal'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Triangular'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Expected'))
                    )
                )
                .orderByx(new al.OrderBy('Target_Risk_Score__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Target_Impact_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Target_Likelihood_Number__c').descending().nullsLast())
                .toSoql();
                riskList = Database.query(soqlQuery);
                System.debug('QUERY: ' + soqlQuery);            
            }
            
            else if(ValueFilter == 'Inherent') {
                soqlQuery = new al.SoqlBuilder()
                .selectx(new Set<Object> {'Id', 'Name', 'Risk_Clockspeed__c', 'Risk_Direction__c', 'Target_Risk_Score__c', 'Inherent_Risk_Score__c', 'Current_Risk_Score__c', 'Risk_Category__c', 'Risk_Owner__r.Name', 'Executive_Owner__r.Name', 'Risk_Status__c', 'Risk_Owner__r.Department', 'Risk_Description__c', 'Expected_Current_Impact_Text__c', 'Expected_Current_Likelihood_Text__c', 'Expected_Target_Impact_Text__c', 'Expected_Target_Likelihood_Text__c', 'Expected_Inherent_Impact_Text__c', 'Expected_Inherent_Likelihood_Text__c', 'Expected_Residual_Impact_Number__c', 'Expected_Residual_Likelihood_Number__c', 'Expected_Target_Impact_Number__c', 'Expected_Target_Likelihood_Number__c', 'Expected_Inherent_Impact_Number__c', 'Expected_Inherent_Likelihood_Number__c', 'Risk__c.X10_K_Risk__c' })
                .fromx('Risk__c')
                .wherex(
                    new al.AndCondition()
                    .add(criteria)
                    .add(
                        new al.OrCondition()
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Normal'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Triangular'))
                            .add(new al.FieldCondition('RecordType.Name').equals('Opportunity - Expected'))
                    )
                )
                .orderByx(new al.OrderBy('Inherent_Risk_Score__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Inherent_Impact_Number__c').descending().nullsLast())
                .orderByx(new al.OrderBy('Expected_Inherent_Likelihood_Number__c').descending().nullsLast())
                .toSoql();
                riskList = Database.query(soqlQuery);
                System.debug('QUERY: ' + soqlQuery);
            }

            for (Risk__c r : riskList) {
                if ((r.get('Expected_' + ValueFilter + '_Impact_Text__c') == null || r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '0') && (r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == null || r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '0')) {
                    if (circle00Display == DISPLAY_NONE) circle00Display = DISPLAY_BLOCK;
                    circle00Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle11Display == DISPLAY_NONE) circle11Display = DISPLAY_BLOCK;
                    circle11Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle12Display == DISPLAY_NONE) circle12Display = DISPLAY_BLOCK;
                    circle12Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle13Display == DISPLAY_NONE) circle13Display = DISPLAY_BLOCK;
                    circle13Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle14Display == DISPLAY_NONE) circle14Display = DISPLAY_BLOCK;
                    circle14Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle15Display == DISPLAY_NONE) circle15Display = DISPLAY_BLOCK;
                    circle15Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle16Display == DISPLAY_NONE) circle16Display = DISPLAY_BLOCK;
                    circle16Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle17Display == DISPLAY_NONE) circle17Display = DISPLAY_BLOCK;
                    circle17Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle18Display == DISPLAY_NONE) circle18Display = DISPLAY_BLOCK;
                    circle18Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle19Display == DISPLAY_NONE) circle19Display = DISPLAY_BLOCK;
                    circle19Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '1' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle110Display == DISPLAY_NONE) circle110Display = DISPLAY_BLOCK;
                    circle110Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle21Display == DISPLAY_NONE) circle21Display = DISPLAY_BLOCK;
                    circle21Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle22Display == DISPLAY_NONE) circle22Display = DISPLAY_BLOCK;
                    circle22Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle23Display == DISPLAY_NONE) circle23Display = DISPLAY_BLOCK;
                    circle23Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle24Display == DISPLAY_NONE) circle24Display = DISPLAY_BLOCK;
                    circle24Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle25Display == DISPLAY_NONE) circle25Display = DISPLAY_BLOCK;
                    circle25Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle26Display == DISPLAY_NONE) circle26Display = DISPLAY_BLOCK;
                    circle26Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle27Display == DISPLAY_NONE) circle27Display = DISPLAY_BLOCK;
                    circle27Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle28Display == DISPLAY_NONE) circle28Display = DISPLAY_BLOCK;
                    circle28Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle29Display == DISPLAY_NONE) circle29Display = DISPLAY_BLOCK;
                    circle29Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '2' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle210Display == DISPLAY_NONE) circle210Display = DISPLAY_BLOCK;
                    circle210Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle31Display == DISPLAY_NONE) circle31Display = DISPLAY_BLOCK;
                    circle31Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle32Display == DISPLAY_NONE) circle32Display = DISPLAY_BLOCK;
                    circle32Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle33Display == DISPLAY_NONE) circle33Display = DISPLAY_BLOCK;
                    circle33Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle34Display == DISPLAY_NONE) circle34Display = DISPLAY_BLOCK;
                    circle34Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle35Display == DISPLAY_NONE) circle35Display = DISPLAY_BLOCK;
                    circle35Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle36Display == DISPLAY_NONE) circle36Display = DISPLAY_BLOCK;
                    circle36Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle37Display == DISPLAY_NONE) circle37Display = DISPLAY_BLOCK;
                    circle37Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle38Display == DISPLAY_NONE) circle38Display = DISPLAY_BLOCK;
                    circle38Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle39Display == DISPLAY_NONE) circle39Display = DISPLAY_BLOCK;
                    circle39Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '3' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle310Display == DISPLAY_NONE) circle310Display = DISPLAY_BLOCK;
                    circle310Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle41Display == DISPLAY_NONE) circle41Display = DISPLAY_BLOCK;
                    circle41Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle42Display == DISPLAY_NONE) circle42Display = DISPLAY_BLOCK;
                    circle42Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle43Display == DISPLAY_NONE) circle43Display = DISPLAY_BLOCK;
                    circle43Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle44Display == DISPLAY_NONE) circle44Display = DISPLAY_BLOCK;
                    circle44Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle45Display == DISPLAY_NONE) circle45Display = DISPLAY_BLOCK;
                    circle45Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle46Display == DISPLAY_NONE) circle46Display = DISPLAY_BLOCK;
                    circle46Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle47Display == DISPLAY_NONE) circle47Display = DISPLAY_BLOCK;
                    circle47Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle48Display == DISPLAY_NONE) circle48Display = DISPLAY_BLOCK;
                    circle48Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle49Display == DISPLAY_NONE) circle49Display = DISPLAY_BLOCK;
                    circle49Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '4' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle410Display == DISPLAY_NONE) circle410Display = DISPLAY_BLOCK;
                    circle410Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle51Display == DISPLAY_NONE) circle51Display = DISPLAY_BLOCK;
                    circle51Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle52Display == DISPLAY_NONE) circle52Display = DISPLAY_BLOCK;
                    circle52Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle53Display == DISPLAY_NONE) circle53Display = DISPLAY_BLOCK;
                    circle53Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle54Display == DISPLAY_NONE) circle54Display = DISPLAY_BLOCK;
                    circle54Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle55Display == DISPLAY_NONE) circle55Display = DISPLAY_BLOCK;
                    circle55Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle56Display == DISPLAY_NONE) circle56Display = DISPLAY_BLOCK;
                    circle56Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle57Display == DISPLAY_NONE) circle57Display = DISPLAY_BLOCK;
                    circle57Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle58Display == DISPLAY_NONE) circle58Display = DISPLAY_BLOCK;
                    circle58Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle59Display == DISPLAY_NONE) circle59Display = DISPLAY_BLOCK;
                    circle59Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '5' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle510Display == DISPLAY_NONE) circle510Display = DISPLAY_BLOCK;
                    circle510Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle61Display == DISPLAY_NONE) circle61Display = DISPLAY_BLOCK;
                    circle61Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle62Display == DISPLAY_NONE) circle62Display = DISPLAY_BLOCK;
                    circle62Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle63Display == DISPLAY_NONE) circle63Display = DISPLAY_BLOCK;
                    circle63Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle64Display == DISPLAY_NONE) circle64Display = DISPLAY_BLOCK;
                    circle64Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle65Display == DISPLAY_NONE) circle65Display = DISPLAY_BLOCK;
                    circle65Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle66Display == DISPLAY_NONE) circle66Display = DISPLAY_BLOCK;
                    circle66Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle67Display == DISPLAY_NONE) circle67Display = DISPLAY_BLOCK;
                    circle67Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle68Display == DISPLAY_NONE) circle68Display = DISPLAY_BLOCK;
                    circle68Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle69Display == DISPLAY_NONE) circle69Display = DISPLAY_BLOCK;
                    circle69Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '6' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle610Display == DISPLAY_NONE) circle610Display = DISPLAY_BLOCK;
                    circle610Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle71Display == DISPLAY_NONE) circle71Display = DISPLAY_BLOCK;
                    circle71Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle72Display == DISPLAY_NONE) circle72Display = DISPLAY_BLOCK;
                    circle72Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle73Display == DISPLAY_NONE) circle73Display = DISPLAY_BLOCK;
                    circle73Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle74Display == DISPLAY_NONE) circle74Display = DISPLAY_BLOCK;
                    circle74Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle75Display == DISPLAY_NONE) circle75Display = DISPLAY_BLOCK;
                    circle75Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle76Display == DISPLAY_NONE) circle76Display = DISPLAY_BLOCK;
                    circle76Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle77Display == DISPLAY_NONE) circle77Display = DISPLAY_BLOCK;
                    circle77Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle78Display == DISPLAY_NONE) circle78Display = DISPLAY_BLOCK;
                    circle78Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle79Display == DISPLAY_NONE) circle79Display = DISPLAY_BLOCK;
                    circle79Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '7' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle710Display == DISPLAY_NONE) circle710Display = DISPLAY_BLOCK;
                    circle710Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle81Display == DISPLAY_NONE) circle81Display = DISPLAY_BLOCK;
                    circle81Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle82Display == DISPLAY_NONE) circle82Display = DISPLAY_BLOCK;
                    circle82Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle83Display == DISPLAY_NONE) circle83Display = DISPLAY_BLOCK;
                    circle83Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle84Display == DISPLAY_NONE) circle84Display = DISPLAY_BLOCK;
                    circle84Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle85Display == DISPLAY_NONE) circle85Display = DISPLAY_BLOCK;
                    circle85Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle86Display == DISPLAY_NONE) circle86Display = DISPLAY_BLOCK;
                    circle86Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle87Display == DISPLAY_NONE) circle87Display = DISPLAY_BLOCK;
                    circle87Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle88Display == DISPLAY_NONE) circle88Display = DISPLAY_BLOCK;
                    circle88Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle89Display == DISPLAY_NONE) circle89Display = DISPLAY_BLOCK;
                    circle89Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '8' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle810Display == DISPLAY_NONE) circle810Display = DISPLAY_BLOCK;
                    circle810Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle91Display == DISPLAY_NONE) circle91Display = DISPLAY_BLOCK;
                    circle91Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle92Display == DISPLAY_NONE) circle92Display = DISPLAY_BLOCK;
                    circle92Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle93Display == DISPLAY_NONE) circle93Display = DISPLAY_BLOCK;
                    circle93Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle94Display == DISPLAY_NONE) circle94Display = DISPLAY_BLOCK;
                    circle94Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle95Display == DISPLAY_NONE) circle95Display = DISPLAY_BLOCK;
                    circle95Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle96Display == DISPLAY_NONE) circle96Display = DISPLAY_BLOCK;
                    circle96Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle97Display == DISPLAY_NONE) circle97Display = DISPLAY_BLOCK;
                    circle97Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle98Display == DISPLAY_NONE) circle98Display = DISPLAY_BLOCK;
                    circle98Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle99Display == DISPLAY_NONE) circle99Display = DISPLAY_BLOCK;
                    circle99Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '9' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle910Display == DISPLAY_NONE) circle910Display = DISPLAY_BLOCK;
                    circle910Count += 1;
                }


                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '1') {
                    if (circle101Display == DISPLAY_NONE) circle101Display = DISPLAY_BLOCK;
                    circle101Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '2') {
                    if (circle102Display == DISPLAY_NONE) circle102Display = DISPLAY_BLOCK;
                    circle102Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '3') {
                    if (circle103Display == DISPLAY_NONE) circle103Display = DISPLAY_BLOCK;
                    circle103Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '4') {
                    if (circle104Display == DISPLAY_NONE) circle104Display = DISPLAY_BLOCK;
                    circle104Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '5') {
                    if (circle105Display == DISPLAY_NONE) circle105Display = DISPLAY_BLOCK;
                    circle105Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '6') {
                    if (circle106Display == DISPLAY_NONE) circle106Display = DISPLAY_BLOCK;
                    circle106Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '7') {
                    if (circle107Display == DISPLAY_NONE) circle107Display = DISPLAY_BLOCK;
                    circle107Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '8') {
                    if (circle108Display == DISPLAY_NONE) circle108Display = DISPLAY_BLOCK;
                    circle108Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '9') {
                    if (circle109Display == DISPLAY_NONE) circle109Display = DISPLAY_BLOCK;
                    circle109Count += 1;
                }
                if (r.get('Expected_' + ValueFilter + '_Impact_Text__c') == '10' && r.get('Expected_' + ValueFilter + '_Likelihood_Text__c') == '10') {
                    if (circle1010Display == DISPLAY_NONE) circle1010Display = DISPLAY_BLOCK;
                    circle1010Count += 1;
                }
            }
        }

        return riskList;
    }

    public PageReference refreshRiskList() {
        cImpact = '';
        cLikelihood = '';
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
        circle16Display = DISPLAY_NONE;
        circle17Display = DISPLAY_NONE;
        circle18Display = DISPLAY_NONE;
        circle19Display = DISPLAY_NONE;
        circle110Display = DISPLAY_NONE;

        circle21Display = DISPLAY_NONE;
        circle22Display = DISPLAY_NONE;
        circle23Display = DISPLAY_NONE;
        circle24Display = DISPLAY_NONE;
        circle25Display = DISPLAY_NONE;
        circle26Display = DISPLAY_NONE;
        circle27Display = DISPLAY_NONE;
        circle28Display = DISPLAY_NONE;
        circle29Display = DISPLAY_NONE;
        circle210Display = DISPLAY_NONE;

        circle31Display = DISPLAY_NONE;
        circle32Display = DISPLAY_NONE;
        circle33Display = DISPLAY_NONE;
        circle34Display = DISPLAY_NONE;
        circle35Display = DISPLAY_NONE;
    circle36Display = DISPLAY_NONE;  
        circle37Display = DISPLAY_NONE;
        circle38Display = DISPLAY_NONE;
        circle39Display = DISPLAY_NONE;
        circle310Display = DISPLAY_NONE;

        circle41Display = DISPLAY_NONE;
        circle42Display = DISPLAY_NONE;
        circle43Display = DISPLAY_NONE;
        circle44Display = DISPLAY_NONE;
        circle45Display = DISPLAY_NONE;
        circle46Display = DISPLAY_NONE;
        circle47Display = DISPLAY_NONE;
        circle48Display = DISPLAY_NONE;
        circle49Display = DISPLAY_NONE;
        circle410Display = DISPLAY_NONE;

        circle51Display = DISPLAY_NONE;
        circle52Display = DISPLAY_NONE;
        circle53Display = DISPLAY_NONE;
        circle54Display = DISPLAY_NONE;
        circle55Display = DISPLAY_NONE;
        circle56Display = DISPLAY_NONE;
        circle57Display = DISPLAY_NONE;
        circle58Display = DISPLAY_NONE;
        circle59Display = DISPLAY_NONE;
        circle510Display = DISPLAY_NONE;

        circle61Display = DISPLAY_NONE;
        circle62Display = DISPLAY_NONE;
        circle63Display = DISPLAY_NONE;
        circle64Display = DISPLAY_NONE;
        circle65Display = DISPLAY_NONE;
        circle66Display = DISPLAY_NONE;
        circle67Display = DISPLAY_NONE;
        circle68Display = DISPLAY_NONE;
        circle69Display = DISPLAY_NONE;
        circle610Display = DISPLAY_NONE;

        circle71Display = DISPLAY_NONE;
        circle72Display = DISPLAY_NONE;
        circle73Display = DISPLAY_NONE;
        circle74Display = DISPLAY_NONE;
        circle75Display = DISPLAY_NONE;
        circle76Display = DISPLAY_NONE;
        circle77Display = DISPLAY_NONE;
        circle78Display = DISPLAY_NONE;
        circle79Display = DISPLAY_NONE;
        circle710Display = DISPLAY_NONE;

        circle81Display = DISPLAY_NONE;
        circle82Display = DISPLAY_NONE;
        circle83Display = DISPLAY_NONE;
        circle84Display = DISPLAY_NONE;
        circle85Display = DISPLAY_NONE;
        circle86Display = DISPLAY_NONE;
        circle87Display = DISPLAY_NONE;
        circle88Display = DISPLAY_NONE;
        circle89Display = DISPLAY_NONE;
        circle810Display = DISPLAY_NONE;

        circle91Display = DISPLAY_NONE;
        circle92Display = DISPLAY_NONE;
        circle93Display = DISPLAY_NONE;
        circle94Display = DISPLAY_NONE;
        circle95Display = DISPLAY_NONE;
        circle96Display = DISPLAY_NONE;
        circle97Display = DISPLAY_NONE;
        circle98Display = DISPLAY_NONE;
        circle99Display = DISPLAY_NONE;
        circle910Display = DISPLAY_NONE;

        circle101Display = DISPLAY_NONE;
        circle102Display = DISPLAY_NONE;
        circle103Display = DISPLAY_NONE;
        circle104Display = DISPLAY_NONE;
        circle105Display = DISPLAY_NONE;
        circle106Display = DISPLAY_NONE;
        circle107Display = DISPLAY_NONE;
        circle108Display = DISPLAY_NONE;
        circle109Display = DISPLAY_NONE;
        circle1010Display = DISPLAY_NONE;

        circle00Count = 0;
        circle11Count = 0;
        circle12Count = 0;
        circle13Count = 0;
        circle14Count = 0;
        circle15Count = 0;
        circle16Count = 0;
        circle17Count = 0;
        circle18Count = 0;
        circle19Count = 0;
        circle110Count = 0;

        circle21Count = 0;
        circle22Count = 0;
        circle23Count = 0;
        circle24Count = 0;
        circle25Count = 0;
        circle26Count = 0;
        circle27Count = 0;
        circle28Count = 0;
        circle29Count = 0;
        circle210Count = 0;

        circle31Count = 0;
        circle32Count = 0;
        circle33Count = 0;
        circle34Count = 0;
        circle35Count = 0;
    circle36Count = 0;  
        circle37Count = 0;
        circle38Count = 0;
        circle39Count = 0;
        circle310Count = 0;

        circle41Count = 0;
        circle42Count = 0;
        circle43Count = 0;
        circle44Count = 0;
        circle45Count = 0;
        circle46Count = 0;
        circle47Count = 0;
        circle48Count = 0;
        circle49Count = 0;
        circle410Count = 0;

        circle51Count = 0;
        circle52Count = 0;
        circle53Count = 0;
        circle54Count = 0;
        circle55Count = 0;
        circle56Count = 0;
        circle57Count = 0;
        circle58Count = 0;
        circle59Count = 0;
        circle510Count = 0;

        circle61Count = 0;
        circle62Count = 0;
        circle63Count = 0;
        circle64Count = 0;
        circle65Count = 0;
        circle66Count = 0;
        circle67Count = 0;
        circle68Count = 0;
        circle69Count = 0;
        circle610Count = 0;

        circle71Count = 0;
        circle72Count = 0;
        circle73Count = 0;
        circle74Count = 0;
        circle75Count = 0;
        circle76Count = 0;
        circle77Count = 0;
        circle78Count = 0;
        circle79Count = 0;
        circle710Count = 0;

        circle81Count = 0;
        circle82Count = 0;
        circle83Count = 0;
        circle84Count = 0;
        circle85Count = 0;
        circle86Count = 0;
        circle87Count = 0;
        circle88Count = 0;
        circle89Count = 0;
        circle810Count = 0;

        circle91Count = 0;
        circle92Count = 0;
        circle93Count = 0;
        circle94Count = 0;
        circle95Count = 0;
        circle96Count = 0;
        circle97Count = 0;
        circle98Count = 0;
        circle99Count = 0;
        circle910Count = 0;

        circle101Count = 0;
        circle102Count = 0;
        circle103Count = 0;
        circle104Count = 0;
        circle105Count = 0;
        circle106Count = 0;
        circle107Count = 0;
        circle108Count = 0;
        circle109Count = 0;
        circle1010Count = 0;

        cImpact = '';
        cLikelihood = '';
    }

    public String getChooserender() {
        if (ApexPages.currentPage().getParameters().get('p') != null) return 'pdf';
        else return null;
    }

    public PageReference deliverAsPDF() {
        page.getParameters().put('p', 'p');
        return page;
    }

}