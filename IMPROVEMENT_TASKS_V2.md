# Specify Writer 项目标准化改进任务清单 (V2)

**创建日期**: 2025-11-02  
**更新日期**: 2025-11-02  
**目标**: 将 specify_writer 项目改造为符合跨工具AI编程助手标准的完整工具集

**基于调研**: AI_CODING_TOOLS_RESEARCH.md

---

## 任务总览

- [ ] **阶段零**: 跨工具兼容性标准化 (P1 - 必须完成) - **新增**
- [ ] **阶段一**: PowerShell脚本标准化 (P1 - 必须完成)
- [ ] **阶段二**: Agent描述改进 (P2 - 建议完成)
- [ ] **阶段三**: 命令文件重构 (P1 - 必须完成)
- [ ] **阶段四**: 前置检查机制 (P1 - 必须完成)
- [ ] **阶段五**: 集成测试与部署 (P3 - 长期优化)

**总任务数**: 21个 (新增3个)  
**预计总时间**: 约15小时

---

## 阶段零: 跨工具兼容性标准化 (新增)

### 任务 0.1: 创建 AGENTS.md 主规则文件

**优先级**: P1  
**预计时间**: 45分钟  
**状态**: [ ] 未开始  
**依赖**: AI_CODING_TOOLS_RESEARCH.md

**目标**: 创建符合AGENTS.md开放标准的主规则文件,确保跨工具兼容性(Cursor、Windsurf、Cline、Roo Code等)。

**详细步骤**:

1. [ ] 在项目根目录创建 `AGENTS.md`
2. [ ] 包含以下核心章节:
   - **Setup commands**: 初始化、大纲、起草等命令
   - **Code style**: UTF-8编码、禁用emoji、PowerShell规范
   - **Project structure**: 目录结构说明
   - **Workflow**: 6个命令的执行顺序
   - **Testing**: 测试要求
3. [ ] 参考 AI_CODING_TOOLS_RESEARCH.md 中的示例
4. [ ] 确保内容简洁、可操作

**验收标准**:
- AGENTS.md文件存在于项目根目录
- 包含所有核心章节
- 格式符合AGENTS.md标准(https://agents.md/)
- 内容与项目实际结构一致
- 可被Cursor、Windsurf、Cline等工具读取

**参考示例**:
```markdown
# Specify Writer - 通用写作标准化工具集

## Setup commands
- Initialize project: Use `writer.init` command
- Create outline: Use `writer.outline` command
- Start writing: Use `writer.draft` command

## Code style
- All files use UTF-8 encoding (without BOM)
- No emoji in command output - use text like [完成] [失败]
- PowerShell scripts must include `-Json` parameter

## Workflow
1. writer.init → 2. writer.outline → 3. writer.style → 
4. writer.draft → 5. writer.review → 6. writer.export
```

---

### 任务 0.2: 创建工具特定规则文件

**优先级**: P2  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务 0.1

**目标**: 为Cursor、Windsurf、Cline创建专用规则文件,优化各工具体验。

**详细步骤**:

1. [ ] 创建 `.cursorrules` - 基于AGENTS.md,添加Cursor特定指令
2. [ ] 创建 `.windsurfrules` - 基于AGENTS.md,添加Windsurf特定指令
3. [ ] 创建 `.clinerules` - 基于AGENTS.md,添加Cline Memory Bank指令
4. [ ] 在每个文件中引用AGENTS.md作为基础规则

**验收标准**:
- 三个规则文件都存在于项目根目录
- 每个文件都引用AGENTS.md
- 包含工具特定的优化指令
- 格式符合各工具要求

**示例 .cursorrules**:
```markdown
# Cursor Rules for Specify Writer

See AGENTS.md for base rules.

## Cursor-specific optimizations
- Use Agent Mode for multi-file edits
- Use Composer for complex refactoring
```

---

### 任务 0.3: 强制UTF-8编码和禁用Emoji

**优先级**: P1  
**预计时间**: 20分钟  
**状态**: [ ] 未开始

**目标**: 确保所有文件使用UTF-8编码,所有脚本输出禁用emoji,提升跨平台兼容性。

**详细步骤**:

1. [ ] 检查所有PowerShell脚本的编码
2. [ ] 在每个脚本开头添加:
   ```powershell
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
   ```
3. [ ] 搜索所有emoji使用(✅ ❌ 📝 ⚠️等)
4. [ ] 替换为纯文本:
   - ✅ → `[完成]` 或 `[PASS]`
   - ❌ → `[失败]` 或 `[FAIL]`
   - 📝 → `[注意]` 或 `[NOTE]`
   - ⚠️ → `[警告]` 或 `[WARNING]`
5. [ ] 在所有Markdown文件中也应用相同规则

**验收标准**:
- 所有PowerShell脚本包含UTF-8编码设置
- 所有输出使用纯文本替代emoji
- 在Windows PowerShell和PowerShell Core中测试通过
- JSON输出不包含emoji字符

**原因**:
- Windows PowerShell编码问题
- JSON解析稳定性
- 终端显示一致性
- 跨平台兼容性

---

## 阶段一: PowerShell脚本标准化

### 任务 1.1: 修改 init-writing-project.ps1 添加 JSON 输出

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务 0.3

**目标**: 让脚本支持 `-Json` 参数,输出结构化JSON数据供命令文件解析。

**详细步骤**:

1. [ ] 打开 `specify_writer/scripts/powershell/init-writing-project.ps1`
2. [ ] 在 `param()` 块中添加 `-Json` 开关参数
3. [ ] 确保已包含UTF-8编码设置(任务0.3)
4. [ ] 在脚本末尾添加JSON输出逻辑:
   ```powershell
   if ($Json) {
       $result = @{
           "PROJECT_DIR" = $projectDir
           "CONFIG_FILE" = $configFile
           "TEMPLATE_FILE" = $templateFile
           "OUTLINE_FILE" = $outlineFile
           "GENRE_TYPE" = $genreType
           "SPECIFIC_TYPE" = $specificType
           "PROJECT_NAME" = $projectName
           "CREATED_DATE" = (Get-Date -Format "yyyy-MM-dd")
       }
       $json = $result | ConvertTo-Json -Depth 10 -Compress
       Write-Output $json
   } else {
       Write-Output "[完成] 项目初始化成功"  # 禁用emoji
   }
   ```
5. [ ] 确保非JSON模式下的输出使用纯文本(无emoji)

**验收标准**:
- 运行 `.\init-writing-project.ps1 -Json` 输出有效JSON
- JSON包含所有必需字段
- 非JSON模式输出纯文本(无emoji)
- UTF-8编码正确

---

### 任务 1.2: 修改 analyze-style.ps1 添加 JSON 输出

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务 0.3

**目标**: 让脚本支持 `-Json` 参数,输出风格分析结果。

**详细步骤**:

1. [ ] 添加 `-Json` 参数
2. [ ] 确保UTF-8编码设置
3. [ ] 创建JSON输出对象:
   ```powershell
   if ($Json) {
       $result = @{
           "STYLE_REPORT_FILE" = $styleReportFile
           "GENRE_TYPE" = $genreType
           "SPECIFIC_TYPE" = $specificType
           "ANALYSIS_DATE" = (Get-Date -Format "yyyy-MM-dd")
           "RECOMMENDATIONS" = @($recommendations)
       }
       $json = $result | ConvertTo-Json -Depth 10 -Compress
       Write-Output $json
   } else {
       Write-Output "[完成] 风格分析完成"
   }
   ```

**验收标准**:
- JSON输出包含风格分析结果
- 无emoji输出
- UTF-8编码正确

---

### 任务 1.3: 修改 export-document.ps1 添加 JSON 输出

**优先级**: P1  
**预计时间**: 20分钟  
**状态**: [ ] 未开始  
**依赖**: 任务 0.3

**目标**: 让脚本支持 `-Json` 参数,输出导出结果。

**详细步骤**:

1. [ ] 添加 `-Json` 参数
2. [ ] 确保UTF-8编码设置
3. [ ] 创建JSON输出对象:
   ```powershell
   if ($Json) {
       $result = @{
           "EXPORTED_FILE" = $exportedFile
           "FORMAT" = $format
           "EXPORT_DATE" = (Get-Date -Format "yyyy-MM-dd")
       }
       $json = $result | ConvertTo-Json -Depth 10 -Compress
       Write-Output $json
   } else {
       Write-Output "[完成] 文档导出成功"
   }
   ```

**验收标准**:
- JSON输出包含导出文件路径
- 无emoji输出
- UTF-8编码正确

---

### 任务 1.4: 创建 common.ps1 公共函数库

**优先级**: P2  
**预计时间**: 45分钟  
**状态**: [ ] 未开始

**目标**: 创建公共函数库,避免代码重复。

**详细步骤**:

1. [ ] 创建 `specify_writer/scripts/powershell/common.ps1`
2. [ ] 提取公共函数:
   - `Write-JsonOutput` - 统一JSON输出
   - `Write-StatusMessage` - 统一状态消息(无emoji)
   - `Test-Prerequisites` - 前置条件检查
3. [ ] 在所有脚本中引用:
   ```powershell
   . "$PSScriptRoot\common.ps1"
   ```

**验收标准**:
- common.ps1包含所有公共函数
- 所有脚本成功引用common.ps1
- 代码重复减少

---

## 阶段二: Agent描述改进

### 任务 2.1: 改进 universal-writer.md 的 description 字段

**优先级**: P2  
**预计时间**: 30分钟  
**状态**: [ ] 未开始

**目标**: 添加详细的使用示例和调用触发条件。

**详细步骤**:

1. [ ] 打开 `specify_writer/agents/universal-writer.md`
2. [ ] 在 `description` 字段中添加 `<example>` 标签
3. [ ] 包含至少3个使用场景示例
4. [ ] 明确说明何时调用此Agent

**示例格式**:
```yaml
description: |
  Use this agent when the user needs to create written content...
  
  <example>
  Context: User wants to write a research paper
  user: "我需要写一篇关于数据治理的学术论文"
  assistant: "I'll use the universal-writer agent to help you..."
  </example>
```

**验收标准**:
- description包含至少3个 `<example>` 标签
- 示例涵盖不同文体类型
- 明确说明调用条件

---

### 任务 2.2: 改进 style-analyzer.md 的 description 字段

**优先级**: P2  
**预计时间**: 20分钟  
**状态**: [ ] 未开始

**目标**: 添加风格分析的使用示例。

**详细步骤**:

1. [ ] 打开 `specify_writer/agents/style-analyzer.md`
2. [ ] 添加 `<example>` 标签
3. [ ] 包含风格分析场景示例

**验收标准**:
- description包含至少2个 `<example>` 标签
- 示例展示风格分析流程

---

### 任务 2.3: 改进 quality-reviewer.md 的 description 字段

**优先级**: P2  
**预计时间**: 20分钟  
**状态**: [ ] 未开始

**目标**: 添加质量审查的使用示例。

**详细步骤**:

1. [ ] 打开 `specify_writer/agents/quality-reviewer.md`
2. [ ] 添加 `<example>` 标签
3. [ ] 包含质量审查场景示例

**验收标准**:
- description包含至少2个 `<example>` 标签
- 示例展示质量审查流程

---

## 阶段三: 命令文件重构

### 任务 3.1: 创建 check-writer-prerequisites.ps1 前置检查脚本

**优先级**: P1  
**预计时间**: 60分钟  
**状态**: [ ] 未开始

**目标**: 创建统一的前置条件检查脚本。

**详细步骤**:

1. [ ] 创建 `specify_writer/scripts/powershell/check-writer-prerequisites.ps1`
2. [ ] 实现检查逻辑:
   - 检查项目配置文件是否存在
   - 检查必需的模板文件
   - 检查PowerShell版本
3. [ ] 支持 `-Json` 参数输出检查结果
4. [ ] 无emoji输出

**验收标准**:
- 脚本可独立运行
- JSON输出包含所有检查结果
- 返回明确的成功/失败状态

---

## 下一步行动

**立即开始**: 任务 0.1 - 创建 AGENTS.md 主规则文件

**原因**:
1. AGENTS.md是跨工具兼容性的基础
2. 为后续所有任务提供标准参考
3. 符合行业最佳实践

**预计完成时间**: 45分钟

---

**文档版本**: V2.0  
**最后更新**: 2025-11-02

