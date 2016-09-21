<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Indicator_RecordType_Name</fullName>
        <field>RecordType_Name__c</field>
        <formula>RecordType__c</formula>
        <name>Populate Indicator RecordType Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Indicator RecordType Name</fullName>
        <actions>
            <name>Populate_Indicator_RecordType_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Indicator__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Populate Indicator RecordType_Name__c with $RecordType.Name from RecordType__c</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
