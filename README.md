# CassandraCQLFileImporter

PREREQUISITES

May sure you have done the following

1. Installed Cassandra shell
2. Make sure you have this one non network drive, or at least drive you have permissions to
3. Install Paython. 2.7 is best one to work with Cassandra  shell
4. Make sure you have added Python to Path environment variable
5. Register cassandr Python tools. This can be done by navigating to the folder where you 
   extracted the Cassandra shell files to, for example “C:\apache-cassandra-2.XX\pylib”. 
   We then need to issue the following command in a command line “python setup.py install”.  
   
   After we have done that we should be able use CQLSH from a regular command prompt or a Powershell script




EXAMPLE USAGE :


PS FOLDER WHERE YOU HAVE CQ FILES + DEPLOYMENT SCRIPT>  .\Deploy.ps1 188.10.15.200 -u sacha -p admin -d c:\ExampleDeploymentScript.txt