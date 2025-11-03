#!/usr/bin/env pwsh
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$ProjectDir, [Parameter(Mandatory=$true)][int]$Chapter, [Parameter(Mandatory=$false)][switch]$Json)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common-functions.ps1"
Set-Utf8Encoding
try {
    Write-StatusMessage -Type Info -Message "Writing chapter $Chapter"
    $config = Get-ProjectConfig -ProjectDir $ProjectDir
    $chaptersDir = Join-Path $ProjectDir ".writer\chapters"
    $chapterPath = Join-Path $chaptersDir "chapter-$Chapter.md"
    $chapterContent = "# Chapter $Chapter`n`nChapter $Chapter content.`n"
    Save-Utf8File -Path $chapterPath -Content $chapterContent
    
    if (-not ($config.stages.'6'.PSObject.Properties.Name -contains 'chapters')) {
        $config.stages.'6' | Add-Member -MemberType NoteProperty -Name 'chapters' -Value @{} -Force
    }
    if (-not $config.stages.'6'.chapters) { 
        $config.stages.'6'.chapters = @{} 
    }
    $config.stages.'6'.chapters["$Chapter"] = @{'path'=$chapterPath; 'completed'=$true; 'timestamp'=(Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')}
    
    Update-ProjectConfig -ProjectDir $ProjectDir -Config $config
    Write-StatusMessage -Type Success -Message "Chapter $Chapter completed"
    
    if ($Json) { 
        Write-JsonOutput -Data @{'success'=$true; 'chapterPath'=$chapterPath} 
    }
} catch {
    if ($Json) { 
        Write-JsonOutput -Data @{'success'=$false; 'error'=$_.Exception.Message} 
    } else { 
        Write-StatusMessage -Type Error -Message $_.Exception.Message 
    }
    exit 1
}

