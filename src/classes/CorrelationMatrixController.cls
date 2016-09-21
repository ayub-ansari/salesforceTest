public class CorrelationMatrixController{
    
    public Matrix__c matrix {get; set;}
       
    public string selCurMat {get; set;}
    
    public string matDesc {get; set;}
    
    public List<String> rIds {get; set;}
    
    public MLN_Risk__c filterRisk {get; set;}
    
    public CorrelationMatrixController() {
        Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=10'); 
        filterRisk = new MLN_Risk__c();
        
        matrix = new Matrix__c();
        
        if(ApexPages.currentPage().getParameters().get('matrixID') != null)
        {
            
            rIds = new List<string>();
                        
            selCurMat = ApexPages.currentPage().getParameters().get('matrixID');
            
            for(Correlation__c c: [select id, Name, Correlation__c, Risk1__c, Risk2__c, Matrix__c from Correlation__c where Matrix__r.id =: selCurMat order by Risk1__r.Name]){
                rIds.add(c.Risk1__c);
            }
            
            if(selCurMat != '-none-'){
                
                getriskList();
                
                getCorrelationMap();
                
                matrix = [select Id, Name, CreatedBy.FirstName, CreatedBy.LastName, CreatedDate, Description__c, Type_of_Matrix__c from Matrix__c where ID =: selCurMat];
                
                matDesc = matrix.Description__c;
            }
            
        }
        
    }
    
    public string valueCheck {get; set;}      
    
    public List<SelectOption> getRFoptions() {
        
        String soqlQuery = '';
        
        al.NestableCondition criteria = new al.AndCondition();
        if (filterRisk.Risk_Status__c != null) criteria.add(new al.FieldCondition('Risk_Status__c').equals(filterRisk.Risk_Status__c));
        if (filterRisk.Parent_Category__c != null) criteria.add(new al.FieldCondition('Parent_Category__c').equals(filterRisk.Parent_Category__c));
        
        soqlQuery = new al.SoqlBuilder()
                            .selectx(new Set<Object>{'Id', 'Name', 'Risk_Status__c','Parent_Category__c'})
                            .fromx('MLN_Risk__c')
                    .wherex(
                                new al.AndCondition()
                                    .add(criteria)
                            )
                    .orderByx(new al.OrderBy('Name').ascending().nullsLast())
                    .toSoql(); 
        
        List<MLN_Risk__c> RiskQueryList = new List<MLN_Risk__c>();
        RiskQueryList = Database.query(soqlQuery);
        
        List<SelectOption> options = new List<SelectOption>();
        for(MLN_Risk__c r: RiskQueryList)
        {
            options.add(new SelectOption(r.Id,r.Name));
        }
        return options;
    }
    
    public List<SelectOption> getMXoptions() {
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('-none-', '-none-'));
        
        for(Matrix__c r: [select Id, Name, CreatedBy.FirstName, CreatedBy.LastName, CreatedDate, Description__c, Type_of_Matrix__c from Matrix__c order by CreatedDate DESC])
        {
            DateTime dT = r.CreatedDate;
            Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
            string opVal = r.Type_of_Matrix__c + ' Matrix ' + r.Name + ' created by ' + r.CreatedBy.FirstName + ' ' + r.CreatedBy.LastName + ' on  ' + string.valueof(myDate).remove('00:00:00');
            options.add(new SelectOption(r.Id,opVal));
        }
        
        return options;
    }
    
    public list<MLN_Risk__c> rlist {get; set;}
    
    public list<MLN_Risk__c> getriskList() {
        
        matrix = new Matrix__c();
        
        list<MLN_Risk__c> risklist = new list<MLN_Risk__c>();
        
        for(MLN_Risk__c r: [select id, Name from MLN_Risk__c WHERE id IN: rIds order by Name])
        {
            risklist.add(r);   
        }
        
        rlist = risklist;
        
        return risklist;
    }
    
    public map<string, List<Correlation__c>> CorrMap {get; set;}
    
    public map<string, map<string, string>> tableStyle {get; set;}
    
    Set<string> mapIds = new Set<string>();
    
    public map<string, List<Correlation__c>> getCorrelationMap() {
        
        map<string, List<Correlation__c>> CorrMapIns = new map<string, List<Correlation__c>>();
        
        Map<string, Correlation__c> CMap = new map<string, Correlation__c>();
        
        tableStyle = new map<string, map<string,string>>();
        
        set<string> dupSet = new set<string>();
        
        for(Correlation__c c: [select id, Name, Correlation__c, Risk1__c, Risk2__c, Matrix__c from Correlation__c where Risk1__r.id IN: rIds AND Risk2__r.id IN: rIds AND Matrix__c =: selCurMat]){
            
            //string mapID = string.valueof(c.Risk1__c) + string.valueof(c.Risk2__c);
            
            string mapIDdup = string.valueof(c.Risk1__c) + string.valueof(c.Risk2__c);
            
            //mapIds.add(mapID);
            
            //CMap.put(mapID, c);
            
            CMap.put(mapIDdup, c);
            
            if(c.Risk2__c != c.Risk1__c){
                Correlation__c cdup = new Correlation__c();
                cdup.Risk1__c = string.valueof(c.Risk2__c);
                cdup.Risk2__c = string.valueof(c.Risk1__c);
                cdup.Correlation__c = null;
                
                string mapID = string.valueof(cdup.Risk1__c) + string.valueof(cdup.Risk2__c);
                                
                CMap.put(mapID, cdup);
            }
            
            //CMap.put(mapIDdup, c);
        }
        
        for(integer x = 0; x < rlist.size(); x++)
        {
            
            integer a = x;
            
            for(integer y = 0; y < rlist.size(); y++)
            {
             
                if(CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)) == null)
                {
                    if(string.valueof(rlist.get(x).id) == string.valueof(rlist.get(y).id))
                    {
                        Correlation__c c = new Correlation__c();
                        c.Risk1__c = string.valueof(rlist.get(x).id);
                        c.Risk2__c = string.valueof(rlist.get(y).id);
                        c.Correlation__c = 1;
                        
                        string mapID = string.valueof(c.Risk1__c) + string.valueof(c.Risk2__c);
                        
                        CMap.put(mapID, c);
                    }else{
                        
                        Correlation__c c = new Correlation__c();
                        c.Risk2__c = string.valueof(rlist.get(x).id);
                        c.Risk1__c = string.valueof(rlist.get(y).id);
                        c.Correlation__c = 0;
                        
                        string mapID = string.valueof(c.Risk1__c) + string.valueof(c.Risk2__c);
                        
                        CMap.put(mapID, c);
                        
                        Correlation__c cdup = new Correlation__c();
                        cdup.Risk2__c = string.valueof(rlist.get(y).id);
                        cdup.Risk1__c = string.valueof(rlist.get(x).id);
                        cdup.Correlation__c = null;
                        
                        string mapIDdup = string.valueof(cdup.Risk1__c) + string.valueof(cdup.Risk2__c);
                        
                        CMap.put(mapIDdup, cdup);
                                                
                    }
                }
                
            }
            
        }
        
        for(integer x = 0; x < rlist.size(); x++)
        {
            
            List<Correlation__c> clist = new List<Correlation__c>();
            
            //List<String> sList = new List<String>();
            
            map<string, string> sMap = new map<string, string>();
            
            integer a = x;
            
            string color = 'none';
            
            for(integer y = 0; y < rlist.size(); y++)
            {
                
                color = 'none';
                
                clist.add(CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)));
                
                //if(x > y && dupSet.contains(string.valueof(rlist.get(y).id) + string.valueof(rlist.get(x).id)))
                //{
                //    sMap.put(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id), 'black');
                //    clist.add(CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)));
                //}else
                //if(x < y)
                //{
                //    system.debug('black id ' +string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id));
                //    sMap.put(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id), 'black');
                //clist.add(CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)));
                //}else{
                //    sMap.put(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id), 'red');
                //    system.debug('red id ' + string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id));
                //    clist.add(CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)));
                //}
                
                if(CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)) != null)
                {
                    if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c > 0) && (CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c <= 0.25))
                    {
                       color = 'red1';
                    }
                    else if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c > 0.25 ) && (CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c <= 0.50))
                    {
                       color = 'red2';   
                    }
                    else if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c > 0.5 ) && (CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c <= 0.75))
                    {
                       color = 'red3';   
                    }
                    else if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c > 0.75 ) && (CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c <= 1))
                    {
                       color = 'red4';   
                    }else if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c < 0) && (CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c >= -0.25))
                    {
                       color = 'green1';
                    }
                    else if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c < -0.25 ) && (CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c >= -0.50))
                    {
                       color = 'green2';   
                    }
                    else if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c < -0.5 ) && (CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c >= -0.75))
                    {
                       color = 'green3';   
                    }
                    else if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c < -0.75 ) && (CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c >= -1))
                    {
                       color = 'green4';   
                    }else if((CMap.get(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id)).Correlation__c == null )){
                        color = 'notrendered';
                    }
                        
                }
                
                if(string.valueof(rlist.get(x).id) == string.valueof(rlist.get(y).id))
                {
                    color = 'red4';
                }
                
                sMap.put(string.valueof(rlist.get(x).id) + string.valueof(rlist.get(y).id), color);
                
            }
            
            //clist.sort();
            
            CorrMapIns.put(string.valueof(rlist.get(x).id), clist);
            
            tableStyle.put(string.valueof(rlist.get(x).id), sMap);
            
            system.debug('tabeStyle map' + tableStyle.get(string.valueof(rlist.get(x).id)));
            
            //tableStyle.put(string.valueof(rlist.get(x).id), slist);
            
            system.debug('CorrMap size ' + CorrMapIns.get(string.valueof(rlist.get(x).id)).size());
            
        }
        
        CorrMap = CorrMapIns;
        
        return CorrMapIns;
    }
    
    public PageReference filterRiskList() {
        
         if(matDesc !=  null){
            matDesc = null;
        }
        
        if(CorrMap !=  null){
            CorrMap.clear();
        }
        
        if(tableStyle != null){
           tableStyle.clear();   
        }
        
        if(mapIds != null){
            mapIds.clear();
        }
        
        if(selCurMat != null)
        {
           selCurMat = null;   
        }
        
        matrix = new Matrix__c();
        
        getriskList();
        getCorrelationMap();
        
        system.debug('rlist filter ' +rlist);
        
        return null;
        
    }
    
    public PageReference filterEXTMX() {
        
        if(matDesc !=  null){
            matDesc = null;
        }
        
        if(CorrMap !=  null){
            CorrMap.clear();
        }
        
        if(mapIds != null){
            mapIds.clear();
        }
                
        if(rlist != null){
            rlist.clear();   
        }
        
        if(rIds != null){
            rIds.clear();   
        }
        
        for(Correlation__c c: [select id, Name, Correlation__c, Risk1__c, Risk2__c, Matrix__c from Correlation__c where Matrix__r.id =: selCurMat order by Risk1__r.Name]){
            rIds.add(c.Risk1__c);
        }
        
        if(selCurMat != '-none-'){
            
            filterRisk.Risk_Status__c = null;
            
            getriskList();
            
            getCorrelationMap();
            
            matrix = [select Id, Name, CreatedBy.FirstName, CreatedBy.LastName, CreatedDate, Description__c, Type_of_Matrix__c from Matrix__c where ID =: selCurMat];
            
            matDesc = matrix.Description__c;
        }
        
        return null;
        
    }
    
    public PageReference saveMatrix() 
    {
        system.debug('value');
        
        set<Correlation__c> upsertCorr = new set<Correlation__c>();
        
        set<Correlation__c> deleteCorr = new set<Correlation__c>();
        
        if(matDesc != null)
        {
            matrix.Description__c = matDesc;
        }
        
        if(selCurMat == '-none-' || selCurMat == null){
        
            try
            {
                insert matrix;
            }catch (exception e)
            {
                ApexPages.addMessages(e);
                
                return null;
            }
            
            selCurMat =  matrix.id;
        }else
        {
            try
            {
             update matrix;
                
            }catch (exception e)
            {
                ApexPages.addMessages(e);
                
                return null;
            }
        }
        
        for(integer x = 0; x < rlist.size(); x++)
        {
            system.debug('get list' + CorrMap.get(rlist.get(x).id));
            
            for(integer y = 0; y < CorrMap.get(rlist.get(x).id).size(); y++)
            {
                system.debug('save CorrMap size ' + CorrMap.get(rlist.get(x).id).size());
                
                system.debug('x y outside '+ x + ' ' + y);
                
                if(CorrMap.get(rlist.get(x).id).get(y).Correlation__c != null)
                {
                    system.debug('x y inside '+ x + ' ' + y);
                    system.debug('upsert ->>>' + CorrMap.get(rlist.get(x).id).get(y));
                    
                    if(CorrMap.get(rlist.get(x).id).get(y).Matrix__c == null && selCurMat == '-none-')
                    {
                        CorrMap.get(rlist.get(x).id).get(y).Matrix__c = matrix.id;
                    }else if(CorrMap.get(rlist.get(x).id).get(y).Matrix__c == null){
                        CorrMap.get(rlist.get(x).id).get(y).Matrix__c = selCurMat;   
                    }
                    
                    upsertCorr.add(CorrMap.get(rlist.get(x).id).get(y));
                }else{
                    
                    try
                    {
                        if (mapIds.contains(string.valueof(CorrMap.get(rlist.get(x).id).get(y).Risk1__c) + string.valueof(CorrMap.get(rlist.get(x).id).get(y).Risk2__c)) && CorrMap.get(rlist.get(x).id).get(y).Correlation__c == null)
                        {
                            deleteCorr.add(CorrMap.get(rlist.get(x).id).get(y));
                        }
                    }
                    catch (exception e)
                    {
                        
                    }
                }
            }
        }
        
        list<Correlation__c> upsertCorrlist = new list<Correlation__c>();
        
        upsertCorrlist.addAll(upsertCorr);
        
        list<Correlation__c> deleteCorrlist = new list<Correlation__c>();
        
        deleteCorrlist.addAll(deleteCorr);
        
        
        try{
            upsert upsertCorrlist;
            valueCheck = null;
            
            
            
            if(deleteCorrlist.size() != null)
            {
                delete deleteCorrlist;
            }
            
            
            upsertCorrlist.clear();
            
            deleteCorrlist.clear();
            
            CorrMap.clear();
            
            mapIds.clear();
            
            if(selCurMat == null || selCurMat == '-none-'){
                
                getCorrelationMap();
            }
            
            if(selCurMat != '-none-'){
                                
                if(rlist != null){
                    rlist.clear();   
                }
                
                if(rIds != null){
                    rIds.clear();   
                }
                
                for(Correlation__c c: [select id, Name, Correlation__c, Risk1__c, Risk2__c, Matrix__c from Correlation__c where Matrix__r.id =: selCurMat order by Risk1__r.Name]){
                    rIds.add(c.Risk1__c);
                }
                
                getriskList();
                
                getCorrelationMap();
                
                matrix = [select Id, Name, CreatedBy.FirstName, CreatedBy.LastName, CreatedDate, Description__c, Type_of_Matrix__c from Matrix__c where ID =: selCurMat];
                
                matDesc = matrix.Description__c;
            }
            
        } catch (Exception e) {
            ApexPages.addMessages(e);
            system.debug('exception ' + e);
            valueCheck = 'You have entered a value that is greater than 1 or less than -1';
        }
        
        return null;
    }
    
    public PageReference resetMatrix(){
                
        set<string> corrMapKeySet = new set<string>();
        
        corrMapKeySet = CorrMap.keySet();
        
        List<string> corrMapKeyList = new List<string>();
        
        corrMapKeyList.addAll(corrMapKeySet);
        
        for(integer x = 0;  x < corrMapKeyList.size(); x++){
            for(integer y = 0; y < corrMap.get(corrMapKeyList.get(x)).size(); y++){
                if(corrMap.get(corrMapKeyList.get(x)).get(y).Risk1__c != corrMap.get(corrMapKeyList.get(x)).get(y).Risk2__c && corrMap.get(corrMapKeyList.get(x)).get(y).Correlation__c != null){
                    corrMap.get(corrMapKeyList.get(x)).get(y).Correlation__c = 0;
                }
            }            
        }
        
        saveMatrix();
                
        return null;
    }
    
    public pageReference deleteMatrix(){
        delete matrix;
        
        if(matDesc !=  null){
            matDesc = null;
        }
        
        if(CorrMap !=  null){
            CorrMap.clear();
        }
        
        if(mapIds != null){
            mapIds.clear();
        }
                
        if(rlist != null){
            rlist.clear();   
        }
        
        if(rIds != null){
            rIds.clear();   
        }
        
        matrix = new Matrix__c();
        
        return null;
    }
    
    public pageReference RisksWithFilter(){
               
        if(rlist != null){
            rlist.clear();   
        }
        
        if(rids != null){
            rids.clear();   
        }
        
        if(selCurMat != '-None-'){
            selCurMat = '-None-';
        }
        
        getRFoptions();
        
        return null;
    }
    
}