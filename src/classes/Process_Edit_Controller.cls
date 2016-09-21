public class Process_Edit_Controller {
    public UGI_Process__c process{get;set;}
    public list<ProcessWrapper> processWrapperList{get;set;}
    public integer count;
    public integer deleteIdx{get;set;}
    list<UGI_Subsidiary__c> dataToDelete;
    list<UGI_Subsidiary__c> subsidiaries;
    
    string retURL;
    public boolean isSOX{get;set;}
    
    public Process_Edit_Controller(ApexPages.StandardController std){
        count = 0;
        process = [select id, Name, Name__c, Risk__c, Source__c, Category__c, RecordTypeId from UGI_Process__c where id =: std.getRecord().Id];
        system.debug('#### ID : '+process.Id);
        
        string type;
        if(process.RecordTypeId == '012M00000000m0H'){
            isSOX = true;
            type = 'SOX';
        }else{
            isSOX = false;
            type = 'IA';
        }
        
        //subsidiaries = new list<UGI_Subsidiary__c>();
        subsidiaries = [select id, Name, Process__c, Overall_Complexity__c, Degree_of_Centralization__c, Extent_of_Automation__c, Transaction_Volume__c, 
                        History_of_Deficiencies__c, Degree_of_Process_or_Systems_Change__c, Extent_of_External_Party_Involvement__c, System_Adequacy__c, Overall_Risk_Score__c, 
                        AmeriGas__c, Antargaz_Finagaz__c, Avantigas__c, Flaga__c, Holding_Company__c, UGI_Energy_Services__c, UGI_Utilities__c 
                        from UGI_Subsidiary__c where Process__c =: process.Id and Type__c =: type order by Name];
        system.debug('#### subsidiaries : '+subsidiaries);
        
        processWrapperList = new list<ProcessWrapper>();
        for(UGI_Subsidiary__c s : subsidiaries){
            ProcessWrapper pw = new ProcessWrapper(s,count++);
            processWrapperList.add(pw);
        }
        processWrapperList.add(new ProcessWrapper(count++));
        system.debug('#### processWrapperList : '+processWrapperList);
        dataToDelete = new list<UGI_Subsidiary__c>();
        retURL = apexPages.currentPage().getParameters().get('retURL');
    }
    
    public PageReference save(){
        update process;
        saveSubsidiary();
        PageReference pg = new PageReference('/'+process.Id);
        return pg;
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference(retURL);
        return pg;
    }
    
    public void saveSubsidiary(){
        list<UGI_Subsidiary__c> dataToUpsert = new list<UGI_Subsidiary__c>();
        for(ProcessWrapper pw : processWrapperList){
            if(pw.subsidiary.Name != null && pw.subsidiary.Name != ''){
                if(pw.subsidiary.Process__c == null){
                    pw.subsidiary.Process__c = process.Id;
                }
                if(process.RecordTypeId == '012M00000000m0H'){
                    pw.subsidiary.Type__c = 'SOX';
                }else{
                    pw.subsidiary.Type__c = 'IA';
                }
                dataToUpsert.add(pw.subsidiary);
            }
        }
        system.debug('#### data To Upsert : '+dataToUpsert);
        try{
            if(dataToDelete.size() > 0){
                delete dataToDelete;
            }
            if(dataToUpsert.size() > 0){
                upsert dataToUpsert;
                subsidiaries = [select id, Name, Process__c, Overall_Complexity__c, Degree_of_Centralization__c, Extent_of_Automation__c, Transaction_Volume__c, 
                                History_of_Deficiencies__c, Degree_of_Process_or_Systems_Change__c, Extent_of_External_Party_Involvement__c, System_Adequacy__c, Overall_Risk_Score__c
                                from UGI_Subsidiary__c where Process__c =: process.Id and Type__c = 'SOX'];
                system.debug('#### subsidiaries : '+subsidiaries);
                count = 0;
                processWrapperList = new list<ProcessWrapper>();
                for(UGI_Subsidiary__c s : subsidiaries){
                    ProcessWrapper pw = new ProcessWrapper(s,count++);
                    processWrapperList.add(pw);
                }
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Function cannot be left blank.'));
            }
        }catch(Exception exp){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ERROR: '+exp.getMessage()));
        }
    }
    
    public void addSubsidiary(){
        processWrapperList.add(new ProcessWrapper(count++));
    }
    
    public void removeSubsidiary(){
        system.debug('#### deleteIdx : '+deleteIdx );
        ProcessWrapper delW = processWrapperList.get(deleteIdx);
        if(delW.subsidiary.Process__c != null){
            dataToDelete.add(delW.subsidiary);
        }
        processWrapperList.remove(deleteIdx);
        count = 0;
        for(ProcessWrapper pw : processWrapperList){
            pw.index = count++;
        }
    }
    
    public class ProcessWrapper{
        public boolean selected{get;set;}
        public integer index{get;set;}
        public UGI_Subsidiary__c subsidiary{get;set;}
        public ProcessWrapper(UGI_Subsidiary__c subsidiary, integer index){
            this.subsidiary = subsidiary;
            this.index = index;
            this.selected = false;
        }
        public ProcessWrapper(integer index){
            subsidiary = new UGI_Subsidiary__c();
            this.index = index;
            this.selected = false;
        }
    }
}