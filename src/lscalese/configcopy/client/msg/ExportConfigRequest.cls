/// Request Object for application : lscalese.configcopy.client
/// <br/>Service : ExportConfig
Class lscalese.configcopy.client.msg.ExportConfigRequest Extends %Persistent [ Inheritance = left, ProcedureBlock ]
{

/// accept : <ul>
/// <li>application/json</li>
/// </ul>
Property accept As %String [ InitialExpression = "application/json" ];

Property consume As %String;

Storage Default
{
<Data name="ExportConfigRequestDefaultData">
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
<DataLocation>^lscalese.cD0BB.ExportConfi9065D</DataLocation>
<DefaultData>ExportConfigRequestDefaultData</DefaultData>
<IdLocation>^lscalese.cD0BB.ExportConfi9065D</IdLocation>
<IndexLocation>^lscalese.cD0BB.ExportConfi9065I</IndexLocation>
<StreamLocation>^lscalese.cD0BB.ExportConfi9065S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
