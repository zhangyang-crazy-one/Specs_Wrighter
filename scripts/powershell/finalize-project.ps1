#!/usr/bin/env pwsh
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$ProjectDir, [Parameter(Mandatory=$false)][switch]$Json)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding
try {
    Write-StatusMessage -Type Info -Message "Finalizing project"
    $config = Get-ProjectConfig -ProjectDir $ProjectDir
    $outputDir = Join-Path $ProjectDir ".writer\output"
    $finalPath = Join-Path $outputDir "final-document.md"
    $finalContent = "# Final Document`n`nProject finalized.`n"
    Save-Utf8File -Path $finalPath -Content $finalContent
    $config.stages.'7'.completed = $true
    $config.stages.'7'.timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    $config.stages.'7'.dataPath = $finalPath
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    Write-StatusMessage -Type Success -Message "Project finalized"
    if ($Json) { Write-JsonOutput -Data @{'success'=$true; 'finalPath'=$finalPath} }
} catch {
    if ($Json) { Write-JsonOutput -Data @{'success'=$false; 'error'=$_.Exception.Message} }
    else { Write-StatusMessage -Type Error -Message $_.Exception.Message }
    exit 1
}