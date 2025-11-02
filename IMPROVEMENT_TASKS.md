# Specify Writer 项目标准化改进任务清单

**创建日期**: 2025-11-02  
**目标**: 将 specify_writer 项目改造为符合 .specify 模板、.claude/agents 要求和 .augment 命令标准的完整工具集

---

## 任务总览

- [ ] **阶段一**: PowerShell脚本标准化 (P1 - 必须完成)
- [ ] **阶段二**: Agent描述改进 (P2 - 建议完成)
- [ ] **阶段三**: 命令文件重构 (P1 - 必须完成)
- [ ] **阶段四**: 前置检查机制 (P1 - 必须完成)
- [ ] **阶段五**: 集成测试与部署 (P3 - 长期优化)

---

## 阶段一: PowerShell脚本标准化

### 任务 1.1: 修改 init-writing-project.ps1 添加 JSON 输出

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 添加 `-Json` 参数到脚本参数列表
2. [ ] 创建 JSON 输出对象,包含以下字段:
   - `PROJECT_DIR`: 项目完整路径
   - `CONFIG_FILE`: project-config.json 完整路径
   - `TEMPLATE_FILE`: main.md 完整路径
   - `OUTLINE_FILE`: outline.md 完整路径
   - `GENRE_TYPE`: 文体类型
   - `SPECIFIC_TYPE`: 具体类型
   - `PROJECT_NAME`: 项目名称
   - `CREATED_DATE`: 创建日期
3. [ ] 添加条件判断: 如果 `-Json` 参数存在,输出 JSON 并退出
4. [ ] 测试 JSON 输出格式是否正确
5. [ ] 测试非 JSON 模式是否仍然正常工作

**验收标准**:
```powershell
# 运行命令
.\specify_writer\scripts\powershell\init-writing-project.ps1 `
  -Json `
  -ProjectName "test-project" `
  -GenreType "creative" `
  -SpecificType "novel"

# 期望输出 (JSON格式)
{
  "PROJECT_DIR": "C:\\...\\test-project",
  "CONFIG_FILE": "C:\\...\\test-project\\project-config.json",
  "TEMPLATE_FILE": "C:\\...\\test-project\\main.md",
  "OUTLINE_FILE": "C:\\...\\test-project\\outline.md",
  "GENRE_TYPE": "creative",
  "SPECIFIC_TYPE": "novel",
  "PROJECT_NAME": "test-project",
  "CREATED_DATE": "2025-11-02"
}
```

---

### 任务 1.2: 修改 analyze-style.ps1 添加 JSON 输出

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 检查 analyze-style.ps1 是否存在,如不存在则创建
2. [ ] 添加 `-Json` 参数
3. [ ] 创建 JSON 输出对象,包含:
   - `STYLE_FILE`: 风格文档完整路径
   - `PROJECT_NAME`: 项目名称
   - `ANALYSIS_DATE`: 分析日期
   - `SOURCE_FILE`: 源文件路径 (如果有)
   - `STYLE_FEATURES`: 提取的风格特征摘要
4. [ ] 实现风格分析逻辑 (如果脚本不存在)
5. [ ] 测试 JSON 输出

**验收标准**:
```powershell
.\specify_writer\scripts\powershell\analyze-style.ps1 `
  -Json `
  -ProjectName "test-project" `
  -SourceFile "reference.md"

# 期望输出
{
  "STYLE_FILE": "C:\\...\\writer_style\\test-project_style.md",
  "PROJECT_NAME": "test-project",
  "ANALYSIS_DATE": "2025-11-02",
  "SOURCE_FILE": "C:\\...\\reference.md",
  "STYLE_FEATURES": {
    "tone": "formal",
    "person": "third",
    "tense": "past"
  }
}
```

---

### 任务 1.3: 修改 export-document.ps1 添加 JSON 输出

**优先级**: P1  
**预计时间**: 20分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 检查 export-document.ps1 是否存在,如不存在则创建
2. [ ] 添加 `-Json` 参数
3. [ ] 创建 JSON 输出对象,包含:
   - `OUTPUT_FILE`: 导出文件完整路径
   - `FORMAT`: 导出格式 (pdf/docx/html)
   - `SOURCE_FILE`: 源Markdown文件路径
   - `EXPORT_DATE`: 导出日期
4. [ ] 测试 JSON 输出

---

### 任务 1.4: 创建 common.ps1 公共函数库

**优先级**: P2  
**预计时间**: 45分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 创建 `specify_writer/scripts/powershell/common.ps1`
2. [ ] 实现以下公共函数:
   - `Write-JsonOutput`: 统一的 JSON 输出函数
   - `Test-ProjectExists`: 检查项目是否存在
   - `Get-ProjectConfig`: 读取项目配置文件
   - `Write-Log`: 统一的日志输出函数
   - `Test-FileEncoding`: 检查文件编码是否为 UTF-8 BOM
3. [ ] 在所有脚本中引用 common.ps1
4. [ ] 重构现有脚本使用公共函数

**示例代码**:
```powershell
# common.ps1

function Write-JsonOutput {
    param([hashtable]$Data)
    $json = $Data | ConvertTo-Json -Depth 10 -Compress
    Write-Output $json
}

function Test-ProjectExists {
    param([string]$ProjectPath)
    $configFile = Join-Path $ProjectPath "project-config.json"
    return Test-Path $configFile
}

function Get-ProjectConfig {
    param([string]$ProjectPath)
    $configFile = Join-Path $ProjectPath "project-config.json"
    if (Test-Path $configFile) {
        return Get-Content $configFile | ConvertFrom-Json
    }
    return $null
}
```

---

## 阶段二: Agent描述改进

### 任务 2.1: 改进 universal-writer.md 的 description 字段

**优先级**: P2  
**预计时间**: 30分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 参考 `.claude/agents/fiction-framework-architect.md` 的格式
2. [ ] 在 description 字段中添加详细的使用场景说明
3. [ ] 添加至少 3 个 `<example>` 标签示例
4. [ ] 明确说明何时调用此 Agent
5. [ ] 测试 YAML frontmatter 格式是否正确

**改进模板**:
```yaml
---
name: universal-writer
description: |
  Use this agent when the user needs to create written content across multiple genres (academic, article, creative, professional). Activate when:
  
  - User requests writing academic papers, articles, novels, or professional documents
  - User needs to maintain consistent style across chapters
  - User wants to follow specific writing templates and guidelines
  
  <example>
  Context: User wants to write a research paper
  user: "我需要写一篇关于数据治理的学术论文"
  assistant: "I'll use the universal-writer agent to create this academic paper following the research-paper template and academic writing standards."
  </example>
  
  <example>
  Context: User wants to continue writing a novel
  user: "继续撰写小说的第三章"
  assistant: "Let me invoke the universal-writer agent to write Chapter 3, maintaining the style defined in the style document and following the architecture file."
  </example>
  
  <example>
  Context: User needs to write a technical article
  user: "帮我写一篇关于数据网格架构的技术文章"
  assistant: "I'll activate the universal-writer agent to create a technical article following the article writing guidelines and technical documentation standards."
  </example>
model: sonnet
color: blue
---
```

---

### 任务 2.2: 改进 style-analyzer.md 的 description 字段

**优先级**: P2  
**预计时间**: 20分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 添加详细的使用场景说明
2. [ ] 添加 2-3 个 `<example>` 标签示例
3. [ ] 明确说明何时调用此 Agent

---

### 任务 2.3: 改进 quality-reviewer.md 的 description 字段

**优先级**: P2  
**预计时间**: 20分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 添加详细的使用场景说明
2. [ ] 添加 2-3 个 `<example>` 标签示例
3. [ ] 明确说明何时调用此 Agent

---

## 阶段三: 命令文件重构

### 任务 3.1: 创建 check-writer-prerequisites.ps1 前置检查脚本

**优先级**: P1  
**预计时间**: 60分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 创建 `specify_writer/scripts/powershell/check-writer-prerequisites.ps1`
2. [ ] 实现参数:
   - `-Json`: 输出 JSON 格式
   - `-ProjectPath`: 项目路径 (可选)
   - `-RequireOutline`: 要求大纲文件存在
   - `-RequireStyle`: 要求风格文档存在
3. [ ] 实现检查逻辑:
   - 检查项目目录是否存在
   - 检查 project-config.json 是否存在
   - 检查 main.md 是否存在
   - 检查 outline.md 是否存在 (如果 RequireOutline)
   - 检查风格文档是否存在 (如果 RequireStyle)
4. [ ] 输出 JSON 格式的检查结果
5. [ ] 测试各种场景

**期望输出格式**:
```json
{
  "PROJECT_DIR": "C:\\...\\test-project",
  "PROJECT_EXISTS": true,
  "CONFIG_FILE": "C:\\...\\project-config.json",
  "MAIN_FILE": "C:\\...\\main.md",
  "OUTLINE_FILE": "C:\\...\\outline.md",
  "STYLE_FILE": "C:\\...\\writer_style\\test-project_style.md",
  "AVAILABLE_DOCS": ["config", "main", "outline"],
  "PROJECT_CONFIG": {
    "project_name": "test-project",
    "genre_type": "creative",
    "specific_type": "novel"
  }
}
```

---

### 任务 3.2: 重写 writer.init.md 命令文件

**优先级**: P1  
**预计时间**: 45分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 参考 `.augment/commands/speckit.specify.md` 的格式
2. [ ] 重写命令文件结构:
   - 保留 YAML frontmatter
   - 添加 "User Input" 部分
   - 添加 "Outline" 部分,包含详细的执行步骤
   - 添加脚本调用和 JSON 解析逻辑
3. [ ] 实现参数解析逻辑
4. [ ] 实现错误处理
5. [ ] 添加验收标准

**新文件结构**:
```markdown
---
description: 初始化写作项目,创建项目结构和配置文件
---

## User Input

​```text
$ARGUMENTS
​```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Parse user input**: Extract project name, genre type, specific type from $ARGUMENTS or prompt user
   - If $ARGUMENTS is empty, ask user for:
     - Project name
     - Genre type (academic/article/creative/professional)
     - Specific type (based on genre)
     - Project path (optional, default to current directory)

2. **Validate input**:
   - Check if project name is valid (no special characters)
   - Validate genre type and specific type combination
   - Check if project path exists

3. **Run initialization script**:
   ```powershell
   .\specify_writer\scripts\powershell\init-writing-project.ps1 `
     -Json `
     -ProjectName "[name]" `
     -GenreType "[genre]" `
     -SpecificType "[type]" `
     -ProjectPath "[path]"
   ```

4. **Parse JSON output**: Extract PROJECT_DIR, CONFIG_FILE, TEMPLATE_FILE, OUTLINE_FILE

5. **Report completion**:
   - Output project directory path
   - List created files
   - Suggest next steps (writer.outline or writer.style)

## Error Handling

- If project already exists, ask user to confirm overwrite
- If invalid genre/specific type combination, list valid options
- If script execution fails, report error and suggest fixes

## Next Steps

After successful initialization, suggest:
1. Use `writer.outline` to create writing outline
2. Use `writer.style` to define or analyze writing style
3. Use `writer.draft` to start writing
```

---

### 任务 3.3: 重写 writer.outline.md 命令文件

**优先级**: P1  
**预计时间**: 45分钟  
**状态**: [ ] 未开始

---

### 任务 3.4: 重写 writer.style.md 命令文件

**优先级**: P1  
**预计时间**: 45分钟  
**状态**: [ ] 未开始

---

### 任务 3.5: 重写 writer.draft.md 命令文件

**优先级**: P1  
**预计时间**: 45分钟  
**状态**: [ ] 未开始

---

### 任务 3.6: 重写 writer.review.md 命令文件

**优先级**: P1  
**预计时间**: 45分钟  
**状态**: [ ] 未开始

---

### 任务 3.7: 重写 writer.export.md 命令文件

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始

---

## 阶段四: 前置检查机制

### 任务 4.1: 在所有命令中添加前置检查

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 在 writer.outline.md 中添加项目存在性检查
2. [ ] 在 writer.style.md 中添加项目存在性检查
3. [ ] 在 writer.draft.md 中添加大纲存在性检查
4. [ ] 在 writer.review.md 中添加内容存在性检查
5. [ ] 在 writer.export.md 中添加内容存在性检查

**检查模板**:
```markdown
1. **Check prerequisites**: Run check-writer-prerequisites.ps1
   ```powershell
   .\specify_writer\scripts\powershell\check-writer-prerequisites.ps1 `
     -Json `
     -ProjectPath "[path]" `
     -RequireOutline  # 根据命令需求添加
   ```

2. **Parse JSON and validate**:
   - If PROJECT_EXISTS is false, ERROR "Project not initialized. Run writer.init first."
   - If required files missing, ERROR with specific message
```

---

## 阶段五: 集成测试与部署

### 任务 5.1: 创建完整工作流测试

**优先级**: P3  
**预计时间**: 90分钟  
**状态**: [ ] 未开始

**测试场景**:

1. [ ] 测试学术论文工作流:
   - writer.init (academic, research-paper)
   - writer.outline
   - writer.draft (撰写摘要)
   - writer.draft (撰写引言)
   - writer.review
   - writer.export (pdf)

2. [ ] 测试创意写作工作流:
   - writer.init (creative, novel)
   - writer.style (分析参考文本)
   - writer.outline
   - writer.draft (第一章)
   - writer.review
   
3. [ ] 测试技术文章工作流:
   - writer.init (article, technical-article)
   - writer.outline
   - writer.draft
   - writer.review
   - writer.export (html)

---

### 任务 5.2: 集成到 .augment 目录

**优先级**: P3  
**预计时间**: 60分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 将修改后的命令文件复制到 `.augment/commands/`
2. [ ] 确保命名符合规范: `writer.init.md`, `writer.draft.md` 等
3. [ ] 测试与现有 `speckit.*` 命令的兼容性
4. [ ] 更新 `.augment` 目录的 README (如果有)

---

### 任务 5.3: 创建文档和示例

**优先级**: P3  
**预计时间**: 60分钟  
**状态**: [ ] 未开始

**详细步骤**:

1. [ ] 更新 specify_writer/README.md,添加新的使用说明
2. [ ] 创建完整的使用示例
3. [ ] 创建故障排除指南
4. [ ] 创建最佳实践文档

---

## 进度跟踪

### 总体进度

- **阶段一**: 0/4 任务完成 (0%)
- **阶段二**: 0/3 任务完成 (0%)
- **阶段三**: 0/7 任务完成 (0%)
- **阶段四**: 0/1 任务完成 (0%)
- **阶段五**: 0/3 任务完成 (0%)

**总计**: 0/18 任务完成 (0%)

---

## 优先级说明

- **P1 (必须完成)**: 核心功能,必须完成才能使项目可用
- **P2 (建议完成)**: 重要改进,显著提升用户体验
- **P3 (长期优化)**: 锦上添花,可以后续迭代

---

## 下一步行动

建议按以下顺序执行:

1. **立即开始**: 任务 1.1 (修改 init-writing-project.ps1)
2. **然后**: 任务 3.1 (创建 check-writer-prerequisites.ps1)
3. **接着**: 任务 3.2 (重写 writer.init.md)
4. **测试**: 运行 writer.init 命令,验证完整流程
5. **继续**: 依次完成其他 P1 任务

---

**最后更新**: 2025-11-02  
**维护者**: AI Assistant

