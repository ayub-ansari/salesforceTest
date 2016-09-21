@isTest
public class IncidentsAssociationJSONToolkitTest {
  
  static final String GLS_CONST = 'Test GLs';
  static final String RISK_CONST = 'Test Risk';
 
  
  static String JSONResult;
  
  
  static {
    Incident__c incident = new Incident__c(Name = 'Test');
      insert incident;
     
      Risk__c risk = new Risk__c(Name = RISK_CONST);
      insert risk;
      Risk_Incidents_Association__c riskIncidentsAssociation = new Risk_Incidents_Association__c(Incident__c = incident.Id, Risk__c = risk.Id);
      insert riskIncidentsAssociation;
      
      General_Ledger__c gls = new General_Ledger__c (Name = GLS_CONST);
      insert gls;
      Incidents_GL_Association__c incidentGlAssociation = new Incidents_GL_Association__c(Incident__c = incident.id, General_Ledger__c = gls.id);
      insert incidentGlAssociation;
      
      
      JSONResult = IncidentsAssociationJSONToolkit.toJSON(incident.Id);  
      }
      
      
 static testMethod void testIncident() {
    Integer i = 0;
    JSONParser parser = JSON.createParser(JSONResult);
    while (parser.nextToken() != null) {
      if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'name') {
        i++;
        if (i == 3) {
          parser.nextToken();
          break;
        }
      }
    }

    String riskName = parser.getText();
    //System.assert(riskName == RISK_CONST);
  } 
            
}