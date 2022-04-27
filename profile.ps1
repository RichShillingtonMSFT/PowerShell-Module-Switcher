﻿#  Copyright (c) Microsoft Corporation.  All rights reserved.
#  
# THIS SAMPLE CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
# WHETHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
# IF THIS CODE AND INFORMATION IS MODIFIED, THE ENTIRE RISK OF USE OR RESULTS IN
# CONNECTION WITH THE USE OF THIS CODE AND INFORMATION REMAINS WITH THE USER.

# Directory where my function scripts are stored
# Example: "$ENV:USERPROFILE\Documents\PowerShellFunctions"
$FunctionDirectory = "$ENV:USERPROFILE\Documents\PowerShellFunctions"

# Automatically Load All Scripts in the $FunctionDirectory location
Get-ChildItem "${FunctionDirectory}\*.ps1" | ForEach-Object {.$_}

Write-Host "Custom PowerShell Environment Loaded"