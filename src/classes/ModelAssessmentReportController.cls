public with sharing class ModelAssessmentReportController {
	public Contact con{get;set;}
	public string preparedBy{get;set;}
	public String preparedDate{get;set;}
	Model__c model;
	
	
	public map<string,string> modelValuesMap{get;set;} 
	
	//Standard Controller for ModelAssessmentReport.page
	public ModelAssessmentReportController(ApexPages.StandardController stdController){
		model = (Model__c)stdController.getRecord();
		con = new Contact();
	}
	
	public PageReference generatePdf(){
		system.debug('#### Date : '+con.Birthdate);
		system.debug('#### preparedBy : '+con.FirstName);
		PageReference pg = new PageReference('/apex/ModelAssessmentReportPdf?id='+model.Id+'&preparedDate='+con.Birthdate+'&preparedBy='+con.FirstName);
		return pg;
	}
	
	//Controller for ModelAssessmentReportPDF.page
	public ModelAssessmentReportController(){
		modelValuesMap = new map<string,string>();
		
		string modelId = ApexPages.currentPage().getParameters().get('id');
		preparedDate = ApexPages.currentPage().getParameters().get('preparedDate');
		preparedBy = ApexPages.currentPage().getParameters().get('preparedBy');
		system.debug('#### PDF model Id : '+modelId);
		system.debug('#### PDF preparedDate : '+preparedDate);
		system.debug('#### PDF preparedBy : '+preparedBy);
		
		if(preparedDate != null && preparedDate != ''){
			string dateString = preparedDate.split(' ')[0];
			preparedDate = dateString.split('-')[1]+'/'+dateString.split('-')[2]+'/'+dateString.split('-')[0];
		}
		
		model = [select id, Name, Model_Owner__c, Defined_Purpose_and_Scope__c, Model_User_Training__c, Security_confidentiality__c, Executive_Sponsor__c, 
				  Model_Management_Tied_to_Performance__c, Data__c, Assumptions__c, Methodology__c, Calculation__c, 
				  Model_Architecture__c, Model_Results__c, Independent_Model_Review__c, Model_Integrity__c, Reviewer_Qualifications_Trainings__c, 
				  Monitoring_Procedure__c, Model_Validation_Triggers__c, Model_Modification_Procedure__c, Limitation_of_Model__c, 
				  Change_Management__c, Overrides__c, Model_Documentation__c, Model_Results_Communication__c, Supporting_Materials__c, Incident_Records__c,  
				  Total_Section_Level__c, Governance_Section_Level__c, Validation_Section_Level__c, Proc_Docs_Section_Level__c 
				  from Model__c where id =: modelId limit 1];
		system.debug('#### PDF model : '+model);
		
		modelValuesMap.put('Name',model.Name);
		modelValuesMap.put('Mature','#99CC99');
		modelValuesMap.put('Intermediate','#ccccff');
		modelValuesMap.put('Initial','#CD5C5C');
		
		
		if(model.Governance_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yu" alt=" " border="0"/>'){
			modelValuesMap.put('Governance_Section_Level','Initial');
		}else if(model.Governance_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yz" alt=" " border="0"/>'){
			modelValuesMap.put('Governance_Section_Level','Intermediate');
		}else if(model.Governance_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yf" alt=" " border="0"/>'){
			modelValuesMap.put('Governance_Section_Level','Mature');
		}else{
			modelValuesMap.put('Governance_Section_Level','WRONG');
		}
		
		if(model.Validation_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yu" alt=" " border="0"/>'){
			modelValuesMap.put('Validation_Section_Level','Initial');
		}else if(model.Validation_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yz" alt=" " border="0"/>'){
			modelValuesMap.put('Validation_Section_Level','Intermediate');
		}else if(model.Validation_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yf" alt=" " border="0"/>'){
			modelValuesMap.put('Validation_Section_Level','Mature');
		}else{
			modelValuesMap.put('Validation_Section_Level','WRONG');
		}
		
		if(model.Proc_Docs_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yu" alt=" " border="0"/>'){
			modelValuesMap.put('Proc_Doc_Section_Level','Initial');
		}else if(model.Proc_Docs_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yz" alt=" " border="0"/>'){
			modelValuesMap.put('Proc_Doc_Section_Level','Intermediate');
		}else if(model.Proc_Docs_Section_Level__c == '<img src="/servlet/servlet.FileDownload?file=015M0000000C3yf" alt=" " border="0"/>'){
			modelValuesMap.put('Proc_Doc_Section_Level','Mature');
		}else{
			modelValuesMap.put('Proc_Doc_Section_Level','WRONG');
		}
		
		modelValuesMap.put('Overall_Section_Level',model.Total_Section_Level__c);
		
		//Governance Section
		if(model.Model_Owner__c != null && model.Model_Owner__c != '') modelValuesMap.put('Model_Owner__c','Yes');
		else modelValuesMap.put('Model_Owner__c','No');
		
		if(model.Defined_Purpose_and_Scope__c != null && model.Defined_Purpose_and_Scope__c) modelValuesMap.put('Defined_Purpose_and_Scope__c','Yes');
		else modelValuesMap.put('Defined_Purpose_and_Scope__c','No');
		
		if(model.Model_User_Training__c != null && model.Model_User_Training__c) modelValuesMap.put('Model_User_Training__c','Yes');
		else modelValuesMap.put('Model_User_Training__c','No');
		
		if(model.Security_confidentiality__c != null && model.Security_confidentiality__c) modelValuesMap.put('Security_confidentiality__c','Yes');
		else modelValuesMap.put('Security_confidentiality__c','No');
		
		if(model.Executive_Sponsor__c != null && model.Executive_Sponsor__c != '') modelValuesMap.put('Executive_Sponsor__c','Yes');
		else modelValuesMap.put('Executive_Sponsor__c','No');
		
		if(model.Model_Management_Tied_to_Performance__c != null && model.Model_Management_Tied_to_Performance__c) modelValuesMap.put('Model_Management_Tied_to_Performance__c','Yes');
		else modelValuesMap.put('Model_Management_Tied_to_Performance__c','No');
		
		//Validation Section
		if(model.Data__c != null && model.Data__c) modelValuesMap.put('Data__c','Yes');
		else modelValuesMap.put('Data__c','No');
		
		if(model.Assumptions__c != null && model.Assumptions__c) modelValuesMap.put('Assumptions__c','Yes');
		else modelValuesMap.put('Assumptions__c','No');
		
		if(model.Methodology__c != null && model.Methodology__c) modelValuesMap.put('Methodology__c','Yes');
		else modelValuesMap.put('Methodology__c','No');
		
		if(model.Calculation__c != null && model.Calculation__c) modelValuesMap.put('Calculation__c','Yes');
		else modelValuesMap.put('Calculation__c','No');
		
		if(model.Model_Architecture__c != null && model.Model_Architecture__c) modelValuesMap.put('Model_Architecture__c','Yes');
		else modelValuesMap.put('Model_Architecture__c','No');
		
		if(model.Model_Results__c != null && model.Model_Results__c) modelValuesMap.put('Model_Results__c','Yes');
		else modelValuesMap.put('Model_Results__c','No');
		
		if(model.Independent_Model_Review__c != null && model.Independent_Model_Review__c == 'Yes') modelValuesMap.put('Independent_Model_Review__c','Yes');
		else modelValuesMap.put('Independent_Model_Review__c','No');
		
		if(model.Model_Integrity__c != null && model.Model_Integrity__c) modelValuesMap.put('Model_Integrity__c','Yes');
		else modelValuesMap.put('Model_Integrity__c','No');
		
		if(model.Reviewer_Qualifications_Trainings__c != null && model.Reviewer_Qualifications_Trainings__c) modelValuesMap.put('Reviewer_Qualifications_Trainings__c','Yes');
		else modelValuesMap.put('Reviewer_Qualifications_Trainings__c','No');
		
		if(model.Monitoring_Procedure__c != null && model.Monitoring_Procedure__c) modelValuesMap.put('Monitoring_Procedure__c','Yes');
		else modelValuesMap.put('Monitoring_Procedure__c','No');
		
		if(model.Model_Validation_Triggers__c != null && model.Model_Validation_Triggers__c) modelValuesMap.put('Model_Validation_Triggers__c','Yes');
		else modelValuesMap.put('Model_Validation_Triggers__c','No');
		
		if(model.Model_Modification_Procedure__c != null && model.Model_Modification_Procedure__c) modelValuesMap.put('Model_Modification_Procedure__c','Yes');
		else modelValuesMap.put('Model_Modification_Procedure__c','No');
		
		//Procedures & Documentation section 
		if(model.Limitation_of_Model__c != null && model.Limitation_of_Model__c != '') modelValuesMap.put('Limitation_of_Model__c','Yes');
		else modelValuesMap.put('Limitation_of_Model__c','No');
		
		if(model.Change_Management__c && model.Overrides__c) modelValuesMap.put('ChangeManagement_Overrides','Yes');
		else modelValuesMap.put('ChangeManagement_Overrides','No');
		
		if(model.Model_Documentation__c) modelValuesMap.put('Model_Documentation__c','Yes');
		else modelValuesMap.put('Model_Documentation__c','No');
		
		if(model.Model_Results_Communication__c) modelValuesMap.put('Model_Results_Communication__c','Yes');
		else modelValuesMap.put('Model_Results_Communication__c','No');
		
		if(model.Supporting_Materials__c) modelValuesMap.put('Supporting_Materials__c','Yes');
		else modelValuesMap.put('Supporting_Materials__c','No');
		
		if(model.Incident_Records__c) modelValuesMap.put('Incident_Records__c','Yes');
		else modelValuesMap.put('Incident_Records__c','No');
		system.debug('#### PDF modelValuesMap : '+modelValuesMap.size());
	}
}