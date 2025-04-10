# Import Active Directory module
Import-Module ActiveDirectory

# Initialize an array to hold results
$results = @()

# Get all domain controllers
$domainControllers = Get-ADDomainController -Filter *

foreach ($dc in $domainControllers) {
    # Create an object to store results for this DC
    $dcResult = New-Object PSObject -Property @{
        DCName = $dc.HostName
        Connectivity = "Not Tested"
        Advertising = "Not Tested"
        Replications = "Not Tested"
        Services = "Not Tested"
        SystemLog = "Not Tested"
    }

    # Run DCDiag for this DC and capture output
    $dcdiagOutput = dcdiag /s:$dc.HostName /v | Out-String

    # Parse output for relevant tests
    foreach ($line in $dcdiagOutput -split "`n") {
        if ($line -match "Connectivity") {
            $dcResult.Connectivity = if ($line -match "passed test") { "Passed" } else { "Failed" }
        }
        elseif ($line -match "Advertising") {
            $dcResult.Advertising = if ($line -match "passed test") { "Passed" } else { "Failed" }
        }
        elseif ($line -match "Replications") {
            $dcResult.Replications = if ($line -match "passed test") { "Passed" } else { "Failed" }
        }
        elseif ($line -match "Services") {
            $dcResult.Services = if ($line -match "passed test") { "Passed" } else { "Failed" }
        }
        elseif ($line -match "System Log") {
            $dcResult.SystemLog = if ($line -match "passed test") { "Passed" } else { "Failed" }
        }
    }

    # Add result object to results array
    $results += $dcResult
}

# Display results as a formatted table
$results | Format-Table -AutoSize

#URL https://www.alitajran.com/active-directory-health-check-powershell-script/