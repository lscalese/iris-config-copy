/// Description
Class lscalese.configcopy.ExportFilterTemplate
{

ClassMethod Get(Name As %String = "Default") As %DynamicObject
{
    Set XData = ##class(%Dictionary.CompiledXData).%OpenId($CLASSNAME()_"||"_Name)
    Return {}.%FromJSON(XData.Data)
}

XData Default [ MimeType = application/json ]
{
{
    "Databases": "",
    "Namespaces":"",
    "MapGlobals":"",
    "MapPackages": "",
    "MapRoutines":"",
    "Journal":"",
    "Startup":"",
    "config":"",
    "Miscellaneous":"",
    "LicenseServers":"",
    "Monitor":"",
    "IO":"",
    "SQL":"",
    "SQLSysDatatypes":"",
    "SQLUserDatatypes":"",
    "Telnet":""
}
}

}
