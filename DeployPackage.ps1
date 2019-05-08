param ([Parameter()]$password)

Install-PackageProvider -Name NuGet -Force -Scope "CurrentUser"
Install-Module SharePointPnPPowerShellOnline -Scope "CurrentUser" -Verbose -Force

if ($env:environment -eq "production") {
    $siteUrl = $env:productionSiteUrl
}
else {
    $siteUrl = $env:testSiteUrl
}

Write-Host "SiteUrl - " $siteUrl

$sp = $password | ConvertTo-SecureString -AsPlainText -Force
$plainCred = New-Object system.management.automation.pscredential -ArgumentList $env:username, $sp

Connect-PnPOnline -Url $siteUrl -Credentials $plainCred

$packagePath =  "./" + $env:dropPath + "/drop/sharepoint/solution/" + $env:packageName
Add-PnPApp $packagePath -Scope Site -Overwrite -Publish