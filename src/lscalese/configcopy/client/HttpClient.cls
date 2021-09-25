Class lscalese.configcopy.client.HttpClient Extends %RegisteredObject [ ProcedureBlock ]
{

Parameter CREDENTIALID = "config-copy";

/// Export configuration in config-api format : https://github.com/lscalese/iris-config-api .
Method GETExportConfig(pRequest As lscalese.configcopy.client.msg.ExportConfigRequest, Output pResponse As lscalese.configcopy.client.msg.GenericResponse, pHttpRequestIn As %Net.HttpRequest = {..GetRequest(pRequest)}, Output pHttpResponse As %Net.HttpResponse) As %Status
{
	Set sc = $$$OK, pURL = "/csp/lscalese/configcopy/export/config/"
	Set pHttpRequestIn = ..GetRequest(pRequest)
	Set pHttpRequestIn.ContentType = pRequest.consume
	$$$QuitOnError(pHttpRequestIn.Send("GET", pURL))
	Set pHttpResponse=pHttpRequestIn.HttpResponse
	Set pResponse = ##class(lscalese.configcopy.client.msg.GenericResponse).%New()
	Set sc = ..genericProcessResponse(pRequest, pResponse, "GETExportConfig", sc, $Get(pHttpResponse),"")
	Return sc
}

/// Export all security settings in XML format
Method GETExportSecurity(pRequest As lscalese.configcopy.client.msg.ExportSecurityRequest, Output pResponse As lscalese.configcopy.client.msg.GenericResponse, pHttpRequestIn As %Net.HttpRequest = {..GetRequest(pRequest)}, Output pHttpResponse As %Net.HttpResponse) As %Status
{
	Set sc = $$$OK, pURL = "/csp/lscalese/configcopy/export/security/"
	Set pHttpRequestIn = ..GetRequest(pRequest)
	Set pHttpRequestIn.ContentType = pRequest.consume
	$$$QuitOnError(pHttpRequestIn.Send("GET", pURL))
	Set pHttpResponse=pHttpRequestIn.HttpResponse
	Set pResponse = ##class(lscalese.configcopy.client.msg.GenericResponse).%New()
	Set sc = ..genericProcessResponse(pRequest, pResponse, "GETExportSecurity", sc, $Get(pHttpResponse),"")
	Return sc
}

/// Export all users defined tasks in XML format.
Method GETExportTasks(pRequest As lscalese.configcopy.client.msg.ExportTasksRequest, Output pResponse As lscalese.configcopy.client.msg.GenericResponse, pHttpRequestIn As %Net.HttpRequest = {..GetRequest(pRequest)}, Output pHttpResponse As %Net.HttpResponse) As %Status
{
	Set sc = $$$OK, pURL = "/csp/lscalese/configcopy/export/tasks/"
	Set pHttpRequestIn = ..GetRequest(pRequest)
	Set pHttpRequestIn.ContentType = pRequest.consume
	$$$QuitOnError(pHttpRequestIn.Send("GET", pURL))
	Set pHttpResponse=pHttpRequestIn.HttpResponse
	Set pResponse = ##class(lscalese.configcopy.client.msg.GenericResponse).%New()
	Set sc = ..genericProcessResponse(pRequest, pResponse, "GETExportTasks", sc, $Get(pHttpResponse),"")
	Return sc
}

Method GETGetSpec(pRequest As lscalese.configcopy.client.msg.GetSpecRequest, Output pResponse As lscalese.configcopy.client.msg.GenericResponse, pHttpRequestIn As %Net.HttpRequest = {..GetRequest(pRequest)}, Output pHttpResponse As %Net.HttpResponse) As %Status
{
	Set sc = $$$OK, pURL = "/csp/lscalese/configcopy/"
	Set pHttpRequestIn = ..GetRequest(pRequest)
	Set pHttpRequestIn.ContentType = pRequest.consume
	$$$QuitOnError(pHttpRequestIn.Send("GET", pURL))
	Set pHttpResponse=pHttpRequestIn.HttpResponse
	Set pResponse = ##class(lscalese.configcopy.client.msg.GenericResponse).%New()
	Set sc = ..genericProcessResponse(pRequest, pResponse, "GETGetSpec", sc, $Get(pHttpResponse),"")
	Return sc
}

/// Copy the node ^%SYS("sql","ODBCCONNECTION") into ^ExportTmp and export it.
Method GETgetexportsysglobals(pRequest As lscalese.configcopy.client.msg.getexportsysglobalsRequest, Output pResponse As lscalese.configcopy.client.msg.GenericResponse, pHttpRequestIn As %Net.HttpRequest = {..GetRequest(pRequest)}, Output pHttpResponse As %Net.HttpResponse) As %Status
{
	Set sc = $$$OK, pURL = "/csp/lscalese/configcopy/export/sysglobals/"
	Set pHttpRequestIn = ..GetRequest(pRequest)
	Set pHttpRequestIn.ContentType = pRequest.consume
	$$$QuitOnError(pHttpRequestIn.Send("GET", pURL))
	Set pHttpResponse=pHttpRequestIn.HttpResponse
	Set pResponse = ##class(lscalese.configcopy.client.msg.GenericResponse).%New()
	Set sc = ..genericProcessResponse(pRequest, pResponse, "GETgetexportsysglobals", sc, $Get(pHttpResponse),"")
	Return sc
}

Method GetRequest(pRequest As %RegisteredObject) As %Net.HttpRequest
{
	#dim pHttpRequestIn As %Net.HttpRequest = ##class(%Net.HttpRequest).%New()
	Do:##class(%Dictionary.CompiledProperty).%ExistsId(pRequest.%ClassName(1)_"||accept") pHttpRequestIn.SetHeader("accept", pRequest.accept)
	Set pHttpRequestIn.Server = $Get(^configcopy.RemoteExport("server"),"localhost")
	Set pHttpRequestIn.Port = $Get(^configcopy.RemoteExport("port"),52773)
	Set pHttpRequestIn.Https = $Get(^configcopy.RemoteExport("sslconfig"))'=""
	
    If ##class(Ens.Config.Credentials).%ExistsId(..#CREDENTIALID) {
        Set user = ##class(Ens.Config.Credentials).GetValue(..#CREDENTIALID, "Username")
        Set password = ##class(Ens.Config.Credentials).GetValue(..#CREDENTIALID, "Password")
        Do pHttpRequestIn.SetHeader("Authorization","Basic "_$SYSTEM.Encryption.Base64Encode(user_":"_password))
    }

	Return pHttpRequestIn
}

Method genericProcessResponse(pRequest As %RegisteredObject, pResponse As lscalese.configcopy.client.msg.GenericResponse, caller As %String, status As %Status, pHttpResponse As %Net.HttpResponse, parsedResponseClassName As %String) As %Status
{
	Set sc = $$$OK
	Set pResponse.operation = caller
	Set pResponse.operationStatusText = $SYSTEM.Status.GetOneErrorText(status)
	If $Isobject(pHttpResponse) {
		Set pResponse.httpStatusCode = pHttpResponse.StatusCode
		Do pResponse.body.CopyFrom(pHttpResponse.Data)
		Set key = ""
		For  {
			Set key = $Order(pHttpResponse.Headers(key),1 , headerValue)
			Quit:key=""
			Do pResponse.headers.SetAt(headerValue, key)
		}
		Set sc = ##class(lscalese.configcopy.client.HttpClient).processParsedResponse(pHttpResponse, parsedResponseClassName, caller, pRequest, pResponse)
	}
	Return sc
}

ClassMethod processParsedResponse(pHttpResponse As %Net.HttpResponse, responseClass As %String, caller As %String, pRequest As %RegisteredObject, pResponse As lscalese.configcopy.client.msg.GenericResponse) As %Status
{
    Return:responseClass="" $$$OK
    Set parsedResponse = "", sc = $$$OK
    
    If (pHttpResponse.ContentType="application/json") {
        Set httpStatusCode = pHttpResponse.StatusCode
        
        Set parsedResponse = $ClassMethod(responseClass, "%New")
        
        Quit:parsedResponse.%GetParameter(httpStatusCode _ "MODEL")="" sc

        #define zIsList httpStatusCode _ "ISLIST"
        #define zModelType httpStatusCode _ "MODELTYPE"
        #define zModel httpStatusCode _ "MODEL"

        Try {
            If parsedResponse.%GetParameter( $$$zIsList ) {
                Set list = [].%FromJSON(pHttpResponse.Data)
                Set iter = list.%GetIterator()
                While iter.%GetNext(.keyParam, .value) {
                    Set model = $ClassMethod(parsedResponse.%GetParameter( $$$zModelType ), "%New")
                    Do model.%JSONImport(value)
                    Do $Method($Property(parsedResponse, parsedResponse.%GetParameter( $$$zModel )), "Insert", model)
                }
            } Else {
                Set model = $ClassMethod(parsedResponse.%GetParameter( $$$zModelType ), "%New")
                Do model.%JSONImport(pHttpResponse.Data)
                Set $Property(parsedResponse, parsedResponse.%GetParameter( $$$zModel )) = model
            }
            Set pResponse.parsedResponse = parsedResponse
        } Catch(ex) {
            Set sc = ex.AsStatus()
        }
    }

    Return sc
}

ClassMethod SaveCredential(Username As %String, Password As %String) As %Status
{
	; Do ##class(lscalese.configcopy.client.HttpClient).SaveCredential("_system","SYS")
    Return ##class(Ens.Config.Credentials).SetCredential(..#CREDENTIALID, Username, Password, $$$YES)
}

}
