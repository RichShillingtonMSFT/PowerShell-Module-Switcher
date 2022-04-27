# PowerShell-Module-Switcher
Utility to help managed conflicting PowerShell Modules for Azure, Azure Stack Hub and Azure Stack Edge

If you manage Azure, Azure Stack Hub and Azure Stack Edge, you probably run in to module conflicts due API differences.
This is how I manage all of these without removing modules and manually making changes to module paths.

## How to set it up

Run the following in an elevated PowerShell window to setup your environment.

```
# URI of the Edge Diagnostics Zip
$DownloadURI = 'https://github.com/RichShillingtonMSFT/PowerShell-Module-Switcher/archive/refs/heads/main.zip'

# Download the ZIP file
Invoke-WebRequest -Uri $DownloadURI -UseBasicParsing -OutFile "$env:TEMP\PowerShell-Module-Switcher.zip"

$Directories = @(
"$env:USERPROFILE\Documents\PowerShellFunctions"
'C:\PowerShellModules'
)

foreach ($Directory in $Directories)
{
    # Check for the log directory and create it if it does not exist
    $PathTest = Test-Path $Directory
    if (!($PathTest))
    {
        New-Item -Path $Directory -ItemType Directory
    } 
}

# Expand the ZIP file that was downloaded
Expand-Archive "$env:TEMP\PowerShell-Module-Switcher.zip" -DestinationPath "$env:TEMP" -Force

# Unblock each file that was extracted
$Items = Get-ChildItem "$env:TEMP\PowerShell-Module-Switcher-main" -Recurse -Verbose
foreach ($Item in $Items)
{
    Unblock-File -Path $Item.FullName -Verbose
}

# Copy all the files to the Kusto Path
Copy-Item -Path "$env:TEMP\PowerShell-Module-Switcher-main\Load-PSModules.ps1" -Destination "$env:USERPROFILE\Documents\PowerShellFunctions" -Recurse -Verbose -Force
Copy-Item -Path "$env:TEMP\PowerShell-Module-Switcher-main\profile.ps1" -Destination "$Env:SystemRoot\System32\WindowsPowerShell\v1.0" -Recurse -Verbose -Force

# Extract PowerShell Modules
$ModuleFiles = @(
'ASE-Az.zip',
'Az.zip',
'AzureRM.zip',
'Hub-Az.zip',
'Hub-AzureRM.zip'
)

foreach ($ModuleFile in $ModuleFiles)
{
    Expand-Archive "$env:TEMP\PowerShell-Module-Switcher-main\Modules\$($ModuleFile.FileName)" -DestinationPath "C:\PowerShellModules" -Force
}

# Clean up the download and temp files
Remove-Item  -Path "$env:TEMP\PowerShell-Module-Switcher-main" -Force -Recurse
Remove-Item -Path "$env:TEMP\PowerShell-Module-Switcher.zip" -Force

Exit
#
```
The above code performs the following:

1. Create a folder called PowerShellFunctions in your Documents folder and copy Load-PSModules.ps1 to it.
2. Copy profile.ps1 to C:\Windows\System32\WindowsPowerShell\v1.0\.
3. On the C: drive, create a folder called PowerShellModules.
4. In C:\PowerShellModules create subfolders for each module type. ASE-Az, Az, AzureRM, Hub-Az, Hub-AzureRM.
5. Download and extract the PowerShell modules for each type to the appropriate folder.

## To use the utility


