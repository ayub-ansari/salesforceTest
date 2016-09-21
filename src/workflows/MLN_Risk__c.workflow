<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Current_Impact_Number_Update</fullName>
        <field>Current_Impact_Number__c</field>
        <formula>CASE( TEXT(Current_Impact__c) , &apos;1 - Insignificant&apos;, 1,
&apos;2 - Minor&apos;, 2,
&apos;3 - Moderate&apos;, 3,
&apos;4 - Major&apos;, 4,
&apos;5 - Catastrophic&apos;, 5,
null)</formula>
        <name>Current Impact Number Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Current_Likelihood_Number_Update</fullName>
        <field>Current_Likelihood_Number__c</field>
        <formula>CASE( TEXT( Current_Likelihood__c ) , &apos;1 - Rare&apos;, 1, 
&apos;2 - Unlikely&apos;, 2, 
&apos;3 - Possible&apos;, 3, 
&apos;4 - Likely&apos;, 4, 
&apos;5 - Almost Certain&apos;, 5, 
null)</formula>
        <name>Current Likelihood Number Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
