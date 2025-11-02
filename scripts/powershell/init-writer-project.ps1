#!/usr/bin/env pwsh
# init-writer-project.ps1 - Initialize writer project
# Version: v1.0

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [string]$Path = ".",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet('academic', 'novel', 'drama')]
    [string]$Type = 'academic',
    
    [Parameter(Mandatory=$false)]
    [switch]$Json
)

$ErrorActionPreference = 'Stop'

# Import common functions
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding

try {
    Write-StatusMessage -Type Info -Message "Initializing project: $Name"
    
    # Create project directory
    $projectPath = Join-Path $Path $Name
    if (Test-Path $projectPath) {
        throw "Project directory already exists: $projectPath"
    }
    
    New-Item -ItemType Directory -Path $projectPath -Force | Out-Null
    
    # Create .writer directory
    $writerDir = Join-Path $projectPath ".writer"
    New-Item -ItemType Directory -Path $writerDir -Force | Out-Null
    
    # Create subdirectories
    $dirs = @('research', 'design', 'constitution', 'outline', 'chapters', 'output')
    foreach ($dir in $dirs) {
        New-Item -ItemType Directory -Path (Join-Path $writerDir $dir) -Force | Out-Null
    }
    
    # Create config.json
    $config = @{
        'projectName' = $Name
        'projectType' = $Type
        'createdAt' = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
        'version' = '1.0'
        'stages' = @{
            '0' = @{ 'name' = 'Initialization'; 'completed' = $true; 'timestamp' = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss') }
            '1' = @{ 'name' = 'Research'; 'completed' = $false }
            '2' = @{ 'name' = 'Design'; 'completed' = $false }
            '3' = @{ 'name' = 'Constitution'; 'completed' = $false }
            '4' = @{ 'name' = 'Outline'; 'completed' = $false }
            '5' = @{ 'name' = 'Validation'; 'completed' = $false }
            '6' = @{ 'name' = 'Drafting'; 'completed' = $false }
            '7' = @{ 'name' = 'Finalization'; 'completed' = $false }
        }
    }
    
    $configPath = Join-Path $writerDir "config.json"
    Save-JsonFile -Path $configPath -Object $config
    
    Write-StatusMessage -Type Success -Message "Project initialized successfully"
    Write-StatusMessage -Type Info -Message "Project path: $projectPath"
    
    # Output result
    $result = @{
        'success' = $true
        'projectName' = $Name
        'projectPath' = $projectPath
        'projectType' = $Type
        'configPath' = $configPath
    }
    
    if ($Json) {
        Write-JsonOutput -Data $result
    }
    else {
        Write-Host ""
        Write-Host "Next step: Run research phase" -ForegroundColor Cyan
    }
}
catch {
    $errorResult = @{
        'success' = $false
        'error' = $_.Exception.Message
        'details' = $_.ScriptStackTrace
    }
    
    if ($Json) {
        Write-JsonOutput -Data $errorResult
    }
    else {
        Write-StatusMessage -Type Error -Message $_.Exception.Message
    }
    
    exit 1
}