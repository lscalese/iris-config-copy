#!/bin/bash

# configure the config-copy web application and load a configuration in order to test the copy from another instance.

iris session $ISC_PACKAGE_INSTANCENAME -U IRISAPP <<- END
Do ##class(lscalese.configcopy.Utils).SetWebApp()
Do ##class(Api.Config.Services.Loader).Load("/opt/samples/iris-config.json")
Halt
END
