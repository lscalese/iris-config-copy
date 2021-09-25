/// Export configuration from the remote instance and import this instance.
Class lscalese.configcopy.ImportFromRemote
{

/// Set sc = ##class(lscalese.configcopy.ImportFromRemote).All()
ClassMethod All() As %Status
{
    Set sc = $$$OK

    Set scO = ..Security()
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)
    
    Set scO = ..Globals()
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Set scO = ..CPFData()
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)

    Set scO = ..Tasks()
    Set:$$$ISERR(scO) sc = $$$ADDSC(sc,scO)
    
    Return sc
}

/// Description
ClassMethod Security() As %Status
{
    Set sc = $$$OK, Filename = ##class(%File).TempFilename()

    Try {
        $$$TOE(sc,##class(lscalese.configcopy.RemoteExport).Security(Filename))
        $$$TOE(sc,##class(lscalese.configcopy.LocalImport).Security(Filename))
    } Catch (ex) {
        Set sc = ex.AsStatus()
    }
    
    Do ##class(%File).Delete(Filename)

    Return sc
}

ClassMethod Globals() As %Status
{
    Set sc = $$$OK, Filename = ##class(%File).TempFilename()

    Try {
        $$$TOE(sc,##class(lscalese.configcopy.RemoteExport).Globals(Filename))
        $$$TOE(sc,##class(lscalese.configcopy.LocalImport).Globals(Filename))
    } Catch (ex) {
        Set sc = ex.AsStatus()
    }
    
    Do ##class(%File).Delete(Filename)

    Return sc
}

/// Description
ClassMethod CPFData() As %Status
{
    Set sc = $$$OK, Filename = ##class(%File).TempFilename()

    Try {
        $$$TOE(sc,##class(lscalese.configcopy.RemoteExport).CPFData(Filename))
        $$$TOE(sc,##class(lscalese.configcopy.LocalImport).CPFData(Filename))
    } Catch (ex) {
        Set sc = ex.AsStatus()
    }
    
    Do ##class(%File).Delete(Filename)

    Return sc
}

ClassMethod Tasks() As %Status
{
    Set sc = $$$OK, Filename = ##class(%File).TempFilename()

    Try {
        $$$TOE(sc,##class(lscalese.configcopy.RemoteExport).Tasks(Filename))
        $$$TOE(sc,##class(lscalese.configcopy.LocalImport).Tasks(Filename))
    } Catch (ex) {
        Set sc = ex.AsStatus()
    }
    
    Do ##class(%File).Delete(Filename)

    Return sc
}

}
