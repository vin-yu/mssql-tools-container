Examples of how you can use the mssql-tools container

## Build the container and down load this cont
`docker build -t mssql-tools .`

Download this example repo and map it when you start the tools container to walk through these examples.

## Create a sample database with .bacpac file
`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools sqlpackage /SourceFile:"/examples/demo.bacpac" /Action:Import /TargetServerName:"InstanceName" /TargetDatabaseName:"School" /TargetPassword:"LoginPassword" /TargetUser:"sa"`

## use mssql-cli to browse your database
`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools mssql-cli -Usa -SInstanceName -P LoginPassword`

## apply .sql files to your database
`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools sqlcmd -Usa -SInstanceName -P LoginPassword -d School -i /examples/bookTable.sql`

## create a dacpac 
`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools sqlpackage /TargetFile:"/examples/demo.dacpac" /Action:Extract /SourceServerName:"InstanceName" /SourceDatabaseName:"School" /SourcePassword:"LoginPassword" /SourceUser:"sa"`

## Run a sql command
`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools sqlcmd -Usa -SInstanceName -P LoginPassword -d School -Q "select name from sys.tables"`

`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools sqlcmd -Usa -SInstanceName -P LoginPassword -d School -Q "Drop Table Books"`

`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools sqlcmd -Usa -SInstanceName -P LoginPassword -d School -Q "select name from sys.tables"`

## apply a dacpac/ Deploy a Data-tier Application
`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools sqlpackage /SourceFile:"/examples/demo.dacpac" /Action:Publish /TargetServerName:"InstanceName" /TargetDatabaseName:"School" /TargetPassword:"LoginPassword" /TargetUser:"sa"`

`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools sqlcmd -Usa -SInstanceName -PLoginPassword -d School -Q "select name from sys.tables"`

## use mssql-scripter to get the schema of the database
`docker run -v mssql-tools-container/examples/scripts:/examples -it mssql-tools mssql-scripter -Usa -SInstanceName -P LoginPassword -d School --include-objects books`

