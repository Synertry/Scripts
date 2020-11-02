if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit } #Run as admin in same script

Write-Host "Made for Company 4 Marketing Services"
Write-Host "-------Created by Jonny Somrak------`n`n"


Write-Host "[INFO] Setting the last logged on user"
Write-Host "[INFO] Domain is automatically to C4`n`n"


$domain = 'C4' #set domain
#$domain = Read-Host -Prompt 'Input domain' #input for domain

$user = Read-Host -Prompt 'Input user' #input for user
$fullname = Read-Host -Prompt 'Input full name of employee to display' #input for full name
Write-Output "`n`n"


$domainuser = $domain + '\' + $user

$userSID = (New-Object System.Security.Principal.NTAccount($domainuser)).Translate([System.Security.Principal.SecurityIdentifier]).value

Write-Host "[INFO] Changing LastLoggedOnDisplayName registry key -> " -NoNewline
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v LastLoggedOnDisplayName /t REG_SZ /d $fullname /f

Write-Host "[INFO] Changing LastLoggedOnSAMUser registry key -> " -NoNewline
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v LastLoggedOnSAMUser /t REG_SZ /d $domainuser /f

Write-Host "[INFO] Changing LastLoggedOnUser registry key -> " -NoNewline
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v LastLoggedOnUser /t REG_SZ /d $domainuser /f

Write-Host "[INFO] Changing LastLoggedOnUserSID registry key -> " -NoNewline
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v LastLoggedOnUserSID /t REG_SZ /d $userSID /f

Write-Output "`n`n"
Write-Host "[INFO] Last logged on user set to"  $domainuser "successfully with SID" $userSID
Write-Host "[INFO] Exiting script"
Start-Sleep -s 1.5