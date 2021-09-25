#!/bin/bash

# configure config-copy

iris session $ISC_PACKAGE_INSTANCENAME -U IRISAPP <<- END
Write !,"Wait 10 seconds ..."
Hang 10
Write !,"Configure remote settings ..."
Do ##class(lscalese.configcopy.Utils).SetRemoteSettings("iris", 52773)
Write !,"Set credential ..."
Do ##class(lscalese.configcopy.Utils).SetCredential("_system","SYS")
Write !,"Import configuration from iris remote"
Set sc = ##class(lscalese.configcopy.ImportFromRemote).All()
Write !,"Status : ",$SYSTEM.Status.GetOneErrorText(sc)
Halt
END
