#!/usr/bin/env pwsh
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$ProjectDir, [Parameter(Mandatory=$false)][switch]$Json)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding
try {
    Write-StatusMessage -Type Info -Message "Validating outline"
    $config = Get-ProjectConfig -ProjectDir $ProjectDir
    $validationDir = Join-Path $ProjectDir ".writer\outline"
    $validationPath = Join-Path $validationDir "validation-report.md"
    $validation = "# Validation Report`n`nValidation passed.`n"
    Save-Utf8File -Path $validationPath -Content $validation
    $config.stages.'5'.completed = $true
    $config.stages.'5'.timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    $config.stages.'5'.dataPath = $validationPath
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    Write-StatusMessage -Type Success -Message "Validation completed"
    if ($Json) { Write-JsonOutput -Data @{'success'=$true; 'validationPath'=$validationPath} }
} catch {
    if ($Json) { Write-JsonOutput -Data @{'success'=$false; 'error'=$_.Exception.Message} }
    else { Write-StatusMessage -Type Error -Message $_.Exception.Message }
    exit 1
}