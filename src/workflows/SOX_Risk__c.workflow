<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Overall_Risk</fullName>
        <field>Overall_Risk_Score__c</field>
        <formula>IF(Numeric_Total__c &gt;= 14,5, 
IF(Numeric_Total__c &gt;= 12,4,
IF(Numeric_Total__c &gt;= 9,3,
IF(Numeric_Total__c &gt;= 7,2,
IF(Numeric_Total__c &gt;= 5,1,0)))))</formula>
        <name>Update Overall Risk</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Overall Risk Score</fullName>
        <actions>
            <name>Update_Overall_Risk</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
