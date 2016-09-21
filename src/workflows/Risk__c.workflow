<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Executive_Owner_when_Risk_Direction_is_Rising_Steeply</fullName>
        <description>Email Executive Owner when Risk Direction is Rising Steeply</description>
        <protected>false</protected>
        <recipients>
            <field>Executive_Owner__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <recipient>admin.mln.asc@riskonnect.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GRC_Templates/Email_Template_for_Rising_Steeply_Risk_Direction</template>
    </alerts>
    <alerts>
        <fullName>Email_User_when_Current_Risk_Score_is_Red_Target_Risk_Score_Current_Risk_Score_b</fullName>
        <description>Email User when Current Risk Score is Red, Target Risk Score &lt; Current Risk Score, but Risk Appetite = Acceptable</description>
        <protected>false</protected>
        <recipients>
            <field>Risk_Owner__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GRC_Templates/Email_Template_for_Incorrect_Risk_Appetite</template>
    </alerts>
    <fieldUpdates>
        <fullName>Expected</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Expected</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Expected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Normal_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Normal</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Normal Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Triangular_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Triangular</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Triangular Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Expected Risk Record Type</fullName>
        <actions>
            <name>Expected</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Risk__c.Risk_Metrics__c</field>
            <operation>equals</operation>
            <value>Expected</value>
        </criteriaItems>
        <description>Changes the Record type of a risk to Expected</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Normal Risk Record Type</fullName>
        <actions>
            <name>Normal_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Risk__c.Risk_Metrics__c</field>
            <operation>equals</operation>
            <value>Normal</value>
        </criteriaItems>
        <description>Changes the Record type of a risk to Normal</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Risk Direction Changed</fullName>
        <actions>
            <name>Email_Executive_Owner_when_Risk_Direction_is_Rising_Steeply</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>Risk__c.Risk_Direction__c</field>
            <operation>equals</operation>
            <value>Rising Steeply</value>
        </criteriaItems>
        <description>Evaluates to true when:
Risk Direction is Rising Steeply</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Triangular Risk Record Type</fullName>
        <actions>
            <name>Triangular_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Risk__c.Risk_Metrics__c</field>
            <operation>equals</operation>
            <value>Triangular</value>
        </criteriaItems>
        <description>Changes the Record type of a risk to Triangular</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Unacceptable Risk Appetite</fullName>
        <actions>
            <name>Email_User_when_Current_Risk_Score_is_Red_Target_Risk_Score_Current_Risk_Score_b</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Evaluates to true when:
Current Risk Score &gt; 15
Risk Appetite = &quot;Acceptable&quot;
and Target Risk Score &lt; Current Risk Score</description>
        <formula>AND( Current_Risk_Score__c &gt; 15,  ISPICKVAL(Risk_Appetite__c, &quot;Acceptable&quot;) ,  Target_Risk_Score__c  &lt; Current_Risk_Score__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
