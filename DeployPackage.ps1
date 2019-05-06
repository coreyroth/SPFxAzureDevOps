[CmdletBinding()]
param ([Parameter(Mandatory)][SecureString]$username, [Parameter()][String]$password)

Write-Host "Username - " $username
Write-Host "Password - " $password

Install-PackageProvider -Name NuGet -Force -Scope "CurrentUser"
Install-Module SharePointPnPPowerShellOnline -Scope "CurrentUser" -Verbose -Force

$sp = $env:password | ConvertTo-SecureString -AsPlainText -Force
$plainCred = New-Object system.management.automation.pscredential -ArgumentList $env:username, $sp

Connect-PnPOnline -Url $env:siteUrl -Credentials $plainCred

$packagePath =  "./" + $env:dropPath + "/drop/sharepoint/solution" + $env:packageName
Add-PnPApp $packagePath -Scope Site -Overwrite -Publish