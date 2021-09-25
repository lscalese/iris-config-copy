/// Description
Class lscalese.configcopy.Utils
{

/// Do ##class(lscalese.configcopy.Utils).Install("localhost",52773)
ClassMethod Install(RemoteHost As %String = "localhost", RemotePort As %Integer = 52773, SSLConfig As %String = "") As %Status
{
    Do ..SetCredential(,,$$$NO)
    Do ..SetRemoteSettings(RemoteHost, RemotePort, SSLConfig)
    Return ..SetWebApp()
}

/// Do ##class(lscalese.configcopy.Utils).SetRemoteSettings("localhost",52773)
ClassMethod SetRemoteSettings(RemoteHost As %String = "localhost", RemotePort As %Integer = 52773, SSLConfig As %String = "") As %Status
{
    Set ^configcopy.RemoteExport("server") = RemoteHost
	Set ^configcopy.RemoteExport("port") = RemotePort
	Set ^configcopy.RemoteExport("sslconfig") = SSLConfig
    Return $$$OK
}

ClassMethod SetCredential(Username As %String = "_system", Password As %String = "SYS", Override As %Boolean = {$$$YES}) As %Status
{
    Do:'##class(%Library.EnsembleMgr).IsEnsembleNamespace($NAMESPACE) ##class(%Library.EnsembleMgr).EnableNamespace($NAMESPACE)
    Set credentialId = ##class(lscalese.configcopy.client.HttpClient).%GetParameter("CREDENTIALID")
    Return ##class(Ens.Config.Credentials).SetCredential(credentialId, Username, Password, Override)
}

ClassMethod SetWebApp() As %Status
{
    Set params("DispatchClass") = $Select($$$LOWER($ZVersion)["iris":"lscalese.configcopy.rest.disp",1:"lscalese.configcopy.rest.hsdisp")
    ;Set params("DispatchClass")="lscalese.configcopy.rest.hsdisp"

    Set config = {
        "Security.Applications":{
            "/csp/lscalese/configcopy":{
                "AutheEnabled":"32",
                "CookiePath":"/csp/lscalese/configcopy/",
                "DispatchClass":"${DispatchClass}",
                "Name":"/csp/lscalese/configcopy",
                "NameSpace":"${NAMESPACE}"
            }
        }
    }
    
    Return ##class(Api.Config.Services.Loader).Load(config, .params)
}

/// Do ##class(lscalese.configcopy.Utils).buildXmlRelease()
ClassMethod buildXmlRelease(filename As %String = "/irisrun/repo/dist/config-copy_for_IRIS.xml") As %Status
{
    Do:##class(%File).Exists(filename) ##class(%File).Delete(filename)
    Set items = ""
    Set items("Api.Config.inc.INC")=""
    Set items("IORedirect.INC")=""
    Set items("Api.Config.*.CLS")=""
    Set items("IORedirect.*.CLS")=""
    Set items("lscalese.configcopy.*.CLS")=""
    Quit $SYSTEM.OBJ.Export(.items,filename)
}

/// Do ##class(lscalese.configcopy.Utils).buildHSXmlRelease()
ClassMethod buildHSXmlRelease(filename As %String = "/irisrun/repo/dist/config-copy_for_HealthShare.xml") As %Status
{
    Set sc = $$$OK

    Do:##class(%File).Exists(filename) ##class(%File).Delete(filename)
    Set items = ""
    Set items("Api.Config.inc.INC")=""
    Set items("IORedirect.INC")=""
    Set items("Api.Config.*.CLS")=""
    Set items("IORedirect.*.CLS")=""
    Set items("lscalese.configcopy.*.CLS")=""

    Set items("'lscalese.configcopy.rest.disp.CLS")=""
    Set items("'lscalese.configcopy.rest.impl.CLS")=""
    Set items("'lscalese.configcopy.rest.spec.CLS")=""
    Set items("'Api.Config.Services.Security.SQLPrivileges.CLS")=""
    Set items("'Api.Config.REST.disp.CLS")=""
    Set items("'Api.Config.REST.impl.CLS")=""
    Set items("'Api.Config.REST.spec.CLS")=""
    
    If $$$LOWER($ZVersion) [ "iris" {
        
        $$$QuitOnError($SYSTEM.OBJ.ExportToStream(.items, .stream))
        Do stream.Rewind()
        
        Set fc = ##class(%Stream.FileCharacter).%New()
        $$$QuitOnError(fc.LinkToFile(filename))

        Do fc.WriteLine(stream.ReadLine())
        Do stream.ReadLine()

        Set exportLine = "<Export generator=""Cache"" version=""25"" zv=""Cache for Windows (x86-64) 2012.2.3 (Build 903U)"" ts="""_$zdt($h,3,1)_""">"
        Do fc.WriteLine(exportLine)

        While 'stream.AtEnd {
            Do fc.WriteLine(stream.ReadLine())
        }
        Set sc = fc.%Save()
        kill fc

    } Else {
        Set sc = $SYSTEM.OBJ.Export(.items, filename)
    }

    Return sc
}

}
