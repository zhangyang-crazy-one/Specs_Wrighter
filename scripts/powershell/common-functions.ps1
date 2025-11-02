#!/usr/bin/env pwsh
# common-functions.ps1
# 公共函数库
# 版本: v1.0
# 最后更新: 2025-11-02

# 设置UTF-8编码
function Set-Utf8Encoding {
    [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
    $OutputEncoding = [System.Text.UTF8Encoding]::new($false)
    $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
    $PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'
}

# 写入状态消息
function Write-StatusMessage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('Success', 'Error', 'Warning', 'Info')]
        [string]$Type,
        
        [Parameter(Mandatory=$true)]
        [string]$Message
    )
    
    $prefix = switch ($Type) {
        'Success' { '[完成]' }
        'Error'   { '[失败]' }
        'Warning' { '[警告]' }
        'Info'    { '[注意]' }
    }
    
    $color = switch ($Type) {
        'Success' { 'Green' }
        'Error'   { 'Red' }
        'Warning' { 'Yellow' }
        'Info'    { 'Cyan' }
    }
    
    Write-Host "$prefix $Message" -ForegroundColor $color
}

# 保存UTF-8文件
function Save-Utf8File {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        
        [Parameter(Mandatory=$true)]
        [string]$Content
    )
    
    $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
    [System.IO.File]::WriteAllText($Path, $Content, $utf8NoBom)
}

# 读取UTF-8文件
function Read-Utf8File {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    if (-not (Test-Path $Path)) {
        throw "文件不存在: $Path"
    }
    
    return [System.IO.File]::ReadAllText($Path, [System.Text.UTF8Encoding]::new($false))
}

# 保存JSON文件
function Save-JsonFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        
        [Parameter(Mandatory=$true)]
        [object]$Object,
        
        [Parameter(Mandatory=$false)]
        [int]$Depth = 10
    )
    
    $json = $Object | ConvertTo-Json -Depth $Depth
    Save-Utf8File -Path $Path -Content $json
}

# 读取JSON文件
function Read-JsonFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    $content = Read-Utf8File -Path $Path
    return $content | ConvertFrom-Json
}

# 输出JSON格式结果
function Write-JsonOutput {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [object]$Data
    )

    $json = $Data | ConvertTo-Json -Depth 10 -Compress
    Write-Output $json
}

# 确保目录存在
function Ensure-Directory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

# 验证项目目录
function Test-WriterProject {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ProjectDir
    )
    
    $configPath = Join-Path $ProjectDir ".writer\config.json"
    return (Test-Path $configPath)
}

# 获取项目配置
function Get-ProjectConfig {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ProjectDir
    )
    
    $configPath = Join-Path $ProjectDir ".writer\config.json"
    
    if (-not (Test-Path $configPath)) {
        throw "项目配置文件不存在: $configPath"
    }
    
    return Read-JsonFile -Path $configPath
}

# 更新项目配置
function Update-ProjectConfig {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ProjectDir,
        
        [Parameter(Mandatory=$true)]
        [object]$Config
    )
    
    $configPath = Join-Path $ProjectDir ".writer\config.json"
    Save-JsonFile -Path $configPath -Object $Config
}
