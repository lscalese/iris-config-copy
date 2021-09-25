/// This is an implementation of lscalese.configcopy.rest.disp especially for HealthShare
/// %REST is not available on HealthShare we need a special implementation HealthShare support.
Class lscalese.configcopy.rest.hsdisp Extends %CSP.REST
{

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

/// The default response charset is utf-8
Parameter CHARSET = "utf-8";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <!-- Swagger 2.0 specification -->
  <Route Url="/" Method="get" Call="GetSpec" />
  <Route Url="/export/sysglobals/" Method="get" Call="ExportSysglobals" />
  <Route Url="/export/config/" Method="get" Call="ExportConfig" />
  <Route Url="/export/tasks/" Method="get" Call="ExportTasks" />
  <Route Url="/export/security/" Method="get" Call="ExportSecurity" />
</Routes>
}

ClassMethod GetSpec() As %Status
{
    Write {"msg":"Only available with IRIS"}.%ToJSON()
    Quit $$$OK
}

ClassMethod ExportSysglobals() As %Status
{
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

    Do cs.OutputToDevice()

    Return $$$OK
}

/// Export configuration in config-api format : https://github.com/lscalese/iris-config-api .
ClassMethod ExportConfig() As %Status
{
    Set sc = $$$OK, restore = $$$NO
    Try {
        Do ##class(IORedirect.Redirect).ToString()
        Set restore = $$$YES
        Set config = ##class(lscalese.configcopy.LocalExport).CPFDataTemplate(.sc, "Default")
    } Catch (ex) {
         Set sc = ex.AsStatus()
    }
    If restore {
        Do ##class(IORedirect.Redirect).RestoreIO()
        Do ##class(IORedirect.Redirect).ClearConfig()
    }
    If $$$ISERR(sc) {
        $$$ThrowStatus(sc)
    }
    Write config.%ToJSON()

    Return $$$OK
}

/// Export all users defined tasks in XML format.
ClassMethod ExportTasks() As %Status
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

    Do cs.OutputToDevice()

    Return $$$OK
}

/// Export all security settings in XML format
ClassMethod ExportSecurity() As %Status
{
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

    Do cs.OutputToDevice()

    Return $$$OK
}

}
