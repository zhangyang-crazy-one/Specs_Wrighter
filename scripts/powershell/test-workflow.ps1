#!/usr/bin/env pwsh
# test-workflow.ps1 - Test complete workflow
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('academic', 'novel', 'drama', 'all')]
    [string]$Scenario = 'all',
    
    [Parameter(Mandatory=$false)]
    [string]$TestDir = (Join-Path $PSScriptRoot "..\..\test-projects"),
    
    [Parameter(Mandatory=$false)]
    [switch]$CleanUp
)

$ErrorActionPreference = 'Stop'

# Import common functions
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding

Write-Host "[注意] Starting workflow test..." -ForegroundColor Cyan
Write-Host "Scenario: $Scenario" -ForegroundColor Gray
Write-Host ""

# Test results
$testResults = @{
    'academic' = @{ 'passed' = 0; 'failed' = 0; 'errors' = @() }
    'novel' = @{ 'passed' = 0; 'failed' = 0; 'errors' = @() }
    'drama' = @{ 'passed' = 0; 'failed' = 0; 'errors' = @() }
}

# Test function
function Test-Step {
    param(
        [string]$Name,
        [scriptblock]$Action,
        [string]$Scenario
    )
    
    try {
        Write-Host "[注意] Executing: $Name" -ForegroundColor Cyan
        & $Action
        Write-Host "[完成] $Name - PASS" -ForegroundColor Green
        $testResults[$Scenario]['passed']++
        return $true
    }
    catch {
        Write-Host "[失败] $Name - FAIL: $($_.Exception.Message)" -ForegroundColor Red
        $testResults[$Scenario]['failed']++
        $testResults[$Scenario]['errors'] += "$Name : $($_.Exception.Message)"
        return $false
    }
}

# Test academic scenario
function Test-AcademicScenario {
    $projectName = "test-academic-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    $projectPath = Join-Path $TestDir $projectName
    
    Test-Step "Step 1: Initialize" {
        & "$PSScriptRoot\init-writer-project.ps1" -Name $projectName -Path $TestDir -Type academic -Json | Out-Null
        if (-not (Test-Path "$projectPath\.writer\config.json")) {
            throw "Project not initialized"
        }
    } -Scenario 'academic'
    
    Test-Step "Step 2: Research" {
        & "$PSScriptRoot\conduct-research.ps1" -ProjectDir $projectPath -Json | Out-Null
    } -Scenario 'academic'
    
    Test-Step "Step 3: Design" {
        & "$PSScriptRoot\create-design.ps1" -ProjectDir $projectPath -Json | Out-Null
    } -Scenario 'academic'
    
    Test-Step "Step 4: Constitution" {
        & "$PSScriptRoot\create-constitution.ps1" -ProjectDir $projectPath -Json | Out-Null
    } -Scenario 'academic'
    
    Test-Step "Step 5: Outline" {
        & "$PSScriptRoot\create-outline.ps1" -ProjectDir $projectPath -Chapters 3 -Json | Out-Null
    } -Scenario 'academic'
    
    Test-Step "Step 6: Validation" {
        & "$PSScriptRoot\validate-outline.ps1" -ProjectDir $projectPath -Json | Out-Null
    } -Scenario 'academic'
    
    Test-Step "Step 7: Write Chapter 1" {
        & "$PSScriptRoot\write-chapter.ps1" -ProjectDir $projectPath -Chapter 1 -Json | Out-Null
    } -Scenario 'academic'
    
    Test-Step "Step 8: Finalize" {
        & "$PSScriptRoot\finalize-project.ps1" -ProjectDir $projectPath -Json | Out-Null
    } -Scenario 'academic'
    
    if ($CleanUp -and (Test-Path $projectPath)) {
        Remove-Item -Path $projectPath -Recurse -Force
    }
}

# Run tests
if ($Scenario -eq 'academic' -or $Scenario -eq 'all') {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Testing Academic Scenario" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Test-AcademicScenario
    Write-Host ""
    Write-Host "[PASS] Academic scenario test completed" -ForegroundColor Green
    Write-Host "Passed: $($testResults['academic']['passed'])" -ForegroundColor Green
    Write-Host "Failed: $($testResults['academic']['failed'])" -ForegroundColor Red
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$totalPassed = 0
$totalFailed = 0

foreach ($scenario in $testResults.Keys) {
    $passed = $testResults[$scenario]['passed']
    $failed = $testResults[$scenario]['failed']
    
    if ($passed + $failed -gt 0) {
        Write-Host "$scenario scenario:" -ForegroundColor White
        Write-Host "  Passed: $passed" -ForegroundColor Green
        Write-Host "  Failed: $failed" -ForegroundColor Red
        
        if ($failed -gt 0) {
            Write-Host "  Errors:" -ForegroundColor Yellow
            foreach ($error in $testResults[$scenario]['errors']) {
                Write-Host "    - $error" -ForegroundColor Red
            }
        }
        
        $totalPassed += $passed
        $totalFailed += $failed
    }
}

Write-Host ""
Write-Host "Total:" -ForegroundColor White
Write-Host "  Passed: $totalPassed" -ForegroundColor Green
Write-Host "  Failed: $totalFailed" -ForegroundColor Red
Write-Host ""

if ($totalFailed -gt 0) {
    Write-Host "[FAIL] Some tests failed" -ForegroundColor Red
    exit 1
} else {
    Write-Host "[PASS] All tests passed" -ForegroundColor Green
    exit 0
}