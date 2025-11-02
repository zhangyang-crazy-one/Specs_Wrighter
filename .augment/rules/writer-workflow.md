---
type: always_apply
---

# 七阶段写作工作流程规则

本规则文件定义了Specify Writer项目的核心工作流程规范，适用于所有写作项目。

---

## 核心原则

### 1. 严格遵循七阶段顺序

**必须按照以下顺序执行**:
1. 内容调研与类型确定
2. 风格与背景设计
3. 创作宪法文件
4. 情节设计与大纲编写
5. 合规性审查
6. 分章节编写
7. 最终审查与导出

**禁止**:
- ❌ 跳过任何阶段
- ❌ 在前一阶段未完成时进入下一阶段
- ❌ 在验证不通过时继续编写内容

### 2. 阶段完成标准

每个阶段必须满足以下条件才能进入下一阶段:

**阶段一完成标准**:
- [x] 生成 `research-report.md`
- [x] 确定写作类型
- [x] 提取关键信息到 `keywords.json`

**阶段二完成标准**:
- [x] 生成 `style-guide.md`
- [x] 生成 `background.md`（如适用）
- [x] 生成 `worldview.md`（如适用）

**阶段三完成标准**:
- [x] 生成 `constitution.md`
- [x] 包含核心主题和价值观
- [x] 包含不可违背的创作原则
- [x] 包含明确的约束条件

**阶段四完成标准**:
- [x] 生成 `outline.md`
- [x] 生成 `chapters.json`
- [x] 包含详细的章节划分
- [x] 包含情节推进节奏

**阶段五完成标准**:
- [x] 生成 `validation-report.md`
- [x] 所有检查项都通过
- [x] 如有问题，必须返回阶段四修改

**阶段六完成标准**:
- [x] 所有章节都已生成
- [x] 每章都符合大纲要求
- [x] 每章都符合宪法文件要求

**阶段七完成标准**:
- [x] 生成 `final-document.md`
- [x] 生成 `metadata.json`
- [x] 导出指定格式文件

---

## 编码和输出规范

### 1. 文件编码

**强制要求**:
- ✅ 所有文件必须使用 **UTF-8 编码（无BOM）**
- ✅ PowerShell脚本必须在开头调用 `Set-Utf8Encoding`
- ✅ 所有文本文件必须使用LF换行符（Unix风格）

**检查方法**:
```powershell
# 检查文件编码
Get-Content -Path <file> -Encoding UTF8
```

### 2. 命令行输出

**强制要求**:
- ✅ **禁用emoji图标**
- ✅ 使用纯文本替代:
  - `[完成]` 或 `[PASS]` 替代 ✅
  - `[失败]` 或 `[FAIL]` 替代 ❌
  - `[注意]` 或 `[NOTE]` 替代 📝
  - `[警告]` 或 `[WARNING]` 替代 ⚠️

**原因**:
- 跨平台兼容性（Windows PowerShell编码问题）
- JSON解析稳定性（emoji可能破坏JSON格式）
- 终端显示一致性（不同终端对emoji支持不同）

**示例**:
```powershell
# 正确 ✅
Write-Output "[完成] 项目初始化成功"
Write-Output "[注意] 请检查配置文件"

# 错误 ❌
Write-Output "✅ 项目初始化成功"
Write-Output "📝 请检查配置文件"
```

### 3. PowerShell脚本规范

**必须包含**:
```powershell
#!/usr/bin/env pwsh
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectDir,
    
    [switch]$Json
)

$ErrorActionPreference = 'Stop'

# 导入公共函数
. "$PSScriptRoot/common-functions.ps1"
Set-Utf8Encoding

# 主逻辑...

if ($Json) {
    Write-JsonOutput @{
        "status" = "success"
        "data" = @{ ... }
    }
} else {
    Write-StatusMessage -Type Success -Message "操作完成"
}
```

**关键点**:
- ✅ 必须支持 `-Json` 参数
- ✅ 必须调用 `Set-Utf8Encoding`
- ✅ 必须使用 `Write-StatusMessage` 输出状态（禁用emoji）
- ✅ 必须使用 `Write-JsonOutput` 输出JSON

---

## 前置条件检查

### 1. 项目初始化检查

在执行任何阶段命令前，必须检查:
```powershell
# 检查项目是否已初始化
if (-not (Test-Path "$ProjectDir/.writer/config.json")) {
    Write-StatusMessage -Type Error -Message "项目未初始化，请先运行 /writer:init"
    exit 1
}
```

### 2. 阶段依赖检查

每个阶段必须检查前置阶段是否完成:

**阶段二检查**:
```powershell
# 检查阶段一是否完成
if (-not (Test-Path "$ProjectDir/.writer/research/research-report.md")) {
    Write-StatusMessage -Type Error -Message "阶段一未完成，请先运行 /writer:1-research"
    exit 1
}
```

**阶段三检查**:
```powershell
# 检查阶段二是否完成
if (-not (Test-Path "$ProjectDir/.writer/design/style-guide.md")) {
    Write-StatusMessage -Type Error -Message "阶段二未完成，请先运行 /writer:2-design"
    exit 1
}
```

**阶段四检查**:
```powershell
# 检查阶段三是否完成
if (-not (Test-Path "$ProjectDir/.writer/constitution/constitution.md")) {
    Write-StatusMessage -Type Error -Message "阶段三未完成，请先运行 /writer:3-constitution"
    exit 1
}
```

**阶段五检查**:
```powershell
# 检查阶段四是否完成
if (-not (Test-Path "$ProjectDir/.writer/outline/outline.md")) {
    Write-StatusMessage -Type Error -Message "阶段四未完成，请先运行 /writer:4-outline"
    exit 1
}
```

**阶段六检查**:
```powershell
# 检查阶段五是否通过
$validationReport = Get-Content "$ProjectDir/.writer/validation/validation-report.md" -Raw
if ($validationReport -notmatch "状态: 通过") {
    Write-StatusMessage -Type Error -Message "阶段五验证未通过，请先修改大纲"
    exit 1
}
```

**阶段七检查**:
```powershell
# 检查所有章节是否完成
$config = Get-Content "$ProjectDir/.writer/config.json" | ConvertFrom-Json
$chapterCount = $config.chapterCount
$completedChapters = (Get-ChildItem "$ProjectDir/.writer/drafts/chapter-*.md").Count

if ($completedChapters -lt $chapterCount) {
    Write-StatusMessage -Type Error -Message "还有 $($chapterCount - $completedChapters) 章未完成"
    exit 1
}
```

---

## 错误处理

### 1. 统一错误格式

**JSON模式**:
```json
{
  "status": "error",
  "error": {
    "code": "ERROR_CODE",
    "message": "错误描述",
    "details": "详细信息"
  }
}
```

**文本模式**:
```
[失败] 错误描述
详细信息...
```

### 2. 常见错误代码

| 错误代码 | 描述 | 处理方式 |
|---------|------|---------|
| `PROJECT_NOT_INITIALIZED` | 项目未初始化 | 运行 `/writer:init` |
| `STAGE_NOT_COMPLETED` | 前置阶段未完成 | 完成前置阶段 |
| `VALIDATION_FAILED` | 验证未通过 | 修改大纲后重新验证 |
| `FILE_NOT_FOUND` | 文件不存在 | 检查文件路径 |
| `INVALID_PARAMETER` | 参数无效 | 检查参数格式 |

---

## 配置文件管理

### 1. config.json结构

```json
{
  "projectName": "项目名称",
  "writingType": "写作类型",
  "createdAt": "2025-11-02T10:00:00Z",
  "currentStage": 1,
  "chapterCount": 20,
  "stages": {
    "1": { "completed": true, "completedAt": "2025-11-02T11:00:00Z" },
    "2": { "completed": true, "completedAt": "2025-11-02T12:00:00Z" },
    "3": { "completed": false },
    "4": { "completed": false },
    "5": { "completed": false },
    "6": { "completed": false },
    "7": { "completed": false }
  }
}
```

### 2. 更新配置

每个阶段完成后必须更新配置:
```powershell
$config = Get-ProjectConfig -ProjectDir $ProjectDir
$config.stages."1".completed = $true
$config.stages."1".completedAt = (Get-Date).ToUniversalTime().ToString("o")
$config.currentStage = 2
Set-ProjectConfig -ProjectDir $ProjectDir -Config $config
```

---

## 最佳实践

### 1. 版本控制

- 每个阶段完成后提交Git
- 使用有意义的提交信息
- 重要修改前创建分支

### 2. 备份策略

- 定期备份 `.writer/` 目录
- 特别备份宪法文件和大纲文件
- 使用云存储或外部硬盘

### 3. 文档维护

- 保持README.md更新
- 记录重要决策
- 更新变更日志

### 4. 代码审查

- 提交前运行所有测试
- 检查编码规范
- 验证JSON输出格式

---

## 禁止事项

### 绝对禁止

- ❌ 跳过阶段
- ❌ 使用emoji输出
- ❌ 使用非UTF-8编码
- ❌ 不支持`-Json`参数
- ❌ 在验证不通过时继续
- ❌ 修改宪法文件（除非重新开始）
- ❌ 手动编辑config.json（使用脚本）

### 强烈不建议

- ⚠️ 同时编写多个章节（可能导致风格不一致）
- ⚠️ 频繁修改大纲（影响已完成章节）
- ⚠️ 忽略验证报告的警告
- ⚠️ 不备份重要文件

---

## 故障排除

### 问题1: 编码错误

**症状**: PowerShell脚本输出乱码

**解决**:
```powershell
# 在脚本开头添加
. "$PSScriptRoot/common-functions.ps1"
Set-Utf8Encoding
```

### 问题2: JSON解析失败

**症状**: 命令无法解析脚本输出

**解决**:
- 检查是否使用了emoji
- 检查JSON格式是否正确
- 使用 `Write-JsonOutput` 函数

### 问题3: 前置检查失败

**症状**: 提示前置阶段未完成

**解决**:
- 检查 `.writer/` 目录结构
- 检查 `config.json` 中的阶段状态
- 按顺序完成所有阶段

---

**规则版本**: v1.0  
**最后更新**: 2025-11-02  
**适用范围**: 所有Specify Writer项目

