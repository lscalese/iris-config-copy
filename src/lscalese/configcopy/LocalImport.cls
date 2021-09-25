/// Description
Class lscalese.configcopy.LocalImport
{

/// Load CPF configuration data from a json format config-api
ClassMethod CPFData(CPFConfig As %DynamicObject) As %Status
{
    Return ##class(Api.Config.Services.Loader).Load(CPFConfig)
}

ClassMethod Security(Filename As %String) As %Status
{
    New $NAMESPACE
    Set $NAMESPACE = "%SYS"
    Return ##class(Security.System).ImportAll(Filename)
}

ClassMethod Tasks(Filename As %String) As %Status
{
    Return ##class(%SYS.Task).ImportTasks(Filename)
}

ClassMethod Globals(Filename As %String) As %Status
{
    #dim FileBinary As %Stream.FileBinary = ##class(%Stream.FileBinary).%New()
    Do FileBinary.LinkToFile(Filename)
    Return ..GlobalsStream(.FileBinary)
}

ClassMethod GlobalsStream(GblStream As %Stream.GlobalBinary) As %Status
{
    Lock +^ExportTmp
    
    Kill:$Data(^ExportTmp) ^ExportTmp

    Try{
        $$$TOE(sc,$SYSTEM.OBJ.LoadStream(GblStream))
        
        Set dt = $zdt($h,3,1)

        If $Data(^ExportTmp($Name(^%SYS("sql","ODBCCONNECTION")))) {
            Merge ^configcopy.backup(dt, $Name(^%SYS("sql","ODBCCONNECTION"))) = ^%SYS("sql","ODBCCONNECTION")
            Kill ^%SYS("sql","ODBCCONNECTION")
            Merge ^%SYS("sql","ODBCCONNECTION") = ^ExportTmp($Name(^%SYS("sql","ODBCCONNECTION")))
        }

    } Catch(ex) {

        Set sc = ex.AsStatus()
            
    }
    
    Kill ^ExportTmp

    Lock -^ExportTmp
    
    Return sc
}

}
