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
    # 更新配置 - 使用 Add-Member 添加新属性
    $config.stages.'2'.completed = $true
    if (-not ($config.stages.'2'.PSObject.Properties.Name -contains 'timestamp')) {
        $config.stages.'2' | Add-Member -MemberType NoteProperty -Name 'timestamp' -Value (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss') -Force
    } else {
        $config.stages.'2'.timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    }
    if (-not ($config.stages.'2'.PSObject.Properties.Name -contains 'dataPath')) {
        $config.stages.'2' | Add-Member -MemberType NoteProperty -Name 'dataPath' -Value $designPath -Force
    } else {
        $config.stages.'2'.dataPath = $designPath
    }
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    Write-StatusMessage -Type Success -Message "Design completed"
    if ($Json) { Write-JsonOutput -Data @{'success'=$true; 'designPath'=$designPath} }
} catch {
    if ($Json) { Write-JsonOutput -Data @{'success'=$false; 'error'=$_.Exception.Message} }
    else { Write-StatusMessage -Type Error -Message $_.Exception.Message }
    exit 1
}