global class RiskAssociationJSONToolkit {
    webservice static String toJSON(String riskID)
    {
        //List<sObject> returnedAssociations = Database.query(query);
        
        List<String> categoryNames = new List<String>();
        categoryNames.add('Controls');
        categoryNames.add('Stakeholders');
        categoryNames.add('Processes');
        categoryNames.add('Objectives');
        categoryNames.add('Indicators');
        categoryNames.add('Incidents');
        categoryNames.add('Committees');
        categoryNames.add('Assumptions');
        categoryNames.add('GLs');
        categoryNames.add('Projects');
        categoryNames.add('Litigations');
        categoryNames.add('Governances');
        categoryNames.add('Audits');
        categoryNames.add('Locations');
        categoryNames.add('Risks');
        
        List<Risk_Controls_Association__c> controls = [SELECT Risk__r.Id, Risk__r.Name, Controls__r.Id, Controls__r.Name from Risk_Controls_Association__c where Risk__r.Id =:riskID];
        List<Risk_Stakeholder_Association__c> stakeholders = [SELECT Risk__r.Id, Risk__r.Name, Stakeholder__r.Id, Stakeholder__r.Name from Risk_Stakeholder_Association__c where Risk__r.Id =:riskID];
        List<Risk_Process_Association__c> processes = [SELECT Risk__r.Id, Risk__r.Name, Process__r.Id, Process__r.Name from Risk_Process_Association__c where Risk__r.Id =:riskID];
        List<Risk_Objective_Association__c> objectives = [SELECT Risk__r.Id, Risk__r.Name, Objectives__r.Id, Objectives__r.Name from Risk_Objective_Association__c where Risk__r.Id =:riskID];
        List<Risk_Indicator_Association__c> indicators = [SELECT Risk__r.Id, Risk__r.Name, Indicator__r.Id, Indicator__r.Name from Risk_Indicator_Association__c where Risk__r.Id =:riskID];
        List<Risk_Incidents_Association__c> incidents = [SELECT Risk__r.Id, Risk__r.Name, Incident__r.Id, Incident__r.Name from Risk_Incidents_Association__c where Risk__r.Id =:riskID];
        List<Risk_Committee_Association__c> committees = [SELECT Risk__r.Id, Risk__r.Name, Committees__r.Id, Committees__r.Name from Risk_Committee_Association__c where Risk__r.Id =:riskID];
        List<Risk_Assumption_Association__c> assumptions = [SELECT Risks__r.Id, Risks__r.Name, Assumptions__r.Id, Assumptions__r.Name from Risk_Assumption_Association__c where Risks__r.Id =:riskID];
        List<Risk_GL_Association__c> gls = [SELECT Risk__r.Id, Risk__r.Name, General_Ledger__r.Id, General_Ledger__r.Name, General_Ledger__r.GL_Short_Description__c from Risk_GL_Association__c where Risk__r.Id =:riskID];
        List<Risk_Project_Association__c> projects = [SELECT Risk__r.Id, Risk__r.Name, Project__r.Id, Project__r.Name from Risk_Project_Association__c where Risk__r.Id =:riskID];
        List<Litigation_Risk_Association__c> litigations = [SELECT Risk__r.Id, Risk__r.Name, Litigation__r.Id, Litigation__r.Name from Litigation_Risk_Association__c where Risk__r.Id =:riskID];
        List<Governance_Risk_Association__c> governances = [SELECT Risks__r.Id, Risks__r.Name, Governance__r.Id, Governance__r.Name from Governance_Risk_Association__c where Risks__r.Id =:riskID];
        List<Audit_Risk_Association__c> audits = [SELECT Risk__r.Id, Risk__r.Name, Audit__r.Id, Audit__r.Name from Audit_Risk_Association__c where Risk__r.Id =:riskID];
        List<Location_Risk_Association__c> locations = [SELECT Risk__r.Id, Risk__r.Name, RK_Hierarchy__r.Id, RK_Hierarchy__r.Name from Location_Risk_Association__c where Risk__r.Id =:riskID];
        List<Risk_Correlation__c> risks = [SELECT Name, Id, Risk_Name_1__r.Id, Risk_Name_1__r.Name, Risk_Name_2__r.Id, Risk_Name_2__r.Name from Risk_Correlation__c where Risk_Name_1__r.Id =:riskID OR Risk_Name_2__r.Id =:riskID];
        
        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
            generator.writeStringField('name', 'RISK');
            generator.writeStringField('noLink', 'TRUE');
            generator.writeFieldName('children');
            generator.writeStartArray();
                for (String categoryName : categoryNames)
                {
                    generator.writeStartObject();
                        generator.writeStringField('name', categoryName);
                        generator.writeStringField('noLink', 'TRUE');
                        generator.writeFieldName('children');
                        generator.writeStartArray();
                            if (categoryName == 'Controls')
                            {
                                for (Risk_Controls_Association__c control : controls)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', control.Controls__r.Name);
                                        generator.writeStringField('objectID', control.Controls__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Stakeholders')
                            {
                                for (Risk_Stakeholder_Association__c stakeholder : stakeholders)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', stakeholder.Stakeholder__r.Name);
                                        generator.writeStringField('objectID', stakeholder.Stakeholder__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Processes')
                            {
                                for (Risk_Process_Association__c rProcess : processes)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', rProcess.Process__r.Name);
                                        generator.writeStringField('objectID', rProcess.Process__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Objectives')
                            {
                                for (Risk_Objective_Association__c objective : objectives)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', objective.Objectives__r.Name);
                                        generator.writeStringField('objectID', objective.Objectives__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Indicators')
                            {
                                for (Risk_Indicator_Association__c indicator : indicators)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', indicator.Indicator__r.Name);
                                        generator.writeStringField('objectID', indicator.Indicator__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Incidents')
                            {
                                for (Risk_Incidents_Association__c incident : incidents)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', incident.Incident__r.Name);
                                        generator.writeStringField('objectID', incident.Incident__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Committees')
                            {
                                for (Risk_Committee_Association__c committee : committees)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', committee.Committees__r.Name);
                                        generator.writeStringField('objectID', committee.Committees__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Assumptions')
                            {
                                for (Risk_Assumption_Association__c assumption : assumptions)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', assumption.Assumptions__r.Name);
                                        generator.writeStringField('objectID', assumption.Assumptions__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'GLs')
                            {
                                for (Risk_GL_Association__c gl : gls)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', gl.General_Ledger__r.GL_Short_Description__c);
                                        generator.writeStringField('objectID', gl.General_Ledger__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Projects')
                            {
                                for (Risk_Project_Association__c project : projects)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', project.Project__r.Name);
                                        generator.writeStringField('objectID', project.Project__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Litigations')
                            {
                                for (Litigation_Risk_Association__c litigation : litigations)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', litigation.Litigation__r.Name);
                                        generator.writeStringField('objectID', litigation.Litigation__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Governances')
                            {
                                for (Governance_Risk_Association__c governance : governances)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', governance.Governance__r.Name);
                                        generator.writeStringField('objectID', governance.Governance__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Audits')
                            {
                                for (Audit_Risk_Association__c audit : audits)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', audit.Audit__r.Name);
                                        generator.writeStringField('objectID', audit.Audit__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Locations')
                            {
                                for (Location_Risk_Association__c location : locations)
                                {
                                    generator.writeStartObject();
                                        generator.writeStringField('name', location.RK_Hierarchy__r.Name);
                                        generator.writeStringField('objectID', location.RK_Hierarchy__r.ID);
                                    generator.writeEndObject();
                                }
                            }
                            else if (categoryName == 'Risks')
                            {
                                for (Risk_Correlation__c riskCorrelation : risks)
                                {
                                    if (riskCorrelation.Risk_Name_1__r.Id != riskID)
                                    {
                                        generator.writeStartObject();
                                        generator.writeStringField('name', riskCorrelation.Risk_Name_1__r.Name);
                                        generator.writeStringField('objectID', riskCorrelation.Risk_Name_1__r.ID);
                                        generator.writeEndObject();
                                    }
                                    else
                                    {
                                        generator.writeStartObject();
                                            generator.writeStringField('name', riskCorrelation.Risk_Name_2__r.Name);
                                        generator.writeStringField('objectID', riskCorrelation.Risk_Name_2__r.ID);
                                        generator.writeEndObject();
                                    }
                                }
                            }
                        generator.writeEndArray();
                    generator.writeEndObject();
                }
            generator.writeEndArray();
        generator.writeEndObject();
        
        String returnString = generator.getAsString();
        returnString = returnString.replace('\\"', '"');
        returnString = returnString.replace('"{', '{');
        returnString = returnString.replace('}"', '}');
        
        return returnString;
    }
}