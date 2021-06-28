
Write-Host "Start.ps1 script started...`n"

$operatingSystemInfo = $null
$httpRequest = $null
$httpStatus = $null

$operatingSystemInfo = Get-ComputerInfo | select windowsversion

Write-Host "Running at Windows Version: $operatingSystemInfo `n"

Write-Host "Going to request patrickkoch.dev...`n"



try {
$httpRequest = [System.Net.WebRequest]::Create('https://www.patrickkoch.dev/')

$httpStatus = [int]$httpRequest.GetResponse().StatusCode
}
catch {
    Write-Host "HTTP connection couldn't be established"
}

if($httpStatus -eq "200") {
    Write-Host "patrickkoch.dev could be reached!"
}

if(!($httpRequest.GetResponse() -eq $null)) {
    Write-Host "Going to close the http connection!"
    $httpRequest.GetResponse().Close()
}

