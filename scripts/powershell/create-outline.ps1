#!/usr/bin/env pwsh
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$ProjectDir, [Parameter(Mandatory=$false)][int]$Chapters=3, [Parameter(Mandatory=$false)][switch]$Json)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding
try {
    Write-StatusMessage -Type Info -Message "Creating outline"
    $config = Get-ProjectConfig -ProjectDir $ProjectDir
    $outlineDir = Join-Path $ProjectDir ".writer\outline"
    $outlinePath = Join-Path $outlineDir "outline.md"
    $outline = "# Outline`n`n"
    for ($i = 1; $i -le $Chapters; $i++) {
        $outline += "## Chapter $i`n`nChapter $i content outline.`n`n"
    }
    Save-Utf8File -Path $outlinePath -Content $outline
    # 更新配置 - 使用 Add-Member 添加新属性
    $config.stages.'4'.completed = $true
    if (-not ($config.stages.'4'.PSObject.Properties.Name -contains 'timestamp')) {
        $config.stages.'4' | Add-Member -MemberType NoteProperty -Name 'timestamp' -Value (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss') -Force
    } else {
        $config.stages.'4'.timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    }
    if (-not ($config.stages.'4'.PSObject.Properties.Name -contains 'dataPath')) {
        $config.stages.'4' | Add-Member -MemberType NoteProperty -Name 'dataPath' -Value $outlinePath -Force
    } else {
        $config.stages.'4'.dataPath = $outlinePath
    }
    if (-not ($config.stages.'4'.PSObject.Properties.Name -contains 'chapters')) {
        $config.stages.'4' | Add-Member -MemberType NoteProperty -Name 'chapters' -Value $Chapters -Force
    } else {
        $config.stages.'4'.chapters = $Chapters
    }
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    Write-StatusMessage -Type Success -Message "Outline completed"
    if ($Json) { Write-JsonOutput -Data @{'success'=$true; 'outlinePath'=$outlinePath; 'chapters'=$Chapters} }
} catch {
    if ($Json) { Write-JsonOutput -Data @{'success'=$false; 'error'=$_.Exception.Message} }
    else { Write-StatusMessage -Type Error -Message $_.Exception.Message }
    exit 1
}