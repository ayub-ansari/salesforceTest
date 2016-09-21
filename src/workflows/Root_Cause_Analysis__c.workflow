<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Root_Cause_to_Risk</fullName>
        <field>Root_Cause__c</field>
        <formula>case( Number_of_Responses__c ,
1,First_Response__c ,
2,Second_Response__c, 
3,Third_Response__c,
4,Fourth_Response__c,
5,Fifth_Response__c,
6,Sixth_Response__c,
7,Seventh_Response__c,
8,Eighth_Response__c,
9,Ninth_Response__c,
10, Tenth_Response__c,
&quot;Multiple Root Causes; see Root Cause tab above.&quot;)</formula>
        <name>Root Cause to Risk</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Risk__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Root Cause to Risk</fullName>
        <actions>
            <name>Root_Cause_to_Risk</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a new Root Cause Analysis is created, send the lowest root cause to the parent Risk</description>
        <formula>Date_of_Analysis__c = TODAY()</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
