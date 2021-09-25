/// Request Object for application : lscalese.configcopy.client
/// <br/>Service : GetSpec
Class lscalese.configcopy.client.msg.GetSpecRequest Extends %Persistent [ Inheritance = left, ProcedureBlock ]
{

/// accept : <ul>
/// <li>application/json</li>
/// </ul>
Property accept As %String [ InitialExpression = "application/json" ];

Property consume As %String;

Storage Default
{
<Data name="GetSpecRequestDefaultData">
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
<DataLocation>^lscalese.coD0BB.GetSpecRequestD</DataLocation>
<DefaultData>GetSpecRequestDefaultData</DefaultData>
<IdLocation>^lscalese.coD0BB.GetSpecRequestD</IdLocation>
<IndexLocation>^lscalese.coD0BB.GetSpecRequestI</IndexLocation>
<StreamLocation>^lscalese.coD0BB.GetSpecRequestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
