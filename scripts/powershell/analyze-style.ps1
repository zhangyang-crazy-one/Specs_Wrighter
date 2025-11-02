# analyze-style.ps1
# 分析文本风格脚本

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath,
    
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = "writer_style"
)

# 验证输入文件
if (-not (Test-Path $FilePath)) {
    Write-Error "[失败] 文件不存在: $FilePath"
    exit 1
}

Write-Output "[开始] 分析文本风格: $FilePath"

# 读取文件内容
$content = Get-Content -Path $FilePath -Encoding UTF8 -Raw

# 基本统计
$lines = ($content -split "`n").Count
$words = ($content -split '\s+').Count
$chars = $content.Length

Write-Output "[信息] 文本统计:"
Write-Output "  行数: $lines"
Write-Output "  字数: $words"
Write-Output "  字符数: $chars"

# 计算平均句长
$sentences = $content -split '[。.!?]'
$sentences = $sentences | Where-Object { $_.Trim() -ne '' }
$avgSentenceLength = if ($sentences.Count -gt 0) { 
    [math]::Round($words / $sentences.Count, 1) 
} else { 
    0 
}

Write-Output "  句子数: $($sentences.Count)"
Write-Output "  平均句长: $avgSentenceLength 字"

# 检测语言
$chineseChars = ([regex]::Matches($content, '[\u4e00-\u9fa5]')).Count
$englishWords = ([regex]::Matches($content, '\b[a-zA-Z]+\b')).Count

$language = if ($chineseChars -gt $englishWords) { "中文为主" } 
            elseif ($englishWords -gt $chineseChars) { "英文为主" } 
            else { "双语" }

Write-Output "  语言: $language"

# 检测人称
$firstPerson = ([regex]::Matches($content, '我|我们|咱们|I|we|me|us')).Count
$secondPerson = ([regex]::Matches($content, '你|您|你们|you|your')).Count
$thirdPerson = ([regex]::Matches($content, '他|她|它|他们|她们|它们|he|she|it|they')).Count

$person = if ($firstPerson -gt $secondPerson -and $firstPerson -gt $thirdPerson) { "第一人称" }
          elseif ($secondPerson -gt $firstPerson -and $secondPerson -gt $thirdPerson) { "第二人称" }
          elseif ($thirdPerson -gt $firstPerson -and $thirdPerson -gt $secondPerson) { "第三人称" }
          else { "混合人称" }

Write-Output "  主要人称: $person"

# 创建风格文档
$styleContent = @"
# $ProjectName 风格指南

**分析日期**: $(Get-Date -Format "yyyy-MM-dd")
**源文件**: $FilePath

---

## 风格元数据

``````yaml
project: $ProjectName
language: $language
analysis_date: $(Get-Date -Format "yyyy-MM-dd")
``````

---

## 1. 语言风格

### 1.1 语调
- **正式程度**: [需人工评估,1-5分]
- **客观性**: [需人工评估]
- **情感倾向**: [需人工评估]

### 1.2 人称和时态
- **人称**: $person
- **时态**: [需人工评估]
- **语气**: [需人工评估]

---

## 2. 词汇特征

### 2.1 词汇复杂度
- **整体水平**: [需人工评估]
- **专业术语密度**: [需人工评估]

### 2.2 常用词汇
[需人工分析]

---

## 3. 句式特征

### 3.1 句子结构
- **平均句长**: $avgSentenceLength 字
- **句式偏好**: [需人工评估]
- **段落长度**: [需人工评估]

### 3.2 过渡模式
[需人工分析]

---

## 4. 结构特征

### 4.1 章节组织
- **组织方式**: [需人工评估]
- **标题风格**: [需人工评估]

### 4.2 格式规范
- **列表使用**: [需人工评估]
- **表格使用**: [需人工评估]

---

## 5. 文本统计

- **总行数**: $lines
- **总字数**: $words
- **总字符数**: $chars
- **句子数**: $($sentences.Count)
- **平均句长**: $avgSentenceLength 字
- **语言**: $language
- **主要人称**: $person

---

## 6. 写作建议

[基于分析结果,建议由style-analyzer Agent生成]

---

**注意**: 本文档由自动分析生成,部分内容需要人工评估和完善。
建议使用 style-analyzer Agent 进行更深入的分析。
"@

# 确保输出目录存在
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

# 保存风格文档
$outputFile = Join-Path $OutputPath "${ProjectName}_style.md"
$styleContent | Out-File -FilePath $outputFile -Encoding UTF8

Write-Output ""
Write-Output "[完成] 风格分析完成"
Write-Output "风格文档已保存至: $outputFile"

# 输出结果JSON
$result = @{
    status = "success"
    project_name = $ProjectName
    source_file = $FilePath
    output_file = $outputFile
    statistics = @{
        lines = $lines
        words = $words
        chars = $chars
        sentences = $sentences.Count
        avg_sentence_length = $avgSentenceLength
        language = $language
        person = $person
    }
    next_steps = @(
        "使用 style-analyzer Agent 进行深入分析",
        "人工完善风格文档中的评估项",
        "在写作时参考此风格文档"
    )
} | ConvertTo-Json -Compress

Write-Output ""
Write-Output $result

