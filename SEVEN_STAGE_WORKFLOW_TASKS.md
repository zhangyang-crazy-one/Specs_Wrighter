# 七阶段写作工作流程 - 详细任务清单

**项目**: Specify Writer - 七阶段写作工作流程系统  
**创建日期**: 2025-11-02  
**基于**: 方案二 + 初始化命令  
**参考文档**: 
- `AI_CODING_TOOLS_RESEARCH.md` - AI编程工具调研（Cursor, Windsurf, Cline, AGENTS.md）
- `AUGMENT_CODE_RESEARCH.md` - Augment Code专项调研
- `WORKFLOW_RESEARCH_SUMMARY.md` - Workflow机制调研

---

## 最终命令结构

```
.augment/commands/writer/
├── init.md                # 项目初始化（创建项目结构）
├── 1-research.md          # 阶段一：内容调研与类型确定
├── 2-design.md            # 阶段二：风格与背景设计
├── 3-constitution.md      # 阶段三：创作宪法文件
├── 4-outline.md           # 阶段四：情节设计与大纲编写
├── 5-validate.md          # 阶段五：合规性审查
├── 6-draft.md             # 阶段六：分章节编写
└── 7-finalize.md          # 阶段七：最终审查与导出
```

**调用方式**（Augment Code）:
```bash
/writer:init
/writer:1-research
/writer:2-design
/writer:3-constitution
/writer:4-outline
/writer:5-validate
/writer:6-draft
/writer:7-finalize
```

---

## 总体统计

- **总任务数**: 35个
- **P1任务**: 25个（必须完成）
- **P2任务**: 10个（建议完成）
- **预计总时间**: 35-40小时

---

## 阶段零：基础设施与跨工具兼容性（P1）

### 任务 0.1: 创建 AGENTS.md 主规则文件

**优先级**: P1  
**预计时间**: 45分钟  
**状态**: [ ] 未开始  
**依赖**: AI_CODING_TOOLS_RESEARCH.md, AUGMENT_CODE_RESEARCH.md

**目标**: 创建符合AGENTS.md开放标准的主规则文件，确保跨工具兼容性（Cursor、Windsurf、Cline、Augment Code等）

**参考标准**:
- AGENTS.md开放标准: https://agents.md/
- 参考文档: `AI_CODING_TOOLS_RESEARCH.md` 第四节 "AGENTS.md - 开放标准"

**详细步骤**:

1. [ ] 在项目根目录创建 `AGENTS.md`
2. [ ] 包含以下核心章节:
   - **Project Overview**: 七阶段写作工作流程系统说明
   - **Setup commands**: 8个命令的使用说明
   - **Code style**: UTF-8编码、禁用emoji、PowerShell规范
   - **Project structure**: 目录结构说明
   - **Workflow**: 七阶段执行顺序
   - **Augment Code Integration**: .augment/commands/和.augment/rules/说明
   - **Testing**: 测试要求
3. [ ] 确保内容简洁、可操作
4. [ ] 验证格式符合AGENTS.md标准

**验收标准**:
- [x] AGENTS.md文件存在于项目根目录
- [x] 包含所有核心章节
- [x] 格式符合AGENTS.md标准
- [x] 内容与七阶段工作流一致
- [x] 可被Cursor、Windsurf、Cline、Augment Code读取

**参考示例**:
```markdown
# Specify Writer - 七阶段写作工作流程系统

## Project Overview
A comprehensive writing workflow system with 7 stages:
1. Research & Type Determination
2. Style & Background Design
3. Constitution Creation
4. Outline & Plot Design
5. Compliance Validation
6. Chapter-by-Chapter Writing
7. Final Review & Export

## Setup commands
- Initialize project: `/writer:init` or `auggie command writer:init`
- Start research: `/writer:1-research`
- Create design: `/writer:2-design`
...

## Code style
- All files use UTF-8 encoding (without BOM)
- No emoji in command output - use text like [完成] [失败] [注意] [警告]
- PowerShell scripts must include `-Json` parameter

## Augment Code Integration
- Commands location: `.augment/commands/writer/`
- Rules location: `.augment/rules/`
- Compatible with `.claude/commands/` for Claude Code users
```

---

### 任务 0.2: 创建 .augment/rules/ 规则文件

**优先级**: P1  
**预计时间**: 1.5小时  
**状态**: [ ] 未开始  
**依赖**: AUGMENT_CODE_RESEARCH.md

**目标**: 创建Augment Code专有规则文件，使用Frontmatter配置

**参考标准**:
- Augment Code Rules系统: `AUGMENT_CODE_RESEARCH.md` 第二节
- Frontmatter配置: type (always_apply/agent_requested), description

**详细步骤**:

1. [ ] 创建目录 `.augment/rules/`
2. [ ] 创建 `writer-workflow.md`:
   ```yaml
   ---
   type: always_apply
   ---
   
   # 七阶段写作工作流程规则
   
   - 必须按照顺序执行七个阶段
   - 每个阶段完成后才能进入下一阶段
   - 所有文件使用UTF-8编码（无BOM）
   - 命令行输出禁用emoji，使用[完成][失败][注意][警告]
   ```

3. [ ] 创建 `constitution-principles.md`:
   ```yaml
   ---
   type: agent_requested
   description: Principles for creating and validating writing constitution files
   ---
   
   # 创作宪法文件编写原则
   
   - 宪法文件必须包含核心主题和价值观
   - 定义不可违背的创作原则
   - 明确角色设定规则（如适用）
   - 设定情节发展约束条件
   - 确保风格一致性要求
   ```

4. [ ] 创建 `validation-rules.md`:
   ```yaml
   ---
   type: agent_requested
   description: Rules for compliance validation against constitution
   ---
   
   # 合规性审查规则
   
   - 检查主题一致性
   - 验证风格统一性
   - 确认逻辑连贯性
   - 评估架构完整性
   ```

**验收标准**:
- [x] `.augment/rules/` 目录存在
- [x] 三个规则文件都包含正确的Frontmatter
- [x] `writer-workflow.md` 使用 `type: always_apply`
- [x] 另外两个文件使用 `type: agent_requested` 并包含description
- [x] 内容符合七阶段工作流程要求

---

### 任务 0.3: 创建公共函数库

**优先级**: P1  
**预计时间**: 1小时  
**状态**: [ ] 未开始  
**依赖**: AI_CODING_TOOLS_RESEARCH.md

**目标**: 创建PowerShell公共函数库，确保所有脚本遵循统一标准

**参考标准**:
- PowerShell脚本标准: `AI_CODING_TOOLS_RESEARCH.md` 第三节第4小节
- 编码和输出规范: `AI_CODING_TOOLS_RESEARCH.md` 第三节第5小节

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/common-functions.ps1`
2. [ ] 实现以下函数:
   - `Set-Utf8Encoding`: 设置UTF-8编码（无BOM）
   - `Write-JsonOutput`: 输出JSON格式结果
   - `Write-StatusMessage`: 输出状态消息（禁用emoji）
   - `Test-Prerequisites`: 检查前置条件
   - `Get-ProjectConfig`: 读取项目配置
   - `Set-ProjectConfig`: 更新项目配置

3. [ ] 确保所有函数包含:
   - 参数验证
   - 错误处理
   - 帮助文档

**验收标准**:
- [x] `common-functions.ps1` 文件存在
- [x] 所有6个函数都已实现
- [x] 函数包含完整的帮助文档
- [x] 使用UTF-8编码（无BOM）
- [x] 状态消息使用[完成][失败][注意][警告]而非emoji

**示例代码**:
```powershell
#!/usr/bin/env pwsh

function Set-Utf8Encoding {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $PSDefaultParameterValues['*:Encoding'] = 'utf8'
}

function Write-JsonOutput {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$Data
    )
    $json = $Data | ConvertTo-Json -Depth 10 -Compress
    Write-Output $json
}

function Write-StatusMessage {
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
    
    Write-Output "$prefix $Message"
}
```

---

### 任务 0.4: 创建工具特定配置文件（可选）

**优先级**: P2  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: AI_CODING_TOOLS_RESEARCH.md

**目标**: 为Cursor、Windsurf、Cline创建特定配置文件

**参考标准**:
- Cursor: `AI_CODING_TOOLS_RESEARCH.md` 第一节第1小节
- Windsurf: `AI_CODING_TOOLS_RESEARCH.md` 第一节第2小节
- Cline: `AI_CODING_TOOLS_RESEARCH.md` 第一节第3小节

**详细步骤**:

1. [ ] 创建 `.cursorrules`:
   ```
   # Specify Writer - 七阶段写作工作流程
   
   参考主规则文件: AGENTS.md
   
   ## 核心规则
   - 使用UTF-8编码（无BOM）
   - 禁用emoji输出
   - PowerShell脚本必须支持-Json参数
   ```

2. [ ] 创建 `.windsurfrules`:
   ```markdown
   # Specify Writer Rules
   
   参考: AGENTS.md
   
   - 遵循七阶段工作流程
   - 所有文件UTF-8编码
   - 命令输出使用纯文本
   ```

3. [ ] 创建 `.clinerules`:
   ```markdown
   # Specify Writer
   
   参考: AGENTS.md
   
   七阶段工作流程系统
   ```

**验收标准**:
- [x] 三个配置文件都已创建
- [x] 内容简洁，指向AGENTS.md
- [x] 符合各工具的格式要求

---

## 阶段一：模板文件（P1）

### 任务 1.1: 创建调研报告模板

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始

**目标**: 创建内容调研报告的标准模板

**详细步骤**:

1. [ ] 创建文件 `templates/research-report-template.md`
2. [ ] 包含以下章节:
   - 调研概述
   - 写作类型确定
   - 关键信息提取
   - 参考资料列表
   - 架构框架建议

**验收标准**:
- [x] 模板文件存在
- [x] 包含所有必需章节
- [x] 使用占位符如[PROJECT_NAME], [WRITING_TYPE]
- [x] UTF-8编码（无BOM）

---

### 任务 1.2: 创建设计文档模板

**优先级**: P1  
**预计时间**: 45分钟  
**状态**: [ ] 未开始

**目标**: 创建风格与背景设计文档的标准模板

**详细步骤**:

1. [ ] 创建文件 `templates/design-document-template.md`
2. [ ] 包含以下章节:
   - 历史背景设定
   - 地理信息设定
   - 文字风格规范
   - 叙事视角
   - 修辞手法
   - 背景世界观设定

**验收标准**:
- [x] 模板文件存在
- [x] 包含所有必需章节
- [x] 适用于多种写作类型
- [x] UTF-8编码（无BOM）

---

### 任务 1.3: 创建宪法文件模板

**优先级**: P1  
**预计时间**: 1小时  
**状态**: [ ] 未开始

**目标**: 创建创作宪法文件的标准模板

**详细步骤**:

1. [ ] 创建文件 `templates/constitution-template.md`
2. [ ] 包含以下章节:
   - 核心主题和价值观
   - 不可违背的创作原则
   - 角色设定规则
   - 情节发展约束条件
   - 风格一致性要求
   - 禁止事项清单

**验收标准**:
- [x] 模板文件存在
- [x] 包含所有必需章节
- [x] 清晰定义约束条件
- [x] UTF-8编码（无BOM）

---

### 任务 1.4: 创建验证报告模板

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始

**目标**: 创建合规性审查报告的标准模板

**详细步骤**:

1. [ ] 创建文件 `templates/validation-report-template.md`
2. [ ] 包含以下章节:
   - 审查概述
   - 主题一致性检查
   - 风格统一性检查
   - 逻辑连贯性检查
   - 架构完整性检查
   - 问题清单
   - 修改建议

**验收标准**:
- [x] 模板文件存在
- [x] 包含所有检查项
- [x] 支持通过/不通过判定
- [x] UTF-8编码（无BOM）

---

## 阶段二：PowerShell脚本（P1）

**注意**: 所有PowerShell脚本必须遵循以下标准（参考`AI_CODING_TOOLS_RESEARCH.md`第三节第4小节）:
- 包含`#!/usr/bin/env pwsh`
- 使用`[CmdletBinding()]`
- 设置`$ErrorActionPreference = 'Stop'`
- 调用`Set-Utf8Encoding`函数
- 支持`-Json`参数
- 使用`Write-StatusMessage`输出状态（禁用emoji）

### 任务 2.1: init-writer-project.ps1

**优先级**: P1  
**预计时间**: 1.5小时  
**状态**: [ ] 未开始  
**依赖**: 任务0.3（公共函数库）

**目标**: 创建项目初始化脚本

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/init-writer-project.ps1`
2. [ ] 实现以下功能:
   - 接受参数: `-ProjectName`, `-ProjectPath`, `-Json`
   - 创建项目目录结构（参考项目目录结构图）
   - 生成`config.json`配置文件
   - 复制模板文件到项目
   - 输出JSON结果（如果指定`-Json`）

3. [ ] 包含错误处理和验证

**验收标准**:
- [x] 脚本文件存在
- [x] 支持`-Json`参数
- [x] 创建完整的目录结构
- [x] 生成有效的config.json
- [x] UTF-8编码（无BOM）
- [x] 使用[完成][失败]等文本状态

---

### 任务 2.2: conduct-research.ps1

**优先级**: P1  
**预计时间**: 2小时  
**状态**: [ ] 未开始  
**依赖**: 任务0.3, 任务1.1

**目标**: 创建内容调研脚本

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/conduct-research.ps1`
2. [ ] 实现以下功能:
   - 接受参数: `-ProjectDir`, `-SourceMaterial`, `-Keywords`, `-Json`
   - 从用户材料提取关键信息
   - 基于关键词进行网络调研（可选）
   - 生成research-report.md
   - 输出JSON结果

**验收标准**:
- [x] 脚本文件存在
- [x] 支持`-Json`参数
- [x] 生成research-report.md
- [x] 提取关键信息到keywords.json
- [x] UTF-8编码（无BOM）

---

### 任务 2.3: create-design-document.ps1

**优先级**: P1  
**预计时间**: 1.5小时  
**状态**: [ ] 未开始  
**依赖**: 任务0.3, 任务1.2

**目标**: 创建风格与背景设计脚本

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/create-design-document.ps1`
2. [ ] 实现以下功能:
   - 接受参数: `-ProjectDir`, `-WritingType`, `-Json`
   - 基于调研结果创建设计文档
   - 支持历史背景、地理信息、世界观设定
   - 生成style-guide.md, background.md等
   - 输出JSON结果

**验收标准**:
- [x] 脚本文件存在
- [x] 支持`-Json`参数
- [x] 生成完整的设计文档
- [x] 适配不同写作类型
- [x] UTF-8编码（无BOM）

---

### 任务 2.4: create-constitution.ps1

**优先级**: P1  
**预计时间**: 1.5小时  
**状态**: [ ] 未开始  
**依赖**: 任务0.3, 任务1.3

**目标**: 创建宪法文件生成脚本

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/create-constitution.ps1`
2. [ ] 实现以下功能:
   - 接受参数: `-ProjectDir`, `-Json`
   - 基于调研和设计创建宪法文件
   - 定义核心原则和约束
   - 生成constitution.md
   - 输出JSON结果

**验收标准**:
- [x] 脚本文件存在
- [x] 支持`-Json`参数
- [x] 生成符合模板的宪法文件
- [x] 包含所有必需章节
- [x] UTF-8编码（无BOM）

---

### 任务 2.5: create-outline.ps1

**优先级**: P1  
**预计时间**: 1.5小时  
**状态**: [ ] 未开始  
**依赖**: 任务0.3

**目标**: 创建大纲生成脚本

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/create-outline.ps1`
2. [ ] 实现以下功能:
   - 接受参数: `-ProjectDir`, `-ChapterCount`, `-Json`
   - 创建详细大纲
   - 章节划分和情节设计
   - 生成outline.md和chapters.json
   - 输出JSON结果

**验收标准**:
- [x] 脚本文件存在
- [x] 支持`-Json`参数
- [x] 生成详细大纲
- [x] 包含章节划分和情节设计
- [x] UTF-8编码（无BOM）

---

### 任务 2.6: validate-compliance.ps1

**优先级**: P1  
**预计时间**: 2小时  
**状态**: [ ] 未开始  
**依赖**: 任务0.3, 任务1.4

**目标**: 创建合规性审查脚本

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/validate-compliance.ps1`
2. [ ] 实现以下功能:
   - 接受参数: `-ProjectDir`, `-Json`
   - 检查大纲是否符合宪法
   - 验证主题一致性、风格统一性、逻辑连贯性、架构完整性
   - 生成validation-report.md
   - 输出JSON结果（包含通过/不通过状态）

**验收标准**:
- [x] 脚本文件存在
- [x] 支持`-Json`参数
- [x] 执行所有检查项
- [x] 生成详细的验证报告
- [x] 返回明确的通过/不通过状态
- [x] UTF-8编码（无BOM）

---

### 任务 2.7: generate-chapter.ps1

**优先级**: P1  
**预计时间**: 1.5小时  
**状态**: [ ] 未开始  
**依赖**: 任务0.3

**目标**: 创建章节生成脚本

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/generate-chapter.ps1`
2. [ ] 实现以下功能:
   - 接受参数: `-ProjectDir`, `-ChapterNumber`, `-Json`
   - 按章节生成内容
   - 自动检查符合性
   - 生成chapter-XX.md
   - 输出JSON结果

**验收标准**:
- [x] 脚本文件存在
- [x] 支持`-Json`参数
- [x] 生成符合大纲的章节内容
- [x] 自动检查符合性
- [x] UTF-8编码（无BOM）

---

### 任务 2.8: finalize-document.ps1

**优先级**: P1  
**预计时间**: 2小时  
**状态**: [ ] 未开始  
**依赖**: 任务0.3

**目标**: 创建最终审查与导出脚本

**详细步骤**:

1. [ ] 创建文件 `scripts/powershell/finalize-document.ps1`
2. [ ] 实现以下功能:
   - 接受参数: `-ProjectDir`, `-ExportFormat`, `-Json`
   - 最终审查全文
   - 导出多种格式（PDF、Word、Markdown、EPUB）
   - 生成元数据metadata.json
   - 输出JSON结果

**验收标准**:
- [x] 脚本文件存在
- [x] 支持`-Json`参数
- [x] 支持多种导出格式
- [x] 生成元数据文件
- [x] UTF-8编码（无BOM）

---

## 阶段三：命令文件（P1）

**注意**: 所有命令文件必须遵循Augment Code标准（参考`AUGMENT_CODE_RESEARCH.md`第三节）:
- 包含Frontmatter (description, argument-hint, model可选)
- 包含前置条件检查
- 调用PowerShell脚本并传递`-Json`参数
- 解析JSON输出
- 提供下一步建议

### 任务 3.1: writer/init.md

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务2.1

**目标**: 创建项目初始化命令

**参考标准**:
- Augment Code命令格式: `AUGMENT_CODE_RESEARCH.md` 第三节第2小节
- 命令文件示例: `.augment/commands/speckit.specify.md`

**详细步骤**:

1. [ ] 创建文件 `.augment/commands/writer/init.md`
2. [ ] 编写Frontmatter:
   ```yaml
   ---
   description: Initialize a new writing project with 7-stage workflow structure
   argument-hint: <project-name> [project-path]
   ---
   ```

3. [ ] 编写命令内容:
   - 用户输入章节（项目名称、路径）
   - 前置条件检查
   - 调用`init-writer-project.ps1 -Json`
   - 解析JSON输出
   - 显示创建的目录结构
   - 建议下一步: `/writer:1-research`

**验收标准**:
- [x] 命令文件存在于`.augment/commands/writer/`
- [x] Frontmatter格式正确
- [x] 包含完整的执行流程
- [x] 提供下一步建议
- [x] UTF-8编码（无BOM）

---

### 任务 3.2: writer/1-research.md

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务2.2

**目标**: 创建内容调研命令

**详细步骤**:

1. [ ] 创建文件 `.augment/commands/writer/1-research.md`
2. [ ] 编写Frontmatter:
   ```yaml
   ---
   description: Stage 1 - Conduct research and determine writing type
   argument-hint: <project-dir> [source-material] [keywords]
   ---
   ```

3. [ ] 编写命令内容:
   - 检查项目是否已初始化
   - 接受用户材料或关键词
   - 调用`conduct-research.ps1 -Json`
   - 解析JSON输出
   - 显示调研结果摘要
   - 建议下一步: `/writer:2-design`

**验收标准**:
- [x] 命令文件存在
- [x] 检查前置条件（项目已初始化）
- [x] 支持多种输入方式
- [x] 提供下一步建议
- [x] UTF-8编码（无BOM）

---

### 任务 3.3: writer/2-design.md

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务2.3

**目标**: 创建风格与背景设计命令

**详细步骤**:

1. [ ] 创建文件 `.augment/commands/writer/2-design.md`
2. [ ] 编写Frontmatter:
   ```yaml
   ---
   description: Stage 2 - Create style and background design documents
   argument-hint: <project-dir> <writing-type>
   ---
   ```

3. [ ] 编写命令内容:
   - 检查阶段一是否完成
   - 接受写作类型参数
   - 调用`create-design-document.ps1 -Json`
   - 解析JSON输出
   - 显示设计文档摘要
   - 建议下一步: `/writer:3-constitution`

**验收标准**:
- [x] 命令文件存在
- [x] 检查前置条件（阶段一完成）
- [x] 适配不同写作类型
- [x] 提供下一步建议
- [x] UTF-8编码（无BOM）

---

### 任务 3.4: writer/3-constitution.md

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务2.4

**目标**: 创建宪法文件生成命令

**详细步骤**:

1. [ ] 创建文件 `.augment/commands/writer/3-constitution.md`
2. [ ] 编写Frontmatter:
   ```yaml
   ---
   description: Stage 3 - Create writing constitution file with core principles
   argument-hint: <project-dir>
   ---
   ```

3. [ ] 编写命令内容:
   - 检查阶段二是否完成
   - 调用`create-constitution.ps1 -Json`
   - 解析JSON输出
   - 显示宪法文件摘要
   - 建议下一步: `/writer:4-outline`

**验收标准**:
- [x] 命令文件存在
- [x] 检查前置条件（阶段二完成）
- [x] 生成符合标准的宪法文件
- [x] 提供下一步建议
- [x] UTF-8编码（无BOM）

---

### 任务 3.5: writer/4-outline.md

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务2.5

**目标**: 创建大纲编写命令

**详细步骤**:

1. [ ] 创建文件 `.augment/commands/writer/4-outline.md`
2. [ ] 编写Frontmatter:
   ```yaml
   ---
   description: Stage 4 - Design plot and create detailed outline
   argument-hint: <project-dir> [chapter-count]
   ---
   ```

3. [ ] 编写命令内容:
   - 检查阶段三是否完成
   - 接受章节数量参数
   - 调用`create-outline.ps1 -Json`
   - 解析JSON输出
   - 显示大纲摘要
   - 建议下一步: `/writer:5-validate`

**验收标准**:
- [x] 命令文件存在
- [x] 检查前置条件（阶段三完成）
- [x] 生成详细大纲
- [x] 提供下一步建议
- [x] UTF-8编码（无BOM）

---

### 任务 3.6: writer/5-validate.md

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务2.6

**目标**: 创建合规性审查命令

**详细步骤**:

1. [ ] 创建文件 `.augment/commands/writer/5-validate.md`
2. [ ] 编写Frontmatter:
   ```yaml
   ---
   description: Stage 5 - Validate outline compliance against constitution
   argument-hint: <project-dir>
   ---
   ```

3. [ ] 编写命令内容:
   - 检查阶段四是否完成
   - 调用`validate-compliance.ps1 -Json`
   - 解析JSON输出
   - 显示验证结果（通过/不通过）
   - 如果不通过，建议返回: `/writer:4-outline`
   - 如果通过，建议下一步: `/writer:6-draft`

**验收标准**:
- [x] 命令文件存在
- [x] 检查前置条件（阶段四完成）
- [x] 显示详细的验证结果
- [x] 根据结果提供不同建议
- [x] UTF-8编码（无BOM）

---

### 任务 3.7: writer/6-draft.md

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务2.7

**目标**: 创建章节编写命令

**详细步骤**:

1. [ ] 创建文件 `.augment/commands/writer/6-draft.md`
2. [ ] 编写Frontmatter:
   ```yaml
   ---
   description: Stage 6 - Generate chapter content based on outline
   argument-hint: <project-dir> <chapter-number>
   ---
   ```

3. [ ] 编写命令内容:
   - 检查阶段五是否通过
   - 接受章节编号参数
   - 调用`generate-chapter.ps1 -Json`
   - 解析JSON输出
   - 显示章节生成结果
   - 建议继续编写下一章或进入: `/writer:7-finalize`

**验收标准**:
- [x] 命令文件存在
- [x] 检查前置条件（阶段五通过）
- [x] 支持逐章编写
- [x] 提供下一步建议
- [x] UTF-8编码（无BOM）

---

### 任务 3.8: writer/7-finalize.md

**优先级**: P1  
**预计时间**: 30分钟  
**状态**: [ ] 未开始  
**依赖**: 任务2.8

**目标**: 创建最终审查与导出命令

**详细步骤**:

1. [ ] 创建文件 `.augment/commands/writer/7-finalize.md`
2. [ ] 编写Frontmatter:
   ```yaml
   ---
   description: Stage 7 - Final review and export document in multiple formats
   argument-hint: <project-dir> [export-format]
   ---
   ```

3. [ ] 编写命令内容:
   - 检查所有章节是否完成
   - 接受导出格式参数（PDF/Word/Markdown/EPUB）
   - 调用`finalize-document.ps1 -Json`
   - 解析JSON输出
   - 显示导出结果和文件位置
   - 祝贺完成七阶段工作流程

**验收标准**:
- [x] 命令文件存在
- [x] 检查前置条件（所有章节完成）
- [x] 支持多种导出格式
- [x] 显示最终结果
- [x] UTF-8编码（无BOM）

---

## 阶段四：知识库与记忆系统（P2）

**参考标准**:
- Cline Memory Bank: `AI_CODING_TOOLS_RESEARCH.md` 第一节第3小节
- Windsurf Memories: `AI_CODING_TOOLS_RESEARCH.md` 第一节第2小节

### 任务 4.1: 创建写作类型知识库

**优先级**: P2
**预计时间**: 1小时
**状态**: [ ] 未开始

**目标**: 创建各种写作类型的知识库文档

**详细步骤**:

1. [ ] 创建文件 `memory/writing-types.md`
2. [ ] 包含以下写作类型:
   - 学术论文（研究论文、综述论文、学位论文）
   - 研究报告（技术报告、调研报告）
   - 小说（长篇小说、中篇小说、短篇小说）
   - 人物传记（自传、他传）
   - 长篇诗歌（史诗、叙事诗）
   - 剧本（话剧、电影剧本、电视剧本）
   - 歌剧（歌剧剧本、音乐剧）

3. [ ] 每种类型包含:
   - 定义和特点
   - 结构要求
   - 风格规范
   - 常见模式

**验收标准**:
- [x] 知识库文件存在
- [x] 包含所有主要写作类型
- [x] 每种类型有详细说明
- [x] UTF-8编码（无BOM）

---

### 任务 4.2: 创建风格模式知识库

**优先级**: P2
**预计时间**: 1小时
**状态**: [ ] 未开始

**目标**: 创建各种写作风格的知识库文档

**详细步骤**:

1. [ ] 创建文件 `memory/style-patterns.md`
2. [ ] 包含以下风格维度:
   - 叙事视角（第一人称、第三人称全知、第三人称限知）
   - 语言风格（正式、非正式、学术、文学）
   - 修辞手法（比喻、拟人、排比、对比）
   - 时态使用（现在时、过去时、混合时态）
   - 语气基调（严肃、幽默、讽刺、抒情）

3. [ ] 每种风格包含:
   - 定义和示例
   - 适用场景
   - 注意事项

**验收标准**:
- [x] 知识库文件存在
- [x] 包含所有主要风格维度
- [x] 每种风格有示例
- [x] UTF-8编码（无BOM）

---

### 任务 4.3: 创建验证检查清单

**优先级**: P2
**预计时间**: 45分钟
**状态**: [ ] 未开始

**目标**: 创建合规性审查的详细检查清单

**详细步骤**:

1. [ ] 创建文件 `memory/validation-checklist.md`
2. [ ] 包含以下检查项:
   - **主题一致性检查**:
     - 核心主题是否贯穿全文
     - 价值观是否一致
   - **风格统一性检查**:
     - 叙事视角是否统一
     - 语言风格是否一致
     - 修辞手法是否协调
   - **逻辑连贯性检查**:
     - 情节发展是否合理
     - 因果关系是否清晰
     - 时间线是否一致
   - **架构完整性检查**:
     - 章节结构是否完整
     - 起承转合是否清晰
     - 结局是否呼应开头

**验收标准**:
- [x] 检查清单文件存在
- [x] 包含所有检查维度
- [x] 每项检查有明确标准
- [x] UTF-8编码（无BOM）

---

## 阶段五：Agent优化（P2）

**参考标准**:
- Agent文件格式: `.claude/agents/` 目录下的现有Agent文件
- Description字段要求: 包含`<example>`标签和详细使用示例

### 任务 5.1: 创建/更新 Agents

**优先级**: P2
**预计时间**: 3小时
**状态**: [ ] 未开始

**目标**: 创建7个专门的Agent，对应七阶段工作流程

**详细步骤**:

1. [ ] 创建 `agents/research-specialist.md`:
   - 专长: 内容调研与信息提取
   - 技能: 关键词分析、资料整理、类型判断
   - 包含`<example>`标签示例

2. [ ] 创建 `agents/design-architect.md`:
   - 专长: 风格与背景设计
   - 技能: 世界观构建、风格规范制定
   - 包含`<example>`标签示例

3. [ ] 创建 `agents/constitution-writer.md`:
   - 专长: 创作宪法文件编写
   - 技能: 原则定义、约束条件设定
   - 包含`<example>`标签示例

4. [ ] 创建 `agents/outline-planner.md`:
   - 专长: 大纲规划与情节设计
   - 技能: 章节划分、情节推进、转折点设计
   - 包含`<example>`标签示例

5. [ ] 创建 `agents/compliance-validator.md`:
   - 专长: 合规性审查
   - 技能: 一致性检查、逻辑验证
   - 包含`<example>`标签示例

6. [ ] 创建 `agents/content-writer.md`:
   - 专长: 章节内容编写
   - 技能: 根据大纲生成内容、保持风格一致
   - 包含`<example>`标签示例

7. [ ] 创建 `agents/quality-reviewer.md`:
   - 专长: 最终质量审查
   - 技能: 全文审查、格式导出
   - 包含`<example>`标签示例

**验收标准**:
- [x] 7个Agent文件都已创建
- [x] 每个Agent包含完整的Frontmatter
- [x] Description字段包含`<example>`标签
- [x] 示例包含context/user/assistant对话
- [x] UTF-8编码（无BOM）

**示例格式**:
```yaml
---
name: Research Specialist
description: |
  Specializes in content research and information extraction for writing projects.

  <example>
  <context>
  User is starting a new historical novel project about the Ming Dynasty.
  </context>
  <user>
  I want to write a historical novel set in the Ming Dynasty. Can you help me research?
  </user>
  <assistant>
  I'll help you conduct research for your Ming Dynasty novel. Let me:
  1. Extract key historical periods and events
  2. Identify important figures and locations
  3. Analyze cultural and social context
  4. Suggest architectural and geographical details

  Let's start with: What specific period of the Ming Dynasty interests you most?
  </assistant>
  </example>
---
```

---

## 阶段六：测试与集成（P1）

### 任务 6.1: 完整工作流测试

**优先级**: P1
**预计时间**: 4小时
**状态**: [ ] 未开始
**依赖**: 所有P1任务完成

**目标**: 测试完整的七阶段工作流程

**测试场景**:

#### 场景一: 学术论文项目（1.5小时）

1. [ ] 执行 `/writer:init` 创建项目 "AI-Ethics-Paper"
2. [ ] 执行 `/writer:1-research` 提供关键词 "人工智能伦理"
3. [ ] 执行 `/writer:2-design` 指定类型 "学术论文"
4. [ ] 执行 `/writer:3-constitution` 创建宪法文件
5. [ ] 执行 `/writer:4-outline` 创建5章大纲
6. [ ] 执行 `/writer:5-validate` 验证合规性
7. [ ] 执行 `/writer:6-draft` 生成第1章
8. [ ] 执行 `/writer:7-finalize` 导出PDF格式
9. [ ] 验证所有文件生成正确

#### 场景二: 小说项目（1.5小时）

1. [ ] 执行 `/writer:init` 创建项目 "Fantasy-Novel"
2. [ ] 执行 `/writer:1-research` 提供素材文件
3. [ ] 执行 `/writer:2-design` 指定类型 "长篇小说"
4. [ ] 执行 `/writer:3-constitution` 创建宪法文件
5. [ ] 执行 `/writer:4-outline` 创建20章大纲
6. [ ] 执行 `/writer:5-validate` 验证合规性
7. [ ] 执行 `/writer:6-draft` 生成第1-3章
8. [ ] 执行 `/writer:7-finalize` 导出EPUB格式
9. [ ] 验证所有文件生成正确

#### 场景三: 剧本项目（1小时）

1. [ ] 执行 `/writer:init` 创建项目 "Modern-Drama"
2. [ ] 执行 `/writer:1-research` 提供关键词 "都市情感剧"
3. [ ] 执行 `/writer:2-design` 指定类型 "话剧剧本"
4. [ ] 执行 `/writer:3-constitution` 创建宪法文件
5. [ ] 执行 `/writer:4-outline` 创建3幕大纲
6. [ ] 执行 `/writer:5-validate` 验证合规性
7. [ ] 执行 `/writer:6-draft` 生成第1幕
8. [ ] 执行 `/writer:7-finalize` 导出Word格式
9. [ ] 验证所有文件生成正确

**验收标准**:
- [x] 所有三个场景都成功完成
- [x] 所有命令都正常执行
- [x] 所有JSON输出都正确解析
- [x] 所有文件都正确生成
- [x] 导出格式都正确
- [x] 没有编码问题
- [x] 没有emoji输出

---

### 任务 6.2: 集成到.augment目录并验证

**优先级**: P1
**预计时间**: 1小时
**状态**: [ ] 未开始
**依赖**: 任务6.1

**目标**: 确保所有命令在Augment Code中可用

**详细步骤**:

1. [ ] 验证目录结构:
   ```
   .augment/
   ├── commands/
   │   └── writer/
   │       ├── init.md
   │       ├── 1-research.md
   │       ├── 2-design.md
   │       ├── 3-constitution.md
   │       ├── 4-outline.md
   │       ├── 5-validate.md
   │       ├── 6-draft.md
   │       └── 7-finalize.md
   └── rules/
       ├── writer-workflow.md
       ├── constitution-principles.md
       └── validation-rules.md
   ```

2. [ ] 使用Auggie CLI验证命令:
   ```bash
   auggie command list
   ```
   应该显示所有8个writer命令

3. [ ] 测试命令行执行:
   ```bash
   auggie command writer:init
   auggie command writer:1-research
   ```

4. [ ] 验证规则文件加载:
   - 检查`writer-workflow.md`是否自动应用
   - 检查`constitution-principles.md`是否在相关场景触发

**验收标准**:
- [x] 所有命令文件在正确位置
- [x] `auggie command list`显示所有命令
- [x] 命令行执行成功
- [x] 规则文件正确加载
- [x] Namespacing正常工作

---

## 阶段七：文档与示例（P2）

### 任务 7.1: 创建用户文档

**优先级**: P2
**预计时间**: 2小时
**状态**: [ ] 未开始

**目标**: 创建完整的用户使用指南

**详细步骤**:

1. [ ] 创建文件 `docs/USER_GUIDE.md`
2. [ ] 包含以下章节:
   - **简介**: 七阶段工作流程概述
   - **快速开始**: 5分钟快速上手
   - **详细教程**: 每个阶段的详细说明
   - **命令参考**: 所有8个命令的参数说明
   - **常见问题**: FAQ
   - **故障排除**: 常见错误和解决方案
   - **最佳实践**: 使用建议

3. [ ] 包含截图和示例输出

**验收标准**:
- [x] 用户指南文件存在
- [x] 包含所有章节
- [x] 有实际示例
- [x] UTF-8编码（无BOM）

---

### 任务 7.2: 创建示例项目

**优先级**: P2
**预计时间**: 2小时
**状态**: [ ] 未开始

**目标**: 创建完整的示例项目供用户参考

**详细步骤**:

1. [ ] 创建 `examples/sample-novel/`:
   - 完整的小说项目示例
   - 包含所有七个阶段的输出文件
   - README说明如何使用

2. [ ] 创建 `examples/sample-paper/`:
   - 完整的学术论文项目示例
   - 包含所有七个阶段的输出文件
   - README说明如何使用

3. [ ] 创建 `examples/sample-screenplay/`:
   - 完整的剧本项目示例
   - 包含所有七个阶段的输出文件
   - README说明如何使用

**验收标准**:
- [x] 三个示例项目都已创建
- [x] 每个项目包含完整的七阶段输出
- [x] 每个项目有README说明
- [x] UTF-8编码（无BOM）

---

## 执行计划

### Week 1: 基础设施（Day 1-3）
- **Day 1**: 任务0.1-0.3（AGENTS.md、.augment/rules/、公共函数库）
- **Day 2**: 任务1.1-1.4（4个模板文件）
- **Day 3**: 任务2.1-2.2（初始化和调研脚本）

### Week 2: 核心脚本（Day 4-7）
- **Day 4**: 任务2.3-2.4（设计和宪法脚本）
- **Day 5**: 任务2.5-2.6（大纲和验证脚本）
- **Day 6**: 任务2.7-2.8（草稿和最终化脚本）
- **Day 7**: 任务3.1-3.4（前4个命令文件）

### Week 3: 命令与测试（Day 8-10）
- **Day 8**: 任务3.5-3.8（后4个命令文件）
- **Day 9**: 任务6.1（完整工作流测试 - 3个场景）
- **Day 10**: 任务6.2（集成到.augment并验证）

### Week 4: 优化与文档（Day 11-14）
- **Day 11**: 任务4.1-4.3（知识库文件）
- **Day 12-13**: 任务5.1（7个Agent文件）
- **Day 14**: 任务7.1-7.2（用户文档和示例项目）

---

## 关键里程碑

### 里程碑1: 基础设施完成（Day 3结束）
- [x] AGENTS.md创建
- [x] .augment/rules/创建
- [x] 公共函数库创建
- [x] 4个模板文件创建
- [x] 初始化和调研脚本创建

### 里程碑2: 核心功能完成（Day 8结束）
- [x] 所有8个PowerShell脚本创建
- [x] 所有8个命令文件创建
- [x] 支持完整的七阶段工作流程

### 里程碑3: 测试通过（Day 10结束）
- [x] 三个测试场景全部通过
- [x] 集成到.augment目录
- [x] Auggie CLI验证通过

### 里程碑4: 文档完善（Day 14结束）
- [x] 知识库文件创建
- [x] 7个Agent文件创建
- [x] 用户文档创建
- [x] 示例项目创建

---

## 下一步行动

**立即开始**: 任务0.1 - 创建AGENTS.md主规则文件

**原因**:
1. AGENTS.md是跨工具兼容性的基础
2. 为后续所有任务提供标准参考
3. 符合行业最佳实践（20,000+项目使用）
4. 明确定义七阶段工作流程

**预计完成时间**: 45分钟

---

## 参考文档索引

所有任务执行时必须参考以下调研文档:

1. **AI_CODING_TOOLS_RESEARCH.md** - AI编程工具综合调研
   - Cursor规则和Agent系统
   - Windsurf规则、Workflows和Memories
   - Cline规则和Memory Bank
   - AGENTS.md开放标准

2. **AUGMENT_CODE_RESEARCH.md** - Augment Code专项调研
   - Rules系统（Frontmatter配置）
   - Commands系统（Namespacing、命令行集成）
   - 跨工具兼容性

3. **WORKFLOW_RESEARCH_SUMMARY.md** - Workflow机制调研
   - Windsurf声明式Workflows
   - Cursor Agent Mode
   - Cline任务管理
   - 混合工作流方案

---

**文档版本**: v2.0
**最后更新**: 2025-11-02
**总任务数**: 35个（P1: 25个，P2: 10个）
**预计总时间**: 35-40小时

