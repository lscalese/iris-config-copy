/// Export configuration from a remote instance using a REST api.
/// config-copy tools must be also installed on the remote instance.
Class lscalese.configcopy.RemoteExport
{

ClassMethod All(Directory As %String = {$zu(12,"config-copy-remote/")}) As %Status
{
    Set sc = $$$OK
    Set Directory = ##class(%File).NormalizeDirectory(Directory)

    Do:'##class(%File).DirectoryExists(Directory) ##class(%File).CreateDirectoryChain(Directory)

    Set scO =..Security(Directory_"SecurityExport.xml")
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Set scO = ..Tasks(Directory_"TasksExport.xml")
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Set scO = ..Globals(Directory_"GlobalsExport.xml")
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Set scO = ..CPFData(Directory_"config-api.json")
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Return sc
}

ClassMethod CPFData(Filename As %String = "", Output config As %DynamicObject = "") As %Status
{
    ; zw ##class(lscalese.configcopy.RemoteExport).CPFData(,.cfg)
    Set client = ##class(lscalese.configcopy.client.HttpClient).%New()
    Set pRequest = ##class(lscalese.configcopy.client.msg.ExportConfigRequest).%New()
    $$$QuitOnError(client.GETExportConfig(pRequest,.pResponse))
    
    Return:pResponse.httpStatusCode'=200 $$$ERROR(5001, "Return http status code "_pResponse.httpStatusCode)
    
    Set config = {}.%FromJSON(pResponse.body)
    
    Set:Filename'="" sc = ##class(Api.Config.Services.Loader).toFile(config, Filename)
    
    Return sc
}

ClassMethod Tasks(Filename As %String = "", Output TasksStream As %Stream.GlobalBinary) As %Status
{
    ; d ##class(lscalese.configcopy.RemoteExport).Tasks(,.ts)
    Set sc = $$$OK
    Set client = ##class(lscalese.configcopy.client.HttpClient).%New()
    Set pRequest = ##class(lscalese.configcopy.client.msg.ExportTasksRequest).%New()
    $$$QuitOnError(client.GETExportTasks(pRequest,.pResponse))
    
    Return:pResponse.httpStatusCode'=200 $$$ERROR(5001, "Return http status code "_pResponse.httpStatusCode)
    
    Set TasksStream = pResponse.body
    Do TasksStream.Rewind()
    
    Return:Filename="" sc

    Set fbs = ##class(%Stream.FileBinary).%New()
    $$$QuitOnError(fbs.LinkToFile(Filename))
    Do fbs.CopyFrom(pResponse.body)
    $$$QuitOnError(fbs.%Save())
    
    Return sc
}

ClassMethod Security(Filename As %String = "", Output SecurityStream As %Stream.GlobalBinary) As %Status
{
    ; zw ##class(lscalese.configcopy.RemoteExport).Security(,.ss)
    Set sc = $$$OK
    Set client = ##class(lscalese.configcopy.client.HttpClient).%New()
    Set pRequest = ##class(lscalese.configcopy.client.msg.ExportSecurityRequest).%New()
    $$$QuitOnError(client.GETExportSecurity(pRequest,.pResponse))
    
    Return:pResponse.httpStatusCode'=200 $$$ERROR(5001, "Return http status code "_pResponse.httpStatusCode)
    
    Set SecurityStream = pResponse.body
    Do SecurityStream.Rewind()
    
    Return:Filename="" sc

    Set fbs = ##class(%Stream.FileBinary).%New()
    $$$QuitOnError(fbs.LinkToFile(Filename))
    Do fbs.CopyFrom(pResponse.body)
    $$$QuitOnError(fbs.%Save())
    
    Return sc
}

ClassMethod Globals(Filename As %String = "", Output GlobalsStream As %Stream.GlobalBinary) As %Status
{
    ; zw ##class(lscalese.configcopy.RemoteExport).Globals(,.gs)
    Set sc = $$$OK
    Set client = ##class(lscalese.configcopy.client.HttpClient).%New()
    Set pRequest = ##class(lscalese.configcopy.client.msg.getexportsysglobalsRequest).%New()
    $$$QuitOnError(client.GETgetexportsysglobals(pRequest,.pResponse))
    
    Return:pResponse.httpStatusCode'=200 $$$ERROR(5001, "Return http status code "_pResponse.httpStatusCode)
    
    Set GlobalsStream = pResponse.body
    Do GlobalsStream.Rewind()
    
    Return:Filename="" sc

    Set fbs = ##class(%Stream.FileBinary).%New()
    $$$QuitOnError(fbs.LinkToFile(Filename))
    Do fbs.CopyFrom(pResponse.body)
    $$$QuitOnError(fbs.%Save())
    
    Return sc
}

}
