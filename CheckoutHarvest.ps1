param(
	[parameter(Mandatory=$true)][string]$install_directory="", 
	[parameter(Mandatory=$true)][string]$name_broker="", 
	[parameter(Mandatory=$true)][string]$name_project="", 
    [parameter(Mandatory=$true)][string]$name_state="", 
    [parameter(Mandatory=$true)][string]$path_view="", 
    [parameter(Mandatory=$true)][string]$path_client_default="", 
    [parameter(Mandatory=$true)][string]$username="",
    [parameter(Mandatory=$true)][string]$password="" 
)

# Full path of hco.exe 
$path_hco = -join($install_directory, "\hco.exe")

# Construct a string, including all mandatory values for establishing a connection 
$arguments = -join("-b ", "`"$name_broker`"", " -en ", "`"$name_project`"", " -st ", "`"$name_state`"", " -vp ", "`"$path_view`"", " -br -op pc -o checkout.log -s *.* -dcp ", "`"$path_client_default`"", " -usr ", "`"$username`"", " -pw ", "`"$password`"")

# Checkout from Harvest
try {
    Start-Process -Wait -FilePath $path_hco -WorkingDirectory $install_directory -ArgumentList $arguments
}
catch { "Checkout couldn't be finished due to an error!" }

Write-Host "Done!"