# iris-config-copy

This a tools to export configuration from an Interystems IRIS instance and import it to another.  



# How it works

Config-copy must be installed on the source and the target instance.  
The target instance perform REST request to get the config from the source instance.  


## Installation and configuration

## Source instance

```
zpm "install config-copy"
```

Non ZPM users should import and compile [config-copy_for_IRIS.xml](https://github.com/lscalese/iris-config-copy/blob/master/dist/config-copy_for_IRIS.xml) or [config-copy_for_HealthShare.xml](https://github.com/lscalese/iris-config-copy/blob/master/dist/config-copy_for_HealthShare.xml) if you use HealthShare and not IRIS yet.

On the source instance we need to create a web application used by the target instance to retrieve the configuration.

```
Do ##class(lscalese.configcopy.Utils).SetWebApp()
```

The web application `/csp/lscalese/configcopy` is now added.

## Target instance

Install config-api on a Ensemble enabled namespace.  (To enable Ensemble use : `Do ##class(%EnsembleMgr).EnableNamespace($namespace)` )  

```
zpm "install config-copy"
```

Non ZPM users should import and compile [config-copy_for_IRIS.xml](https://github.com/lscalese/iris-config-copy/blob/master/dist/config-copy_for_IRIS.xml) or [config-copy_for_HealthShare.xml](https://github.com/lscalese/iris-config-copy/blob/master/dist/config-copy_for_HealthShare.xml) if you use HealthShare and not IRIS yet.  

We must setup ip address (or hostname), port, SSConfig (in case of https usage) and credential to access to the source instance.

```Objectscript
Do ##class(lscalese.configcopy.Utils).SetRemoteSettings(<source hostname>, <port>, <sslconfig>)
Do ##class(lscalese.configcopy.Utils).SetCredential("_system","SYS")
```

# Samples

## Export configuration from the source instance and import to local instance

Export configuration from the remote instance (source) and import to this local instance (target).  

```Objectscript
Set sc = ##class(lscalese.configcopy.ImportFromRemote).All()
```
  
## Export configuration from the local instance to a directory

```Objectscript
Set sc = ##class(lscalese.configcopy.LocalExport).All($zu(12,"config-copy-local"))
```

## Export remote instance configuration to a local directory

```Objectscript
Set sc = ##class(lscalese.configcopy.RemoteExport).All($zu(12,"config-copy-remote"))
```


### Import configuration from local files.

Adapt the following examples with the path of each configuration files.  

Import security   

```Objectscript
Set sc = ##class(lscalese.configcopy.LocalImport).Security("SecurityExport.xml")
```

Import globals contain SQL Connections  
```Objectscript
Set sc = ##class(lscalese.configcopy.LocalImport).Globals("GlobalsExport.xml")
```

Import CPF configuration data  
```Objectscript
Set sc = ##class(lscalese.configcopy.LocalImport).CPFData("config-api.json")
```

Import Tasks  
```Objectscript
Set sc = ##class(lscalese.configcopy.LocalImport).Tasks("TasksExport.xml")
```
