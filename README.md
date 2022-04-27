# PowerShell-Module-Switcher
Utility to help managed conflicting PowerShell Modules for Azure, Azure Stack Hub and Azure Stack Edge

If you manage Azure, Azure Stack Hub and Azure Stack Edge, you probably run in to module conflicts due API differences.
This is how I manage all of these without removing modules and manually making changes to module paths.

## How to set it up

Run the following in an elevated PowerShell window to setup your environment.

--

--

1. Create a folder called PowerShellFunctions in your Documents folder and copy Load-PSModules.ps1 to it.
2. Copy profile.ps1 to C:\Windows\System32\WindowsPowerShell\v1.0\.
3. On the C: drive, create a folder called PowerShellModules.
4. In C:\PowerShellModules create subfolders for each module type. ASE-Az, Az, AzureRM, Hub-Az, Hub-AzureRM.
5. Download and extract the PowerShell modules for each type to the appropriate folder.

## To use the utility

