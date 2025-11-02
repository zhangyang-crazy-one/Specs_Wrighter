#!/usr/bin/env pwsh
# integration-test.ps1
$ErrorActionPreference = 'Stop'

Write-Host "[INFO] Starting Integration Test..." -ForegroundColor Cyan
$passed = 0
$failed = 0

function Test-Item {
    param([string]$Name, [scriptblock]$Test)
    try {
        Write-Host "[TEST] $Name" -ForegroundColor Cyan
        & $Test
        Write-Host "[PASS] $Name" -ForegroundColor Green
        $script:passed++
    } catch {
        Write-Host "[FAIL] $Name - $($_.Exception.Message)" -ForegroundColor Red
        $script:failed++
    }
}

# Test 1: Command files
Test-Item "Command files exist" {
    $files = 'init.md','1-research.md','2-design.md','3-constitution.md','4-outline.md','5-validate.md','6-draft.md','7-finalize.md'
    foreach ($f in $files) {
        $path = Join-Path (Join-Path '.augment' 'commands') (Join-Path 'writer' $f)
        if (-not (Test-Path $path)) { throw "Missing: $f" }
    }
}

# Test 2: PowerShell scripts
Test-Item "PowerShell scripts exist" {
    $scripts = 'init-writer-project.ps1','conduct-research.ps1','create-design.ps1','create-constitution.ps1','create-outline.ps1','validate-outline.ps1','write-chapter.ps1','finalize-project.ps1'
    foreach ($s in $scripts) {
        $path = Join-Path (Join-Path 'scripts' 'powershell') $s
        if (-not (Test-Path $path)) { throw "Missing: $s" }
    }
}

# Test 3: Common functions
Test-Item "Common functions library" {
    $path = Join-Path (Join-Path 'scripts' 'powershell') 'common-functions.ps1'
    if (-not (Test-Path $path)) { throw "common-functions.ps1 not found" }
}

# Test 4: Rules files
Test-Item "Rules files exist" {
    $rules = 'writer-workflow.md','constitution-principles.md','validation-rules.md'
    foreach ($r in $rules) {
        $path = Join-Path (Join-Path '.augment' 'rules') $r
        if (-not (Test-Path $path)) { throw "Missing: $r" }
    }
}

# Test 5: Directory structure
Test-Item "Directory structure" {
    $dirs = '.augment','scripts','templates'
    foreach ($d in $dirs) {
        if (-not (Test-Path $d)) { throw "Missing directory: $d" }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Integration Test Results" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor Red

if ($failed -gt 0) {
    Write-Host "[FAIL] Integration test failed" -ForegroundColor Red
    exit 1
} else {
    Write-Host "[PASS] All integration tests passed!" -ForegroundColor Green
    exit 0
}