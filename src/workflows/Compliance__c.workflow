<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Elevated_Compliance</fullName>
        <description>Elevated Compliance</description>
        <protected>false</protected>
        <recipients>
            <field>Compliance_Owner__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GRC_Templates/Elevated_Compliance</template>
    </alerts>
    <rules>
        <fullName>Elevated Compliance</fullName>
        <actions>
            <name>Elevated_Compliance</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Compliance__c.Escalated__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>Sends an email when Elevated__c picklist is &apos;Yes&apos; on Compliance__c object</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
