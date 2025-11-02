#!/usr/bin/env pwsh
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$ProjectDir, [Parameter(Mandatory=$false)][switch]$Json)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding
try {
    Write-StatusMessage -Type Info -Message "Creating constitution"
    $config = Get-ProjectConfig -ProjectDir $ProjectDir
    $constitutionDir = Join-Path $ProjectDir ".writer\constitution"
    $constitutionPath = Join-Path $constitutionDir "constitution.md"
    $constitution = "# Constitution`n`nConstitution phase completed.`n"
    Save-Utf8File -Path $constitutionPath -Content $constitution
    $config.stages.'3'.completed = $true
    $config.stages.'3'.timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    $config.stages.'3'.dataPath = $constitutionPath
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    Write-StatusMessage -Type Success -Message "Constitution completed"
    if ($Json) { Write-JsonOutput -Data @{'success'=$true; 'constitutionPath'=$constitutionPath} }
} catch {
    if ($Json) { Write-JsonOutput -Data @{'success'=$false; 'error'=$_.Exception.Message} }
    else { Write-StatusMessage -Type Error -Message $_.Exception.Message }
    exit 1
}