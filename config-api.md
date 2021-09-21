# config-api cheat sheet

Configuration file is located to [`./iris-config.json`](./iris-config.json)

## Table of content

1. [Users](#Users)
2. [Roles](#Roles)
3. [SQL Privileges](#SQL-Privileges)
4. [SQL Admin Privilege](#SQL-Admin-Privilege)
5. [SSL Configuration](#SSL-Configuration)
6. [Create Database](#Create-Database)
7. [Globals Mapping](#Globals-Mapping)
8. [REST Application](#REST-Application)
9. [SQL Connection](#SQL-Connection)

## Users

```json
"Security.Users": {
    "TheUserName": {
        "Name":"TheUserName",
        "AccountNeverExpires":true,
        "AutheEnabled":0,
        "ChangePassword":false,
        "Comment":"",
        "EmailAddress":"",
        "Enabled":true,
        "ExpirationDate":"",
        "FullName":"Full user name",
        "NameSpace":"${namespace}",
        "PasswordNeverExpires":false,
        "PhoneNumber":"",
        "PhoneProvider":"",
        "Roles":"%DB_${namespace}",
        "Routine":""
    }
}
```

## Roles

```json
"Security.Roles":{
    "MyRoleRW" : {
        "Descripion" : "MyApp SQL Read\\Write Role",
        "Resources" : "%Service_SQL:U",
        "GrantedRoles" : "%SQL"
    },
    "MyRoleRO" : {
        "Descripion" : "MyApp SQL Read Only Role",
        "Resources" : "%Service_SQL:U",
        "GrantedRoles" : "%SQL"
    }
}
```

## SQL Privileges

```json
"Security.SQLPrivileges": [{
    "Grantee": "MyRoleRO",
    "PrivList" : "s",
    "SQLObject" : "1,dc_PackageSample.*"
},{
    "Grantable" : 0,
    "Grantee": "MyAppRoleRW",
    "Grantor" : "_SYSTEM",
    "Namespace" : "${namespace}",
    "PrivList" : "siud",
    "SQLObject" : "1,dc.PackageSample.PersistentClass"
}]
```
`PrivList` is related to Privilege property and must be filled with one or more allowed character in this list : 

* `s` : select
* `i` : insert
* `u` : update
* `d` : delete
* `a` : alter
* `r` : reference

**`SQLObject` structure**  
Start with `#,` where # value is : 

* `1` for a table
* `3` for a view
* `9` for a stored procedure

Then the table\view\stored procedure reference.  
If the reference is a table, you can use the wildcard `*` as trailing character only.  


Default value for not defined properties : 

* `Grantable` : 0
* `Grantor` : _SYSTEM
* `Namespace` : current namespace -> $NAMESPACE 

## SQL Admin Privilege

```json
"Security.SQLAdminPrivilegeSet" : {
    "${namespace}": [{
        "AlterTable":"",
        "AlterView":"",
        "BuildIndex":"",
        "CreateFunction":"",
        "CreateMethod":"",
        "CreateProcedure":"",
        "CreateQuery":"",
        "CreateTable":"",
        "CreateTrigger":"",
        "CreateView":"",
        "DropFunction":"",
        "DropMethod":"",
        "DropProcedure":"",
        "DropQuery":"",
        "DropTable":"",
        "DropTrigger":"",
        "DropView":"",
        "Grantee":"MyAppRoleRW",
        "NoCheck":"",
        "NoIndex":"",
        "NoLock":"",
        "NoTrigger":""
    }]
}
```

## SSL Configuration

With default settings : 

```json
"Security.SSLConfigs": {
    "SSLDefault":{}
}
```

Custom : 
```json
"Security.SSLConfigs": {
    "SSLConfigName":{
        "CAFile":"",
        "CAPath":"",
        "CertificateFile":"",
        "CipherList":"ALL:!aNULL:!eNULL:!EXP:!SSLv2",
        "Ciphersuites":"TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256",
        "Description":"",
        "Enabled":true,
        "PrivateKeyFile":"",
        "PrivateKeyPassword":"",
        "PrivateKeyType":"2",
        "SNIName":"",
        "TLSMaxVersion":"32",
        "TLSMinVersion":"16",
        "Type":"0",
        "VerifyDepth":9,
        "VerifyPeer":0
    }
}
```

## Create Database

```json
"SYS.Databases":{
    "${mgrdir}myappdata" : {"ExpansionSize":64}
},
"Databases":{
    "MYAPPDATA" : {
        "Directory" : "${mgrdir}myappdata"
    }
}
```

## Globals Mapping

```json
"MapGlobals":{
    "${namespace}": [{
        "Name" : "MyApp.*",
        "Database" : "MYAPPDATA"
    }]
}
```

## REST Application

```json
"Security.Applications": {
    "/rest/irisapp": {
        "DispatchClass" : "dispatch.class",
        "Namespace" : "{namespace}",
        "Enabled" : "1",
        "AutheEnabled": "64",
        "CookiePath" : "/rest/irisapp/"
    }
}
```

## SQL Connection

With default parameters : 
```json
"Library.SQLConnection": {
    "SQLConnection1" : {}
}
```

Custom : 

```json
"Library.SQLConnection": {
    "SQLConnection1" : {
        "DSN":"",
        "OnConnectStatement":"",
        "ReverseOJ":false,
        "URL":"",
        "Usr":"",
        "bUnicodeStream":true,
        "bindTSasString":false,
        "classpath":"",
        "driver":"",
        "isJDBC":false,
        "needlongdatalen":false,
        "noconcat":false,
        "nodefq":false,
        "nofnconv":false,
        "nvl":false,
        "properties":"",
        "pwd":"Fj4pLDgGiCxC0HHp2jQZiQ==",
        "useCAST":false,
        "useCASTCHAR":false,
        "useCOALESCE":true,
        "xadriver":""
    }
}

```

## Links

[github project page](https://github.com/lscalese/iris-config-api)

