Write-Host "Start.ps1 script started...`n"

if($env:mount_letter) {
	$mount_letter = $env:mount_letter
}
else {
	Write-Host("Provide value for: mount_letter")
}
if($env:azure_storage) {
	$azure_storage = $env:azure_storage
}
else {
	Write-Host("Provide value for: azure_storage")
}
if($env:azure_fileshare_name) {
	$azure_fileshare_name = $env:azure_fileshare_name
}
else {
	Write-Host("Provide value for: azure_fileshare_name")
}
if($env:user) {
	$user = $env:user
}
else {
	Write-Host("Provide value for: user") 
}
if($env:password) {
	$password = $env:password
}
else {
	Write-Host("Provide value for: password")
}

# Try to read the hostname
$hostname = "mycontainer"
try {
	$hostname = [System.Net.Dns]::GetHostName()
}
catch {
	Write-Host "Hostname could not be read!"
}

$azure_storage_root = -join("\\", $azure_storage, "\", $azure_fileshare_name)
$share_file_path = -join($mount_letter, ":\", $hostname, "_file.txt")

# Print User Input
Write-Host("------------ Following data/arguments will be used ---------------")
Write-Host("Mount Letter: $mount_letter")
Write-Host("Mount Letter: $azure_storage")
Write-Host("Mount Letter: $azure_fileshare_name")
Write-Host("Mount Letter: $azure_storage_root")
Write-Host("Mount Letter: $share_file_path")
Write-Host("Mount Letter: $user")
Write-Host("------------------------------------------------------------------")

# Establish connection to File Share "patricksfileshare"
$connectTestResult = Test-NetConnection -ComputerName $azure_storage -Port 445

if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"$azure_storage`" /user:`"$user`" /pass:`"$password`""
    # Mount the drive
    New-PSDrive -Name $mount_letter -PSProvider FileSystem -Root "$azure_storage_root" -Persist

    New-Item -Path "$share_file_path" -ItemType "file" -Value "This is an example text for the file inside the share."

} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}
