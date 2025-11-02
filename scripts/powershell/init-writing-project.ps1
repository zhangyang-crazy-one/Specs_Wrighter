# init-writing-project.ps1
# 初始化写作项目脚本

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet('academic', 'article', 'creative', 'professional')]
    [string]$GenreType,
    
    [Parameter(Mandatory=$true)]
    [string]$SpecificType,
    
    [Parameter(Mandatory=$false)]
    [string]$ProjectPath = "."
)

# 验证具体类型
$validTypes = @{
    'academic' = @('research-paper', 'literature-review', 'case-study')
    'article' = @('technical-article', 'blog-post', 'tutorial', 'report')
    'creative' = @('novel', 'screenplay', 'stage-play', 'poetry', 'character-biography')
    'professional' = @('project-doc', 'technical-spec', 'business-proposal', 'user-manual')
}

if ($SpecificType -notin $validTypes[$GenreType]) {
    Write-Error "[失败] 无效的具体类型: $SpecificType"
    Write-Output "有效的类型: $($validTypes[$GenreType] -join ', ')"
    exit 1
}

# 创建项目目录
$fullPath = Join-Path $ProjectPath $ProjectName
if (Test-Path $fullPath) {
    Write-Warning "[警告] 项目目录已存在: $fullPath"
    $response = Read-Host "是否覆盖? (y/n)"
    if ($response -ne 'y') {
        Write-Output "[取消] 项目初始化已取消"
        exit 0
    }
    Remove-Item -Path $fullPath -Recurse -Force
}

New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
Write-Output "[完成] 创建项目目录: $fullPath"

# 复制模板文件
$templateSource = Join-Path $PSScriptRoot "..\..\templates\$GenreType\$SpecificType.md"
$templateDest = Join-Path $fullPath "main.md"

if (Test-Path $templateSource) {
    Copy-Item -Path $templateSource -Destination $templateDest -Force
    Write-Output "[完成] 复制模板文件: $SpecificType.md"
} else {
    Write-Warning "[警告] 模板文件不存在: $templateSource"
}

# 创建项目配置文件
$config = @{
    project_name = $ProjectName
    genre_type = $GenreType
    specific_type = $SpecificType
    created_date = Get-Date -Format "yyyy-MM-dd"
    author = $env:USERNAME
    status = "draft"
    version = "1.0"
} | ConvertTo-Json -Compress

$configPath = Join-Path $fullPath "project-config.json"
$config | Out-File -FilePath $configPath -Encoding UTF8
Write-Output "[完成] 创建配置文件: project-config.json"

# 创建大纲文件
$outlinePath = Join-Path $fullPath "outline.md"
$outlineContent = @"
# $ProjectName - 大纲

**文体类型**: $GenreType - $SpecificType
**创建日期**: $(Get-Date -Format "yyyy-MM-dd")

---

## 大纲结构

[在此添加大纲内容]

---

**提示**: 使用 writer.outline 命令生成详细大纲
"@

$outlineContent | Out-File -FilePath $outlinePath -Encoding UTF8
Write-Output "[完成] 创建大纲文件: outline.md"

# 创建writer_style目录(如果不存在)
$styleDir = "writer_style"
if (-not (Test-Path $styleDir)) {
    New-Item -ItemType Directory -Path $styleDir -Force | Out-Null
    Write-Output "[完成] 创建风格文档目录: writer_style/"
}

# 输出结果JSON
$result = @{
    status = "success"
    project_name = $ProjectName
    genre_type = $GenreType
    specific_type = $SpecificType
    project_path = $fullPath
    files_created = @(
        "main.md",
        "project-config.json",
        "outline.md"
    )
    next_steps = @(
        "使用 writer.outline 创建详细大纲",
        "使用 writer.style 定义风格指南",
        "使用 writer.draft 开始写作"
    )
} | ConvertTo-Json -Compress

Write-Output ""
Write-Output "[完成] 项目初始化成功"
Write-Output "项目名称: $ProjectName"
Write-Output "文体类型: $GenreType - $SpecificType"
Write-Output "项目路径: $fullPath"
Write-Output ""
Write-Output "已创建文件:"
Write-Output "- main.md"
Write-Output "- project-config.json"
Write-Output "- outline.md"
Write-Output ""
Write-Output "下一步建议:"
Write-Output "1. 使用 writer.outline 创建详细大纲"
Write-Output "2. 使用 writer.style 定义风格指南"
Write-Output "3. 使用 writer.draft 开始写作"
Write-Output ""
Write-Output $result

