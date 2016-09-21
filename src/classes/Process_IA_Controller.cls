public class Process_IA_Controller {
    UGI_Process__c process;
    public list<ProcessWrapper> processWrapperList{get;set;}
    public integer count;
    public integer deleteIdx{get;set;}
    list<UGI_Subsidiary__c> dataToDelete;
    public boolean showEdit{get;set;}
    list<UGI_Subsidiary__c> subsidiaries;
    
    public Process_IA_Controller(ApexPages.StandardController std){
        count = 0;
        this.process = (UGI_Process__c)std.getRecord();
        subsidiaries = [select id, Name, Process__c, AmeriGas__c, Antargaz_Finagaz__c, Avantigas__c, Flaga__c, Holding_Company__c, UGI_Energy_Services__c, UGI_Utilities__c 
                        from UGI_Subsidiary__c where Process__c =: process.Id and Type__c = 'IA'];
        system.debug('#### subsidiaries : '+subsidiaries);
        processWrapperList = new list<ProcessWrapper>();
        for(UGI_Subsidiary__c s : subsidiaries){
            ProcessWrapper pw = new ProcessWrapper(s,count++);
            processWrapperList.add(pw);
        }
        system.debug('#### processWrapperList : '+processWrapperList);
        dataToDelete = new list<UGI_Subsidiary__c>();
        showEdit = false;
    }
    
    public void enableEdit(){
        showEdit = true;
        processWrapperList.add(new ProcessWrapper(count++));
    }
    
    public void disableEdit(){
        showEdit = false;
        processWrapperList = new list<ProcessWrapper>();
        count = 0;
        for(UGI_Subsidiary__c s : subsidiaries){
            ProcessWrapper pw = new ProcessWrapper(s,count++);
            processWrapperList.add(pw);
        }
    }
    
    public void saveSubsidiary(){
        list<UGI_Subsidiary__c> dataToUpsert = new list<UGI_Subsidiary__c>();
        for(ProcessWrapper pw : processWrapperList){
            if(pw.subsidiary.Name != null && pw.subsidiary.Name != ''){
                if(pw.subsidiary.Process__c == null){
                    pw.subsidiary.Process__c = process.Id;
                }
                pw.subsidiary.Type__c = 'IA';
                dataToUpsert.add(pw.subsidiary);
            }
        }
        system.debug('#### data To Upsert : '+dataToUpsert);
        try{
            showEdit = false;
            if(dataToDelete.size() > 0){
                delete dataToDelete;
            }
            if(dataToUpsert.size() > 0){
                upsert dataToUpsert;
                list<UGI_Subsidiary__c> subsidiaries = [select id, Name, Process__c, AmeriGas__c, Antargaz_Finagaz__c, Avantigas__c, Flaga__c, Holding_Company__c, UGI_Energy_Services__c, UGI_Utilities__c 
                                                        from UGI_Subsidiary__c where Process__c =: process.Id and Type__c = 'IA'];
                system.debug('#### subsidiaries : '+subsidiaries);
                count = 0;
                processWrapperList = new list<ProcessWrapper>();
                for(UGI_Subsidiary__c s : subsidiaries){
                    ProcessWrapper pw = new ProcessWrapper(s,count++);
                    processWrapperList.add(pw);
                }
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Function cannot be left blank.'));
                showEdit = true;
            }
        }catch(Exception exp){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ERROR: '+exp.getMessage()));
            showEdit = true;
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