#!/usr/bin/env pwsh
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$ProjectDir, [Parameter(Mandatory=$false)][switch]$Json)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding
try {
    Write-StatusMessage -Type Info -Message "Creating design document"
    $config = Get-ProjectConfig -ProjectDir $ProjectDir
    $designDir = Join-Path $ProjectDir ".writer\design"
    $designPath = Join-Path $designDir "design-document.md"
    $design = "# Design Document`n`nDesign phase completed.`n"
    Save-Utf8File -Path $designPath -Content $design
    $config.stages.'2'.completed = $true
    $config.stages.'2'.timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    $config.stages.'2'.dataPath = $designPath
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    Write-StatusMessage -Type Success -Message "Design completed"
    if ($Json) { Write-JsonOutput -Data @{'success'=$true; 'designPath'=$designPath} }
} catch {
    if ($Json) { Write-JsonOutput -Data @{'success'=$false; 'error'=$_.Exception.Message} }
    else { Write-StatusMessage -Type Error -Message $_.Exception.Message }
    exit 1
}