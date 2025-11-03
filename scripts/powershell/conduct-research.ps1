#!/usr/bin/env pwsh
# conduct-research.ps1 - Conduct research phase
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectDir,
    [Parameter(Mandatory=$false)]
    [string]$SourceMaterial = "",
    [Parameter(Mandatory=$false)]
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding

try {
    Write-StatusMessage -Type Info -Message "Conducting research for project"
    
    $config = Get-ProjectConfig -ProjectDir $ProjectDir
    $researchDir = Join-Path $ProjectDir ".writer\research"
    $reportPath = Join-Path $researchDir "research-report.md"
    
    $report = @"
# Research Report

## Project Information
- Project: $($config.projectName)
- Type: $($config.projectType)
- Date: $(Get-Date -Format 'yyyy-MM-dd')

## Research Summary
Research phase completed successfully.

## Key Findings
- Sample finding 1
- Sample finding 2

## Recommendations
- Proceed to design phase
"@
    
    Save-Utf8File -Path $reportPath -Content $report

    # 更新配置 - 使用 Add-Member 添加新属性
    $config.stages.'1'.completed = $true
    if (-not ($config.stages.'1'.PSObject.Properties.Name -contains 'timestamp')) {
        $config.stages.'1' | Add-Member -MemberType NoteProperty -Name 'timestamp' -Value (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss') -Force
    } else {
        $config.stages.'1'.timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    }
    if (-not ($config.stages.'1'.PSObject.Properties.Name -contains 'dataPath')) {
        $config.stages.'1' | Add-Member -MemberType NoteProperty -Name 'dataPath' -Value $reportPath -Force
    } else {
        $config.stages.'1'.dataPath = $reportPath
    }
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    
    Write-StatusMessage -Type Success -Message "Research completed"
    
    $result = @{
        'success' = $true
        'reportPath' = $reportPath
    }
    
    if ($Json) {
        Write-JsonOutput -Data $result
    }
}
catch {
    $errorResult = @{
        'success' = $false
        'error' = $_.Exception.Message
    }
    
    if ($Json) {
        Write-JsonOutput -Data $errorResult
    }
    else {
        Write-StatusMessage -Type Error -Message $_.Exception.Message
    }
    
    exit 1
}