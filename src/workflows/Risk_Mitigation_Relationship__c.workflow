<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Annual_Cost_Update</fullName>
        <field>Annual_Cost__c</field>
        <formula>Mitigation__r.Annual_Mitigation_Cost__c</formula>
        <name>Annual Cost Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Annual Cost</fullName>
        <actions>
            <name>Annual_Cost_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISBLANK( Annual_Cost__c )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
