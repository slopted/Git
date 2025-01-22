 # Import Active Directory module if not already imported
 Import-Module ActiveDirectory

 # Define input and output CSV files
 $inputCsv = "C:\Temp\input.csv"
 $outputCsv = "C:\Temp\output.csv"
 
 # Read input CSV file
 $userList = Import-Csv -Path $inputCsv
 
 # Initialize an array to hold user data
 $userData = @()
 
 # Loop through each display name in the input list
 foreach ($user in $userList) {
     # Search for user in Active Directory by display name
     $adUser = Get-ADUser -Filter { DisplayName -eq $user.displayName } -Properties userPrincipalName, displayName, surname, mail, givenName, objectId, userType, jobTitle, department
    
     # Check if user was found
     if ($adUser) {
         # Create a custom object with desired properties
         $userData += [PSCustomObject]@{
             userPrincipalName = $adUser.userPrincipalName
             displayName       = $adUser.displayName
             surname           = $adUser.surname
             mail              = $adUser.mail
             givenName         = $adUser.givenName
             objectId          = $adUser.objectId.ToString()  # Convert to string for consistency in output format.
             userType          = $adUser.userType
             jobTitle          = $adUser.jobTitle
             department        = $adUser.department
         }
     } else {
         Write-Host "User not found: $($user.displayName)"
     }
 }
 
 # Export collected data to output CSV file
 $userData | Export-Csv -Path $outputCsv -NoTypeInformation
 
 Write-Host "Export completed. Data saved to: $outputCsv"