Install-Module -Name "PnP.PowerShell" -AllowPrerelease -Force

if ($env:environment -eq "production") {
    $siteUrl = $env:productionSiteUrl
}
else {
    $siteUrl = $env:testSiteUrl
}

Write-Host "SiteUrl - " $siteUrl

$certificatePath = "./" + $env:dropPath + "/drop/" + $env:certificateFilename
Connect-PnPOnline -url $siteUrl -clientId $env:clientId -Tenant $env:tenant -CertificatePath $certificatePath 

$packagePath = "./" + $env:dropPath + "/drop/" + $env:solutionPath + "/sharepoint/solution/" + $env:packageName
Add-PnPApp $packagePath -Overwrite -Publish