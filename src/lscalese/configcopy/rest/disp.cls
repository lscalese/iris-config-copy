/// Dispatch class defined by RESTSpec in lscalese.configcopy.rest.spec
Class lscalese.configcopy.rest.disp Extends %CSP.REST [ GeneratedBy = lscalese.configcopy.rest.spec.cls, ProcedureBlock ]
{

/// The class containing the RESTSpec which generated this class
Parameter SpecificationClass = "lscalese.configcopy.rest.spec";

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 1;

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

/// Swagger 2.0 specification
ClassMethod GetSpec() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(lscalese.configcopy.rest.impl).GetSpec()
        Do ##class(lscalese.configcopy.rest.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("lscalese.configcopy.rest.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod ExportSysglobals() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/xml")
        If '##class(%REST.Impl).%CheckAccepts("application/xml") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(lscalese.configcopy.rest.impl).ExportSysglobals()
        Do ##class(lscalese.configcopy.rest.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("lscalese.configcopy.rest.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod ExportConfig() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(lscalese.configcopy.rest.impl).ExportConfig()
        Do ##class(lscalese.configcopy.rest.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("lscalese.configcopy.rest.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod ExportTasks() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/xml")
        If '##class(%REST.Impl).%CheckAccepts("application/xml") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(lscalese.configcopy.rest.impl).ExportTasks()
        Do ##class(lscalese.configcopy.rest.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("lscalese.configcopy.rest.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

ClassMethod ExportSecurity() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/xml")
        If '##class(%REST.Impl).%CheckAccepts("application/xml") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(lscalese.configcopy.rest.impl).ExportSecurity()
        Do ##class(lscalese.configcopy.rest.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("lscalese.configcopy.rest.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

}
