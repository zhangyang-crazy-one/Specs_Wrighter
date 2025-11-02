# 测试指南

本文档提供七阶段写作工作流程的完整测试指南。

---

## 测试准备

### 1. 环境要求

- **PowerShell**: 版本 5.1 或更高（推荐 7.x）
- **操作系统**: Windows 10/11, macOS, Linux
- **权限**: 需要文件读写权限

### 2. 执行策略设置（Windows）

如果遇到执行策略限制，运行以下命令：

```powershell
# 查看当前执行策略
Get-ExecutionPolicy

# 设置执行策略（以管理员身份运行）
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 3. 测试目录

所有测试项目将创建在 `specify_writer/test-projects/` 目录下。

---

## 自动化测试

### 运行所有测试场景

```powershell
cd specify_writer
.\scripts\powershell\test-workflow.ps1 -Scenario all
```

### 运行单个场景

```powershell
# 学术论文场景
.\scripts\powershell\test-workflow.ps1 -Scenario academic

# 小说场景
.\scripts\powershell\test-workflow.ps1 -Scenario novel

# 剧本场景
.\scripts\powershell\test-workflow.ps1 -Scenario drama
```

### 运行测试并清理

```powershell
.\scripts\powershell\test-workflow.ps1 -Scenario all -CleanUp
```

---

## 手动测试

如果自动化测试失败，可以手动执行以下步骤。

### 场景一：学术论文项目

#### 步骤1: 初始化项目

```powershell
.\scripts\powershell\init-writer-project.ps1 `
    -ProjectName "AI-Ethics-Paper" `
    -ProjectPath "test-projects" `
    -WritingType "学术论文"
```

**验证**:
- 检查 `test-projects/AI-Ethics-Paper/.writer/config.json` 是否存在
- 检查目录结构是否正确

#### 步骤2: 内容调研

```powershell
.\scripts\powershell\conduct-research.ps1 `
    -ProjectDir "test-projects/AI-Ethics-Paper" `
    -Keywords "人工智能伦理,AI安全,算法偏见"
```

**验证**:
- 检查 `research-report.md` 是否生成
- 检查 `research-data.json` 是否生成
- 检查关键词是否正确添加

#### 步骤3: 风格设计

```powershell
.\scripts\powershell\create-design.ps1 `
    -ProjectDir "test-projects/AI-Ethics-Paper"
```

**验证**:
- 检查 `design-document.md` 是否生成
- 检查项目信息是否自动填充

#### 步骤4: 创建宪法

```powershell
.\scripts\powershell\create-constitution.ps1 `
    -ProjectDir "test-projects/AI-Ethics-Paper"
```

**验证**:
- 检查 `constitution.md` 是否生成
- 检查六个核心章节是否完整

#### 步骤5: 创建大纲

```powershell
.\scripts\powershell\create-outline.ps1 `
    -ProjectDir "test-projects/AI-Ethics-Paper" `
    -ChapterCount 5
```

**验证**:
- 检查 `outline.md` 是否生成
- 检查是否有5个章节
- 检查三幕结构划分是否正确

#### 步骤6: 验证合规性

```powershell
.\scripts\powershell\validate-outline.ps1 `
    -ProjectDir "test-projects/AI-Ethics-Paper"
```

**验证**:
- 检查 `validation-report.md` 是否生成
- 检查四大维度是否完整

#### 步骤7: 生成章节

```powershell
.\scripts\powershell\write-chapter.ps1 `
    -ProjectDir "test-projects/AI-Ethics-Paper" `
    -ChapterNumber 1
```

**验证**:
- 检查 `chapter-01.md` 是否生成
- 检查章节模板是否完整

#### 步骤8: 最终导出

```powershell
.\scripts\powershell\finalize-project.ps1 `
    -ProjectDir "test-projects/AI-Ethics-Paper" `
    -ExportFormat "markdown"
```

**验证**:
- 检查 `AI-Ethics-Paper.md` 是否生成
- 检查 `project-stats.json` 是否生成
- 检查文件内容是否正确

---

### 场景二：小说项目

#### 步骤1-8: 类似学术论文，但使用以下参数

```powershell
# 初始化
-ProjectName "Fantasy-Novel"
-WritingType "长篇小说"

# 大纲
-ChapterCount 20
```

---

### 场景三：剧本项目

#### 步骤1-8: 类似学术论文，但使用以下参数

```powershell
# 初始化
-ProjectName "Modern-Drama"
-WritingType "话剧剧本"

# 大纲
-ChapterCount 3
```

---

## 验证清单

### 文件生成验证

对于每个测试项目，验证以下文件是否生成：

```
<项目名称>/
├── .writer/
│   ├── config.json                    ✓
│   ├── research/
│   │   ├── research-report.md         ✓
│   │   └── research-data.json         ✓
│   ├── design/
│   │   └── design-document.md         ✓
│   ├── constitution/
│   │   └── constitution.md            ✓
│   ├── outline/
│   │   └── outline.md                 ✓
│   ├── validation/
│   │   └── validation-report.md       ✓
│   ├── drafts/
│   │   └── chapter-XX.md              ✓
│   └── final/
│       ├── <项目名称>.md              ✓
│       └── project-stats.json         ✓
├── README.md                          ✓
└── .gitignore                         ✓
```

### 编码验证

检查所有生成的文件：

```powershell
# 检查文件编码（应该是UTF-8无BOM）
Get-Content -Path "<文件路径>" -Encoding UTF8 | Out-Null
```

### 格式验证

检查PowerShell脚本输出：

- [ ] 使用 `[完成]` 而非 ✅
- [ ] 使用 `[失败]` 而非 ❌
- [ ] 使用 `[警告]` 而非 ⚠️
- [ ] 使用 `[注意]` 而非 📝

### JSON验证

检查JSON文件格式：

```powershell
# 验证JSON格式
Get-Content -Path "config.json" | ConvertFrom-Json
Get-Content -Path "research-data.json" | ConvertFrom-Json
Get-Content -Path "project-stats.json" | ConvertFrom-Json
```

---

## Augment命令测试

### 验证命令文件

检查所有命令文件是否存在：

```powershell
Get-ChildItem -Path ".augment/commands/writer" -Filter "*.md"
```

**预期输出**:
- init.md
- 1-research.md
- 2-design.md
- 3-constitution.md
- 4-outline.md
- 5-validate.md
- 6-draft.md
- 7-finalize.md

### 验证规则文件

检查规则文件是否存在：

```powershell
Get-ChildItem -Path ".augment/rules" -Filter "*.md"
```

**预期输出**:
- writer-workflow.md
- constitution-principles.md
- validation-rules.md

### 验证Frontmatter

检查每个命令文件的Frontmatter：

```yaml
---
namespace: writer
name: <command-name>
description: <description>
---
```

---

## 错误处理测试

### 测试前置条件检查

```powershell
# 应该失败：在未初始化的项目上运行阶段一
.\scripts\powershell\conduct-research.ps1 -ProjectDir "non-existent-project"

# 应该失败：跳过阶段
.\scripts\powershell\create-design.ps1 -ProjectDir "test-projects/AI-Ethics-Paper"
# （在未完成阶段一的情况下）
```

### 测试参数验证

```powershell
# 应该失败：无效的章节编号
.\scripts\powershell\write-chapter.ps1 -ProjectDir "test-projects/AI-Ethics-Paper" -ChapterNumber 999

# 应该失败：无效的导出格式
.\scripts\powershell\finalize-project.ps1 -ProjectDir "test-projects/AI-Ethics-Paper" -ExportFormat "invalid"
```

---

## 性能测试

记录每个脚本的执行时间：

```powershell
Measure-Command {
    .\scripts\powershell\init-writer-project.ps1 -ProjectName "Test" -ProjectPath "test-projects" -WritingType "学术论文"
}
```

**预期时间**:
- init-writer-project.ps1: < 5秒
- conduct-research.ps1: < 10秒
- create-design.ps1: < 5秒
- create-constitution.ps1: < 5秒
- create-outline.ps1: < 10秒
- validate-outline.ps1: < 5秒
- write-chapter.ps1: < 5秒
- finalize-project.ps1: < 10秒

---

## 清理测试环境

测试完成后，清理测试项目：

```powershell
Remove-Item -Path "test-projects" -Recurse -Force
```

---

## 报告测试结果

将测试结果记录在 `TEST_REPORT.md` 文件中，包括：

1. 测试日期和时间
2. 测试环境信息
3. 每个场景的测试结果
4. 发现的问题
5. 建议和改进

---

## 常见问题

### Q: PowerShell脚本无法执行

**A**: 检查执行策略设置：
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Q: 文件编码不正确

**A**: 确保使用UTF-8编码（无BOM）：
```powershell
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($path, $content, $utf8NoBom)
```

### Q: JSON解析失败

**A**: 检查JSON格式是否正确，使用在线JSON验证工具。

### Q: 路径问题

**A**: 使用绝对路径或确保当前目录正确。

---

## 联系支持

如果遇到问题，请：

1. 检查 `TEST_REPORT.md` 中的常见问题
2. 查看脚本的详细错误信息
3. 检查文件权限和路径
4. 确认PowerShell版本

---

**最后更新**: 2025-11-02 19:00

