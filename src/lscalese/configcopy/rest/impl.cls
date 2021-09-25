/// Business logic class defined by OpenAPI in lscalese.configcopy.rest.spec<br/>
/// Updated Sep 24, 2021 14:11:29
Class lscalese.configcopy.rest.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 0;

/// Swagger 2.0 specification
ClassMethod GetSpec() As %DynamicObject
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
    Return {}.%FromJSON(##class(%Dictionary.CompiledXData).%OpenId("lscalese.configcopy.rest.spec||OpenAPI").Data)
}

/// Copy the node ^%SYS("sql","ODBCCONNECTION") into ^ExportTmp and export it.
ClassMethod ExportSysglobals() As %Stream.Object
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object

    Set sc = $$$OK
    Set Filename = ##class(%File).TempFilename()
    Set sc = ##class(lscalese.configcopy.LocalExport).Globals(Filename)
    
    If $$$ISERR(sc) {
        Do:##class(%File).Exists(Filename) ##class(%File).Delete(Filename)
        $$$ThrowStatus(sc)
    }

    Set fcs = ##class(%Stream.FileCharacter).%New()
    Set sc = fcs.LinkToFile(Filename)
    If $$$ISERR(sc) $$$ThrowStatus(sc)
    #dim cs As %Stream.GlobalCharacter = ##class(%Stream.GlobalCharacter).%New()
    Do cs.CopyFrom(fcs)

    Do ##class(%File).Delete(Filename)

    Return cs
}

/// Export configuration in config-api format : https://github.com/lscalese/iris-config-api .
ClassMethod ExportConfig() As %DynamicObject
{
    Set sc = $$$OK
    Set config = ##class(lscalese.configcopy.LocalExport).CPFDataTemplate(.sc, "Default")
    
    If $$$ISERR(sc) {
        $$$ThrowStatus(sc)
    }

    Return config
}

/// Export all users defined tasks in XML format.
ClassMethod ExportTasks() As %Stream.Object
{
    Set sc = $$$OK
    Set Filename = ##class(%File).TempFilename()
    Set sc = ##class(lscalese.configcopy.LocalExport).Tasks(Filename)
    
    If $$$ISERR(sc) {
        Do:##class(%File).Exists(Filename) ##class(%File).Delete(Filename)
        $$$ThrowStatus(sc)
    }

    Set fcs = ##class(%Stream.FileCharacter).%New()
    Set sc = fcs.LinkToFile(Filename)
    If $$$ISERR(sc) $$$ThrowStatus(sc)
    #dim cs As %Stream.GlobalCharacter = ##class(%Stream.GlobalCharacter).%New()
    Do cs.CopyFrom(fcs)

    Do ##class(%File).Delete(Filename)

    Return cs
}

/// Export all security settings in XML format
ClassMethod ExportSecurity() As %Stream.Object
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object

    Set sc = $$$OK
    Set Filename = ##class(%File).TempFilename()
    Set sc = ##class(lscalese.configcopy.LocalExport).Security(Filename)
    
    If $$$ISERR(sc) {
        Do:##class(%File).Exists(Filename) ##class(%File).Delete(Filename)
        $$$ThrowStatus(sc)
    }

    Set fcs = ##class(%Stream.FileCharacter).%New()
    Set sc = fcs.LinkToFile(Filename)
    If $$$ISERR(sc) $$$ThrowStatus(sc)
    #dim cs As %Stream.GlobalCharacter = ##class(%Stream.GlobalCharacter).%New()
    Do cs.CopyFrom(fcs)

    Do ##class(%File).Delete(Filename)

    Return cs
}

}
