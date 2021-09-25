/// Request Object for application : lscalese.configcopy.client
/// <br/>Service : ExportTasks
Class lscalese.configcopy.client.msg.ExportTasksRequest Extends %Persistent [ Inheritance = left, ProcedureBlock ]
{

/// accept : <ul>
/// <li>application/xml</li>
/// </ul>
Property accept As %String [ InitialExpression = "application/xml" ];

Property consume As %String;

Storage Default
{
<Data name="ExportTasksRequestDefaultData">
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
<DataLocation>^lscalese.cD0BB.ExportTasksE4E2D</DataLocation>
<DefaultData>ExportTasksRequestDefaultData</DefaultData>
<IdLocation>^lscalese.cD0BB.ExportTasksE4E2D</IdLocation>
<IndexLocation>^lscalese.cD0BB.ExportTasksE4E2I</IndexLocation>
<StreamLocation>^lscalese.cD0BB.ExportTasksE4E2S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
