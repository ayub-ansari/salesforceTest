<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>New Control Association</fullName>
        <actions>
            <name>Review_Current_Risk_Assesment</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Risk_Controls_Association__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Rule to fire task when a Control is associated with a Risk</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>Review_Current_Risk_Assesment</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>14</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Current Risk Assesment</subject>
    </tasks>
</Workflow>
