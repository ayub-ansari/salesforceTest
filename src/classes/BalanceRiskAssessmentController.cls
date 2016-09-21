public class BalanceRiskAssessmentController {
    /*ayub commented it*/
    public BalanceRiskAssessmentController(ApexPages.StandardController controller) {

    }

    public list<RowWrapper> assets{get;set;}
    public list<RowWrapper> liabilities{get;set;}
    public list<RowWrapper> stockholdersEquity{get;set;}
    public list<RowWrapper> incomeStmt{get;set;}
    public list<RowWrapper> disclosure{get;set;}
    
    public integer assetCount{get;set;}
    public integer liabilitiesCount{get;set;}
    public integer stockholdersEquityCount{get;set;}
    public integer incomeStmtCount{get;set;}
    public integer disclosureCount{get;set;}
    
    public integer assetIdxToDel{get;set;}
    public integer liabilitiesIdxToDel{get;set;}
    public integer stockholdersIdxToDel{get;set;}
    public integer incomeStmtIdxToDel{get;set;}
    public integer disclosureIdxToDel{get;set;}
    
    public list<SOX_Risk__c> riskToDelete;
    
    
    public list<ColumnWrapper> columnAttributes{get;set;}
    public integer colSpan{get;set;}
    public integer selectedIndex{get;set;}
    public list<Column_Attribute__c> colsToDelete;
    
    public BalanceRiskAssessmentController(){
        getAllRisks();
        colSpan = 0;
        columnAttributes = new list<ColumnWrapper>();
        for(Column_Attribute__c col : [select id, Name, Column_Value__c from Column_Attribute__c order by Name]){
            columnAttributes.add(new ColumnWrapper(colSpan++,col));
        }
        colsToDelete = new list<Column_Attribute__c>();
        riskToDelete = new list<SOX_Risk__c>();
    }
    
    private void getAllRisks(){
        assets = new list<RowWrapper>();
        liabilities = new list<RowWrapper>();
        stockholdersEquity = new list<RowWrapper>();
        incomeStmt = new list<RowWrapper>();
        disclosure = new list<RowWrapper>();
        
        assetCount = 0;
        liabilitiesCount = 0;
        stockholdersEquityCount = 0;
        incomeStmtCount = 0;
        disclosureCount = 0;
        
        for(SOX_Risk__c risk : [select id, Name, Balance__c, Type__c, Level_1__c, Level_2__c, Level_3__c, Level_4__c, Level_5__c, Numeric_Total__c, Overall_Risk_Score__c from SOX_Risk__c order by Name]){
            if(risk.Type__c == 'ASSETS')
                assets.add(new RowWrapper(assetCount++,risk));
            if(risk.Type__c == 'LIABILITIES')
                liabilities.add(new RowWrapper(liabilitiesCount++,risk));
            if(risk.Type__c == 'STOCKHOLDERS EQUITY')
                stockholdersEquity.add(new RowWrapper(stockholdersEquityCount++,risk));
            if(risk.Type__c == 'INCOME STATEMENT')
                incomeStmt.add(new RowWrapper(incomeStmtCount++,risk));
            if(risk.Type__c == 'DISCLOSURES')
                disclosure.add(new RowWrapper(disclosureCount++,risk));
        }
    }
    
    public void save(){
        list<SOX_Risk__c> riskToUpdate = new list<SOX_Risk__c>();
        for(RowWrapper rw : assets){
            riskToUpdate.add(rw.risk);
        }
        for(RowWrapper rw : liabilities){
            riskToUpdate.add(rw.risk);
        }
        for(RowWrapper rw : stockholdersEquity){
            riskToUpdate.add(rw.risk);
        }
        for(RowWrapper rw : incomeStmt){
            riskToUpdate.add(rw.risk);
        }
        for(RowWrapper rw : disclosure){
            riskToUpdate.add(rw.risk);
        }
        
        list<Column_Attribute__c> temp = new list<Column_Attribute__c>();
        for(Column_Attribute__c col : colsToDelete){
            for(SOX_Risk__c r : riskToUpdate){
                r.put(col.Name,null);
            }
            if(col.Id != null){
                temp.add(col);
            }
        }
        
        upsert riskToUpdate;
        
        if(temp.size() > 0){
            delete temp;
        }
        
        list<Column_Attribute__c> colAttrToUpsert = new list<Column_Attribute__c>();
        for(ColumnWrapper colW : columnAttributes){
            colAttrToUpsert.add(colW.column);
        }
        upsert colAttrToUpsert;
        
        list<SOX_Risk__c> tempRisks = new list<SOX_Risk__c>();
        for(SOX_Risk__c r : riskToDelete){
            if(r.Id != null){
                tempRisks.add(r);
            }
        }
        delete tempRisks;
        riskToDelete = new list<SOX_Risk__c>();
        colsToDelete = new list<Column_Attribute__c>();
        getAllRisks();
    }
    
    public void addNewCol(){
        if(colSpan < 5){
            columnAttributes.add(new ColumnWrapper(colSpan++,new Column_Attribute__c(Name = 'Level_'+colSpan+'__c',Column_Value__c = 'Risk Level '+colSpan)));
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cannot add more columns'));
        }
    }
    
    public void removeCol(){
        if(colSpan > 1){
            system.debug('#### selectedIndex : '+selectedIndex);
            colsToDelete.add(columnAttributes[selectedIndex].column);
            columnAttributes.remove(selectedIndex);
            colSpan = 0;
            for(ColumnWrapper colW : columnAttributes){
                colW.idx = colSpan++;
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cannot add remove this columns'));
        }
    }
    
    public class ColumnWrapper{
        public integer idx{get;set;}
        public Column_Attribute__c column{get;set;}
        public ColumnWrapper(integer idx, Column_Attribute__c column){
            this.idx = idx;
            this.column = column;
        }
    }
    
    public void addAsset(){
        assets.add(new RowWrapper(assetCount++,new SOX_Risk__c(Name='New Asset', Type__c = 'ASSETS')));
    }
    
    public void removeAsset(){
        system.debug('#### assetIdxToDel : '+assetIdxToDel);
        riskToDelete.add(assets[assetIdxToDel].risk);
        assets.remove(assetIdxToDel);
        assetCount = 0;
        for(RowWrapper rw : assets){
            rw.rowIndex = assetCount++;
        }
    }
    
    public void addLiabilities(){
        liabilities.add(new RowWrapper(liabilitiesCount++,new SOX_Risk__c(Name='New Liability', Type__c = 'LIABILITIES')));
    }
    
    public void removeLiabilities(){
        system.debug('#### liabilitiesIdxToDel : '+liabilitiesIdxToDel);
        riskToDelete.add(liabilities[liabilitiesIdxToDel].risk);
        liabilities.remove(liabilitiesIdxToDel);
        liabilitiesCount = 0;
        for(RowWrapper rw : liabilities){
            rw.rowIndex = liabilitiesCount++;
        }
    }
    
    public void addStockholdersEquity(){
        stockholdersEquity.add(new RowWrapper(stockholdersEquityCount++,new SOX_Risk__c(Name='New Stockholders Equity', Type__c = 'STOCKHOLDERS EQUITY')));
    }
    
    public void removeStockholdersEquity(){
        system.debug('#### stockholdersIdxToDel : '+stockholdersIdxToDel);
        riskToDelete.add(stockholdersEquity[stockholdersIdxToDel].risk);
        stockholdersEquity.remove(stockholdersIdxToDel);
        stockholdersEquityCount = 0;
        for(RowWrapper rw : stockholdersEquity){
            rw.rowIndex = stockholdersEquityCount++;
        }
    }
    
    public void addIncomeStmt(){
        incomeStmt.add(new RowWrapper(incomeStmtCount++,new SOX_Risk__c(Name='New Income Statement', Type__c = 'INCOME STATEMENT')));
    }
    
    public void removeIncomeStmt(){
        system.debug('#### incomeStmtIdxToDel : '+incomeStmtIdxToDel);
        riskToDelete.add(incomeStmt[incomeStmtIdxToDel].risk);
        incomeStmt.remove(incomeStmtIdxToDel);
        incomeStmtCount = 0;
        for(RowWrapper rw : incomeStmt){
            rw.rowIndex = incomeStmtCount++;
        }
    }
    
    public void addDisclosure(){
        disclosure.add(new RowWrapper(disclosureCount++,new SOX_Risk__c(Name='New Disclosure', Type__c = 'DISCLOSURES')));
    }
    
    public void removeDisclosure(){
        system.debug('#### disclosureIdxToDel : '+disclosureIdxToDel);
        riskToDelete.add(disclosure[disclosureIdxToDel].risk);
        disclosure.remove(disclosureIdxToDel);
        disclosureCount = 0;
        for(RowWrapper rw : disclosure){
            rw.rowIndex = disclosureCount++;
        }
    }
    
    public class RowWrapper{
        public integer rowIndex{get;set;}
        public SOX_Risk__c risk{get;set;}
        public RowWrapper(integer rowIndex, SOX_Risk__c risk){
            this.rowIndex = rowIndex;
            this.risk = risk;
        }
    }
}