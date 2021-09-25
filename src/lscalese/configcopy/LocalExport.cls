/// Export configuration of this instance
Class lscalese.configcopy.LocalExport
{

/// d ##class(lscalese.configcopy.LocalExport).All()
ClassMethod All(Directory As %String = { $zu(12,"config-copy-local/")}) As %Status
{
    Set sc = $$$OK
    Set Directory = ##class(%File).NormalizeDirectory(Directory)

    Do:'##class(%File).DirectoryExists(Directory) ##class(%File).CreateDirectoryChain(Directory)

    
    Set scO = ..Security(Directory_"SecurityExport.xml")
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Set scO = ..Tasks(Directory_"TasksExport.xml")
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Set scO = ..Globals(Directory_"GlobalsExport.xml")
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Set scO = $$$OK
    Set config =  ..CPFDataTemplate(.scO, "Default")

    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Return:$$$ISERR(scO) sc
    
    Set scO = ##class(Api.Config.Services.Loader).toFile(config, Directory_"config-api.json")
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Return sc
}

ClassMethod Security(Filename As %String = "SecurityExport.xml") As %Status
{
    New $NAMESPACE
    Set $NAMESPACE = "%SYS"
    Return ##class(Security.System).ExportAll(Filename)
}

ClassMethod Tasks(Filename As %String = "TasksExport.xml") As %Status
{
    Set TaskListId="", id=999 

    For  { 
        Set id = $Order(^["%SYS"]SYS("Task","TaskD",id)) 
        Quit:id=""  
        Set $List(TaskListId,*+1)=id 
    }

    If $LISTLENGTH(TaskListId) = 0 {
        Return $$$OK  ; Nothing to export
    }

    Return ##class(%SYS.TaskSuper).ExportTasks(TaskListId)
}

ClassMethod Globals(Filename As %String = "GlobalsExport.xml") As %Status
{
    ; zw ##class(lscalese.configcopy.Export).ExportGlobals()
    $$$QuitOnError(..GlobalsToStream(.stream))
    
    Do:##class(%File).Exists(Filename) ##class(%File).Delete(Filename)
    Set file = ##class(%Stream.FileBinary).%New()
    $$$QuitOnError(file.LinkToFile(Filename))
    
    Do file.CopyFrom(.stream)
    Quit file.%Save()
}

ClassMethod GlobalsToStream(GblStream As %Stream.GlobalBinary = {##class(%Stream.GlobalBinary).%New()}) As %Status
{
    Lock +^ExportTmp
    Kill ^ExportTmp
    Try {
        Merge ^ExportTmp($Name(^%SYS("sql","ODBCCONNECTION"))) = ^%SYS("sql","ODBCCONNECTION")
        Set sc = $SYSTEM.OBJ.ExportToStream("ExportTmp.GBL", .GblStream, "-d")
    } Catch(ex) {
        Set sc = ex.AsStatus()
    }
    Lock -^ExportTmp
    Return sc
}

ClassMethod CPFDataTemplate(ByRef sc As %Status, TemplateName As %String, ToFile As %String = "", IncludeSystem As %Boolean = {$$$NO}) As %DynamicObject
{
    Set Filter = ##class(lscalese.configcopy.ExportFilterTemplate).Get(TemplateName)
    Return ..CPFData(.sc, Filter, ToFile, IncludeSystem)
}

/// Export CPF Section using config-api tools.
ClassMethod CPFData(ByRef sc As %Status = {$$$OK}, Filter As %DynamicObject, ToFile As %String = "", IncludeSystem As %Boolean = {$$$NO}) As %DynamicObject
{
    #dim config As %DynamicObject = {}
    
    Try {
        Set config = ##class(Api.Config.Services.Loader).export(Filter, $$$YES, ToFile)
    } Catch (ex) {
        Set sc = ex.AsStatus()
    }

    Return:$$$ISERR(sc) ""

    Return:IncludeSystem config

    If $Isobject(config.Namespaces) {

        Set excludeNS("%SYS")=""
        Set excludeNS("HSLIB")=""
        Set excludeNS("HSSYS")=""
        Set excludeNS("DOCBOOK")=""
        Set excludeNS("ENSEMBLE")=""
        Set excludeNS("ENSDEMO")=""
        Set excludeNS("HSCUSTOM")=""
        
        Set ns = ""
        For  {
            
            Set ns = $Order(excludeNS(ns))
            Quit:ns=""

            Do config.Namespaces.%Remove(ns)
        }

    }

    Return:'$Isobject(config.Databases) config

    Set excludeDB("IRISSYS")=""
    Set excludeDB("IRISLIB")=""
    Set excludeDB("IRISTEMP")=""
    Set excludeDB("IRISLOCALDATA")=""
    Set excludeDB("IRISAUDIT")=""
    Set excludeDB("ENSLIB")=""
    Set excludeDB("ENSDEMO")=""
    Set excludeDB("ENSEMBLE")=""
    Set excludeDB("HSCUSTOM")=""
    Set excludeDB("HSSYS")=""
    Set excludeDB("HSLIB")=""
    Set excludeDB("USER")=""
    Set excludeDB("CACHESYS")=""
    Set excludeDB("CACHELIB")=""
    Set excludeDB("CACHETEMP")=""
    Set excludeDB("CACHEAUDIT")=""
    Set excludeDB("CACHE")=""
    Set excludeDB("USER")=""
    
    Set db = ""

    For  {
        Set db = $Order(excludeDB(db))
        Quit:db=""
        
        Set dbObj = config.Databases.%Get(db)
        
        Continue:'$Isobject(dbObj)
        
        If $Isobject(config."SYS.Databases"), dbObj.Directory'="" {
            Do config."SYS.Databases".%Remove(dbObj.Directory)
        }
        
        Do config.Databases.%Remove(db)
    }

    Return config
}

}
