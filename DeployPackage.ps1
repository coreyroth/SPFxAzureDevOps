[CmdletBinding()]
param ([Parameter(Mandatory)][SecureString]$username, [Parameter()][SecureString]$password)

if ($password) { Write-Host "Password stored." }
if (!$password) { Write-Host "Password not stored." } 

Write-Host "Username - " $username
Write-Host "Password - " $password

Install-PackageProvider -Name NuGet -Force -Scope "CurrentUser"
Install-Module SharePointPnPPowerShellOnline -Scope "CurrentUser" -Verbose -Force

# $sp = $password | ConvertTo-SecureString -AsPlainText -Force
$sp = $password
$plainCred = New-Object system.management.automation.pscredential -ArgumentList $username, $sp

Connect-PnPOnline -Url $env:siteUrl -Credentials $plainCred

$packagePath =  "./" + $env:dropPath + "/drop/sharepoint/solution" + $env:packageName
Add-PnPApp $packagePath -Scope Site -Overwrite -Publish