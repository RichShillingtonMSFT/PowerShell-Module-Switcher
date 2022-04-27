function Load-PSModules
{
    Param
    (
        [parameter(Mandatory=$false,HelpMessage='Select the Modules to load')]
        [ValidateSet('ASE-Az','Az','AzureRM','Hub-AzureRM','Hub-Az','Default')]
        [String]$ModuleType
    )

    $ModuleExclusions = @(
    'Microsoft.PowerShell.Management'
    'Microsoft.PowerShell.Utility'
    'PSReadline'
    'ISE'
    'Microsoft.PowerShell.Management'
    'Microsoft.PowerShell.Security'
    'Microsoft.PowerShell.Utility'
    'Microsoft.WSMan.Management'
    )

    $ExistingModulePathInfoFileLocation = "$env:TEMP\ModulePathInfo.txt"
	
    if (!(Test-Path $ExistingModulePathInfoFileLocation))
    {
        $ExistingModulePathInfoFile = New-Item -Path $ExistingModulePathInfoFileLocation -Value $Env:PSModulePath -Force
    }

    if ($ModuleType -eq 'Default')
    {
        $CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
        $UserPSModuleLocation = "$HOME\Documents\WindowsPowerShell\Modules"
        $Env:PSModulePath = $UserPSModuleLocation + ";" + $CurrentValue
    }

    if ($ModuleType -eq 'Az')
    {
        $ModulePath = 'C:\PowerShellModules\Az'
    }
    
    if ($ModuleType -eq 'ASE-Az')
    {
        $ModulePath = 'C:\PowerShellModules\ASE-Az'
    }

    if ($ModuleType -eq 'AzureRM')
    {
        $ModulePath = 'C:\PowerShellModules\AzureRM'
    }

    if ($ModuleType -eq 'Hub-AzureRM')
    {
        $ModulePath = 'C:\PowerShellModules\Hub-AzureRM'
    }

    if ($ModuleType -eq 'Hub-Az')
    {
        $ModulePath = 'C:\PowerShellModules\Hub-Az'
    }

    if (Test-Path $ExistingModulePathInfoFileLocation)
    {
        $DefaultPSModulePath = Get-Content $ExistingModulePathInfoFileLocation
        if ($DefaultPSModulePath -ne $Env:PSModulePath)
        {
            $Default = $DefaultPSModulePath.Split(';')
            $Existing = $Env:PSModulePath.Split(';')
            $Difference = (Compare-Object -ReferenceObject $Default -DifferenceObject $Existing).InputObject
            $LoadedModules = Get-Module | Where-Object -Property ModuleBase -like "$Difference*"
            if ($LoadedModules.Count -gt 0)
            {
                foreach ($LoadedModule in $LoadedModules | Where-Object {$_.Name -notin $ModuleExclusions})
                {
                    Remove-Module $LoadedModule.Name -Force -Verbose
                }
            }

            $Env:PSModulePath = $DefaultPSModulePath
        }

        $Env:PSModulePath = $Env:PSModulePath+";$ModulePath"
    }
}
