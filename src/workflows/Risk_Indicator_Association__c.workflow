<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Risk_Indicator_Threshold_Reached</fullName>
        <ccEmails>andrew.barnhart@riskonnect.com, russell.mcguire@riskonnect.com</ccEmails>
        <description>Risk/Indicator Threshold Reached</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GRC_Templates/Indicator_Threshold_Reached</template>
    </alerts>
    <rules>
        <fullName>Risk%2FIndicator Threshold Reached</fullName>
        <actions>
            <name>Risk_Indicator_Threshold_Reached</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>sends an email when the Risk/Indicator record reaches the Upper Threshold</description>
        <formula>IF(Indicator__r.RecordType_Name__c =&quot;KPI - Currency&quot;, Indicator__r.Values_Currency__c &gt; KPI_Upper_Threshold_Currency__c, IF(Indicator__r.RecordType_Name__c =&quot;KRI - Currency&quot;, Indicator__r.Values_Currency__c &gt; KPI_Upper_Threshold_Currency__c, IF(Indicator__r.RecordType_Name__c =&quot;KPI - Number&quot;, Indicator__r.Values_Number__c &gt; KPI_Upper_Threshold_Number__c, IF(Indicator__r.RecordType_Name__c =&quot;KRI - Number&quot;, Indicator__r.Values_Number__c &gt; KPI_Upper_Threshold_Number__c, IF(Indicator__r.RecordType_Name__c =&quot;KPI - Percent&quot;, Indicator__r.Values_Percent__c &gt; KPI_Upper_Threshold_Percent__c, IF(Indicator__r.RecordType_Name__c =&quot;KRI - Percent&quot;, Indicator__r.Values_Percent__c &gt; KPI_Upper_Threshold_Percent__c, IF(Indicator__r.RecordType_Name__c =&quot;KPI - Picklist&quot;, FALSE, IF(Indicator__r.RecordType_Name__c =&quot;KRI - Picklist&quot;, FALSE, FALSE))))))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
