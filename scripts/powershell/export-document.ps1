# export-document.ps1
# 导出文档脚本

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

param(
    [Parameter(Mandatory=$true)]
    [string]$SourcePath,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet('pdf', 'docx', 'html')]
    [string]$Format,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = ""
)

# 验证源文件
if (-not (Test-Path $SourcePath)) {
    Write-Error "[失败] 源文件不存在: $SourcePath"
    exit 1
}

Write-Output "[开始] 导出文档"
Write-Output "源文件: $SourcePath"
Write-Output "格式: $Format"

# 确定输出路径
if ($OutputPath -eq "") {
    $sourceDir = Split-Path -Parent $SourcePath
    $sourceBaseName = [System.IO.Path]::GetFileNameWithoutExtension($SourcePath)
    $OutputPath = Join-Path $sourceDir "$sourceBaseName.$Format"
}

Write-Output "输出路径: $OutputPath"

# 检查Pandoc是否安装
$pandocInstalled = $null -ne (Get-Command pandoc -ErrorAction SilentlyContinue)

if (-not $pandocInstalled) {
    Write-Warning "[警告] 未检测到Pandoc"
    Write-Output ""
    Write-Output "Pandoc是一个强大的文档转换工具,用于将Markdown转换为其他格式。"
    Write-Output ""
    Write-Output "安装方法:"
    Write-Output "1. 访问 https://pandoc.org/installing.html"
    Write-Output "2. 下载并安装适合您系统的版本"
    Write-Output "3. 重新运行此脚本"
    Write-Output ""
    Write-Output "[注意] 当前将创建一个简化的HTML版本"
    
    # 创建简化的HTML版本
    $content = Get-Content -Path $SourcePath -Encoding UTF8 -Raw
    
    $htmlContent = @"
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文档导出</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            line-height: 1.6;
        }
        h1, h2, h3 { color: #333; }
        code { background: #f4f4f4; padding: 2px 5px; }
        pre { background: #f4f4f4; padding: 10px; overflow-x: auto; }
    </style>
</head>
<body>
<pre>$([System.Web.HttpUtility]::HtmlEncode($content))</pre>
</body>
</html>
"@
    
    $htmlPath = [System.IO.Path]::ChangeExtension($OutputPath, "html")
    $htmlContent | Out-File -FilePath $htmlPath -Encoding UTF8
    
    Write-Output "[完成] 简化HTML版本已创建: $htmlPath"
    Write-Output "[提示] 安装Pandoc以获得更好的导出效果"
    
    $result = @{
        status = "partial_success"
        message = "Pandoc未安装,已创建简化HTML版本"
        source_file = $SourcePath
        output_file = $htmlPath
        format = "html"
        pandoc_installed = $false
    } | ConvertTo-Json -Compress
    
    Write-Output ""
    Write-Output $result
    exit 0
}

# 使用Pandoc转换
Write-Output "[信息] 使用Pandoc进行转换..."

try {
    switch ($Format) {
        'pdf' {
            # PDF转换需要LaTeX引擎
            pandoc $SourcePath -o $OutputPath --pdf-engine=xelatex -V CJKmainfont="Microsoft YaHei"
        }
        'docx' {
            # DOCX转换
            pandoc $SourcePath -o $OutputPath
        }
        'html' {
            # HTML转换,使用独立模式
            pandoc $SourcePath -o $OutputPath --standalone --self-contained
        }
    }
    
    if (Test-Path $OutputPath) {
        $fileSize = (Get-Item $OutputPath).Length
        $fileSizeKB = [math]::Round($fileSize / 1KB, 2)
        
        Write-Output ""
        Write-Output "[完成] 文档导出成功"
        Write-Output "输出文件: $OutputPath"
        Write-Output "文件大小: $fileSizeKB KB"
        
        $result = @{
            status = "success"
            source_file = $SourcePath
            output_file = $OutputPath
            format = $Format
            file_size_kb = $fileSizeKB
            pandoc_installed = $true
        } | ConvertTo-Json -Compress
        
        Write-Output ""
        Write-Output $result
    } else {
        Write-Error "[失败] 导出失败,输出文件未生成"
        exit 1
    }
    
} catch {
    Write-Error "[失败] Pandoc转换失败: $_"
    
    if ($Format -eq 'pdf') {
        Write-Output ""
        Write-Output "[提示] PDF导出需要LaTeX引擎"
        Write-Output "安装方法:"
        Write-Output "1. 安装MiKTeX: https://miktex.org/download"
        Write-Output "2. 或安装TeX Live: https://www.tug.org/texlive/"
    }
    
    exit 1
}

