<#


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


#>


[CmdletBinding()]
Param (
    
    [Parameter(Position=1)]
    [string]
    $hostAddress = "188.10.15.200",
    
    [Alias("u")] 
    [string]
    $username,
    
    [Alias("p")] 
    [string]
    $password, 
    
    [Alias("d")] 
    [string]
    $deploymentFile = ''
)


$global:paramsAllValid = $true


Function FetchCqlFileNamesFromInputFile() {

    If (Test-Path $deploymentFile) {
        Write-Host "Found deployment file : $deploymentFile"
        $cqlItems = [IO.File]::ReadAllLines($deploymentFile)
        return ,$cqlItems
    }
    else {
        Write-Host "Error : Couldn't find deployment file : $deploymentFile"
        throw [System.IO.FileNotFoundException] "Function FetchCqlFileNamesFromInputFile() : $deploymentFile not found."
    }
}


Function RunCql() {
    Process {
        $cqlsh = 'cqlsh'
        Write-Host "Running following CQL file : $($_.Name), against Cassandra host address : $($hostAddress)"
        & $cqlsh $hostAddress -u $username -p $password -f $_.Name
    }
}



Function CheckParams() {
    Process {
        # validate hostAddress
        if($hostAddress -eq [String]::Empty) {
            PrintErrorMessageForParameter 'hostAddress'
        }

        # validate username
        if($username -eq [String]::Empty) {
            PrintErrorMessageForParameter 'username'
        }
        
        # validate password
        if($password -eq [String]::Empty) {
            PrintErrorMessageForParameter 'password'
        }
        
        # validate deploymentFile
        if($deploymentFile -eq [String]::Empty) {
            PrintErrorMessageForParameter 'deploymentFile'
        }
    }
}


Function PrintErrorMessageForParameter($paramValue) {
    Write-Host "Error : Expected input parameter '$($paramValue)' was not supplied"
    PrintUsage
    $global:paramsAllValid = $false
}


Function PrintUsage() {
    Process {
        Write-Host "Example usage should be : .\Deploy.ps1 188.10.15.200 -u sacha -p admin -d c:\ExampleDeploymentScript.txt" ([Environment]::NewLine)
    }
}


Try {
    CheckParams
    if ($global:paramsAllValid) {
        Write-Host "Parameters all supplied ok, proceeding to check input file and run CQL files"
        Get-ChildItem (FetchCqlFileNamesFromInputFile) | RunCql

    }
    else {
        Write-Host "Not proceeding as there was problems with some of the expected parameters"
    }
}
Catch {
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    Write-Host "Exception : The error message was $ErrorMessage"
    Break
}






