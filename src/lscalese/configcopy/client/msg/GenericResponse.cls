Class lscalese.configcopy.client.msg.GenericResponse Extends %Persistent [ Inheritance = left, ProcedureBlock ]
{

Property body As %Stream.GlobalBinary;

Property headers As array Of %String(MAXLEN = 128, TRUNCATE = 1);

Property httpStatusCode As %Integer;

Property operation As %String(MAXLEN = 128, TRUNCATE = 1);

Property operationStatusText As %String(MAXLEN = 128, TRUNCATE = 1);

Property parsedResponse As lscalese.configcopy.client.msg.ParsedResponse;

Storage Default
{
<Data name="GenericResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>body</Value>
</Value>
<Value name="3">
<Value>httpStatusCode</Value>
</Value>
<Value name="4">
<Value>operation</Value>
</Value>
<Value name="5">
<Value>operationStatusText</Value>
</Value>
<Value name="6">
<Value>parsedResponse</Value>
</Value>
</Data>
<Data name="headers">
<Attribute>headers</Attribute>
<Structure>subnode</Structure>
<Subscript>"headers"</Subscript>
</Data>
<DataLocation>^lscalese.cD0BB.GenericResp16D5D</DataLocation>
<DefaultData>GenericResponseDefaultData</DefaultData>
<IdLocation>^lscalese.cD0BB.GenericResp16D5D</IdLocation>
<IndexLocation>^lscalese.cD0BB.GenericResp16D5I</IndexLocation>
<StreamLocation>^lscalese.cD0BB.GenericResp16D5S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
