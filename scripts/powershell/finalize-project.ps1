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
    # 更新配置 - 使用 Add-Member 添加新属性
    $config.stages.'7'.completed = $true
    if (-not ($config.stages.'7'.PSObject.Properties.Name -contains 'timestamp')) {
        $config.stages.'7' | Add-Member -MemberType NoteProperty -Name 'timestamp' -Value (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss') -Force
    } else {
        $config.stages.'7'.timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    }
    if (-not ($config.stages.'7'.PSObject.Properties.Name -contains 'dataPath')) {
        $config.stages.'7' | Add-Member -MemberType NoteProperty -Name 'dataPath' -Value $finalPath -Force
    } else {
        $config.stages.'7'.dataPath = $finalPath
    }
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    Write-StatusMessage -Type Success -Message "Project finalized"
    if ($Json) { Write-JsonOutput -Data @{'success'=$true; 'finalPath'=$finalPath} }
} catch {
    if ($Json) { Write-JsonOutput -Data @{'success'=$false; 'error'=$_.Exception.Message} }
    else { Write-StatusMessage -Type Error -Message $_.Exception.Message }
    exit 1
}