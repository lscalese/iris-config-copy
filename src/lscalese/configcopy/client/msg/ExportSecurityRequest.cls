/// Request Object for application : lscalese.configcopy.client
/// <br/>Service : ExportSecurity
Class lscalese.configcopy.client.msg.ExportSecurityRequest Extends %Persistent [ Inheritance = left, ProcedureBlock ]
{

/// accept : <ul>
/// <li>application/xml</li>
/// </ul>
Property accept As %String [ InitialExpression = "application/xml" ];

Property consume As %String;

Storage Default
{
<Data name="ExportSecurityRequestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>accept</Value>
</Value>
<Value name="3">
<Value>consume</Value>
</Value>
</Data>
<DataLocation>^lscalese.cD0BB.ExportSecur6E11D</DataLocation>
<DefaultData>ExportSecurityRequestDefaultData</DefaultData>
<IdLocation>^lscalese.cD0BB.ExportSecur6E11D</IdLocation>
<IndexLocation>^lscalese.cD0BB.ExportSecur6E11I</IndexLocation>
<StreamLocation>^lscalese.cD0BB.ExportSecur6E11S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
