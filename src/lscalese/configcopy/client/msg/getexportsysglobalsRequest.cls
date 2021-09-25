/// Request Object for application : lscalese.configcopy.client
/// <br/>Service : getexportsysglobals
Class lscalese.configcopy.client.msg.getexportsysglobalsRequest Extends %Persistent [ Inheritance = left, ProcedureBlock ]
{

/// accept : <ul>
/// <li>application/xml</li>
/// </ul>
Property accept As %String [ InitialExpression = "application/xml" ];

Property consume As %String;

Storage Default
{
<Data name="getexportsysglobalsRequestDefaultData">
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
<DataLocation>^lscalese.cD0BB.getexportsy745AD</DataLocation>
<DefaultData>getexportsysglobalsRequestDefaultData</DefaultData>
<IdLocation>^lscalese.cD0BB.getexportsy745AD</IdLocation>
<IndexLocation>^lscalese.cD0BB.getexportsy745AI</IndexLocation>
<StreamLocation>^lscalese.cD0BB.getexportsy745AS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
