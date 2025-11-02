# AI编程工具Rules和Agent系统调研报告

**调研日期**: 2025-11-02  
**调研目的**: 确保 specify_writer 项目的命令系统具有跨工具适用性

---

## 执行摘要

本调研分析了主流AI编程工具(Cursor、Windsurf、Cline、Roo Code等)的规则系统和工作流机制,为 specify_writer 项目提供标准化建议。

**核心发现**:
1. **AGENTS.md** 正在成为AI编程助手的开放标准
2. **.cursorrules** 和 **.windsurfrules** 是项目级配置的主流格式
3. **Workflow** 机制在各工具中实现方式不同,但概念相似
4. **Memory Bank** 是跨会话上下文管理的有效模式

---

## 一、主流AI编程工具对比

### 0. Augment Code (重要补充)

**官方文档**: https://docs.augmentcode.com/

#### Rules系统

**文件格式**:
- `.augment/rules/*.md` - 项目级规则文件(支持子目录)
- `~/.augment/rules/*.md` - 全局用户规则
- **兼容性**: 支持 `CLAUDE.md` 和 `AGENTS.md`

**规则优先级**:
```
用户聊天提示 (最高优先级)
  ↓
自定义规则文件 (--rules flag)
  ↓
CLAUDE.md
  ↓
AGENTS.md
  ↓
.augment/guidelines.md (legacy)
  ↓
.augment/rules/*.md (递归搜索)
```

**Frontmatter支持**:
```yaml
---
type: always_apply  # 或 agent_requested
description: "规则描述(agent_requested必需)"
---
```

**规则类型**:
- **always_apply**: 自动包含在每个用户提示中
- **agent_requested**: AI根据description自动判断是否相关
- **manual**: 仅IDE支持,CLI不支持(通过@提及选择性附加)

**示例规则文件**:
```markdown
---
type: always_apply
---

# TypeScript Guidelines

- Use strict mode in all TypeScript files
- Define explicit return types for all functions
- Avoid using `any` type unless absolutely necessary
```

#### Custom Commands系统

**文件位置**(优先级顺序):
1. `~/.augment/commands/<name>.md` - 用户级命令
2. `./.augment/commands/<name>.md` - 工作区命令
3. `./.claude/commands/<name>.md` - Claude Code兼容

**命令格式**:
```markdown
---
description: 命令简短描述
argument-hint: [expected-args]
model: gpt-4o  # 可选,覆盖CLI默认模型
---

命令提示内容...
```

**Namespacing支持**:
- 子目录组织: `.augment/commands/frontend/component.md`
- 调用方式: `/frontend:component`

**命令行执行**:
```bash
# 执行自定义命令
auggie command deploy-staging

# 列出所有命令
auggie command list
```

**特点**:
- ✅ 支持CLAUDE.md和AGENTS.md(跨工具兼容)
- ✅ Frontmatter配置(type, description, model)
- ✅ 命令行和交互式两种执行方式
- ✅ 子目录命名空间
- ✅ 与Claude Code完全兼容

---

### 1. Cursor

**官方文档**: https://cursor.com/docs/context/rules

#### Rules系统

**文件格式**:
- `.cursorrules` - 项目级规则文件(放在项目根目录)
- User Rules - 全局用户规则(通过设置界面配置)

**规则层级**:
```
用户聊天提示 (最高优先级)
  ↓
.cursorrules (项目级)
  ↓
User Rules (全局)
```

**示例 .cursorrules 文件**:
```markdown
# Project Rules for React + TypeScript

## Code Style
- Use TypeScript strict mode
- Single quotes, no semicolons
- Use functional components with hooks

## Testing
- Write tests for all new features
- Use Jest and React Testing Library

## File Organization
- Components in src/components/
- Utilities in src/utils/
- Tests co-located with source files
```

**特点**:
- ✅ 简单的Markdown格式
- ✅ 支持文件模式匹配
- ✅ 可以包含Git commit message规则
- ✅ 与Agent Mode和Composer集成

**参考资源**:
- awesome-cursorrules: https://github.com/PatrickJS/awesome-cursorrules
- 包含200+个不同技术栈的规则示例

---

### 2. Windsurf (Codeium)

**官方文档**: https://docs.windsurf.com/windsurf/cascade/cascade

#### Rules系统

**文件格式**:
- `.windsurfrules` - 项目级规则
- `global_rules.md` - 全局规则(~/.codeium/windsurf/memories/)

**Cascade Agent特性**:
- 主动执行规则,而不仅仅是参考
- 支持Rules、Workflows、Memories三位一体

#### Workflows系统

**文件格式**: YAML格式的工作流定义

**示例 Workflow**:
```yaml
name: Test & Lint
on:
  manual: true
  push: true
  pull_request: true

jobs:
  setup:
    steps:
      - name: Setup Python 3.11 venv
        run: |
          python3.11 -m venv .venv
          source .venv/bin/activate
      - name: Install dependencies
        run: |
          pip install --upgrade pip
          pip install -r requirements.txt
  
  lint:
    needs: setup
    steps:
      - name: Run flake8 linter
        run: |
          source .venv/bin/activate
          flake8 .
  
  test:
    needs: lint
    steps:
      - name: Run pytest
        run: |
          source .venv/bin/activate
          pytest
```

**Workflow vs GitHub Actions**:
| 特性 | Windsurf Workflows | GitHub Actions |
|------|-------------------|----------------|
| 执行位置 | 本地IDE | 云端Runner |
| AI集成 | 原生支持 | 需要额外配置 |
| 上下文感知 | 读取Rules和Memories | 仅Repository上下文 |
| 适用场景 | 本地开发自动化 | CI/CD部署 |

#### Memories系统

**存储位置**: `~/.codeium/windsurf/memories/`

**文件类型**:
- `user_stories.md` - 用户故事
- `traceability_matrix.md` - 需求追溯矩阵
- `architectural_decisions.md` - 架构决策记录

**特点**:
- ✅ 跨会话持久化上下文
- ✅ 支持审计和追溯
- ✅ 新成员快速上手

---

### 3. Cline (VSCode Extension)

**官方文档**: https://docs.cline.bot/prompting/cline-memory-bank

#### Memory Bank系统

**核心概念**: 结构化文档系统,维护跨会话上下文

**文件结构**:
```
memory-bank/
├── projectbrief.md          # 项目基础
├── productContext.md        # 产品上下文
├── activeContext.md         # 当前工作焦点
├── systemPatterns.md        # 系统架构
├── techContext.md           # 技术栈
└── progress.md              # 进度跟踪
```

**工作流程**:
1. 用户: "follow your custom instructions"
2. Cline读取Memory Bank文件
3. 重建项目上下文
4. 继续工作

**Custom Instructions vs .clinerules**:
- **Custom Instructions**: 全局应用,所有项目
- **.clinerules**: 项目特定,存储在仓库中

**示例 .clinerules**:
```markdown
# Cline's Memory Bank

I am Cline, an expert software engineer with a unique characteristic: 
my memory resets completely between sessions.

## Memory Bank Structure

The Memory Bank consists of core files and optional context files, 
all in Markdown format.

### Core Files (Required)
1. `projectbrief.md` - Foundation document
2. `productContext.md` - Why this project exists
3. `activeContext.md` - Current work focus
4. `systemPatterns.md` - System architecture
5. `techContext.md` - Technologies used
6. `progress.md` - What works and what's left

## Core Workflows

### Plan Mode
Start in this mode for strategy discussions.

### Act Mode
Use this for implementation and executing tasks.

## Key Commands
- "follow your custom instructions" - Read Memory Bank
- "initialize memory bank" - Start new project
- "update memory bank" - Trigger documentation review
```

**特点**:
- ✅ 明确的文件层级结构
- ✅ 跨工具可移植(纯Markdown)
- ✅ 自文档化项目
- ✅ 支持上下文窗口管理

---

### 4. AGENTS.md 开放标准

**官方网站**: https://agents.md/

#### 核心理念

**定位**: "README for agents" - 为AI编程助手提供统一的项目指令格式

**支持的工具**(20,000+开源项目使用):
- OpenAI Codex
- Google Jules
- GitHub Copilot Coding Agent
- Cursor
- Windsurf
- Cline
- Aider
- Kilo Code
- Factory
- Roo Code
- Zed
- VS Code
- Warp
- 等等...

#### 文件格式

**位置**: 项目根目录的 `AGENTS.md`

**示例内容**:
```markdown
# AGENTS.md

## Setup commands
- Install deps: `pnpm install`
- Start dev server: `pnpm dev`
- Run tests: `pnpm test`

## Code style
- TypeScript strict mode
- Single quotes, no semicolons
- Use functional patterns where possible

## Testing instructions
- Find the CI plan in the .github/workflows folder
- Run `pnpm turbo run test --filter <project_name>`
- Fix any test or type errors until the whole suite is green

## PR instructions
- Title format: [<project_name>] <Title>
- Always run `pnpm lint` and `pnpm test` before committing
```

#### 大型Monorepo支持

**嵌套AGENTS.md**:
```
repo-root/
├── AGENTS.md                    # 主仓库规则
├── packages/
│   ├── frontend/
│   │   └── AGENTS.md           # 前端子项目规则
│   └── backend/
│       └── AGENTS.md           # 后端子项目规则
```

**优先级**: 最近的AGENTS.md文件优先级最高

#### 配置特定工具

**Aider配置** (`.aider.conf.yml`):
```yaml
read: AGENTS.md
```

**Gemini CLI配置** (`.gemini/settings.json`):
```json
{
  "contextFileName": "AGENTS.md"
}
```

**特点**:
- ✅ 跨工具统一标准
- ✅ 简单的Markdown格式
- ✅ 支持嵌套和继承
- ✅ 行业广泛采用

---

## 二、Workflow机制对比

### 1. Cursor - Agent Mode & Composer

**触发方式**:
- 手动触发Agent Mode
- Composer多文件编辑

**特点**:
- 集成在IDE中
- 无需额外配置文件
- 依赖.cursorrules提供上下文

---

### 2. Windsurf - Declarative Workflows

**文件格式**: YAML

**触发方式**:
- `on: manual` - 手动触发
- `on: push` - 代码推送时
- `on: pull_request` - PR时

**优势**:
- 声明式定义
- AI辅助执行
- 与Rules和Memories集成

---

### 3. Cline - Task Management

**工作流程**:
1. Plan Mode - 策略讨论
2. Act Mode - 执行任务
3. Memory Bank更新

**特点**:
- 基于对话的工作流
- 无需YAML配置
- 依赖Memory Bank维护状态

---

## 三、为 specify_writer 项目的建议

### 1. 采用多层次规则系统

**推荐文件结构**:
```
specify_writer/
├── AGENTS.md                    # 开放标准,跨工具兼容
├── .cursorrules                 # Cursor专用
├── .windsurfrules              # Windsurf专用
├── .clinerules                 # Cline专用
├── memory-bank/                # Cline Memory Bank
│   ├── projectbrief.md
│   ├── activeContext.md
│   └── ...
└── workflows/                  # Windsurf Workflows
    ├── writer-init.yaml
    ├── writer-draft.yaml
    └── ...
```

### 2. AGENTS.md 作为主规则文件

**内容建议**:
```markdown
# Specify Writer - 通用写作标准化工具集

## Setup commands
- Initialize project: Use `writer.init` command
- Create outline: Use `writer.outline` command
- Start writing: Use `writer.draft` command

## Code style
- All files use UTF-8 encoding (without BOM)
- No emoji in command output - use text like [完成] [失败] [注意]
- PowerShell scripts must include `-Json` parameter for JSON output

## Project structure
- Commands: `specify_writer/commands/*.md`
- Scripts: `specify_writer/scripts/powershell/*.ps1`
- Templates: `specify_writer/templates/`
- Agents: `specify_writer/agents/*.md`

## Workflow
1. writer.init → 2. writer.outline → 3. writer.style → 
4. writer.draft → 5. writer.review → 6. writer.export

## Testing
- Test each command with JSON output
- Verify UTF-8 encoding
- Check prerequisite validation
```

### 3. 命令文件标准化

**统一格式** (兼容Cursor、Windsurf、Cline):
```markdown
---
description: 命令简短描述
---

## User Input

​```text
$ARGUMENTS
​```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Parse user input**: 解析参数
2. **Check prerequisites**: 运行前置检查脚本
   ​```powershell
   .\specify_writer\scripts\powershell\check-writer-prerequisites.ps1 -Json
   ​```
3. **Execute main script**: 执行主脚本
4. **Parse JSON output**: 解析JSON结果
5. **Report completion**: 输出完成信息

## Error Handling
- 错误场景1: 处理方式
- 错误场景2: 处理方式

## Next Steps
建议的后续操作
```

### 4. PowerShell脚本标准

**必须包含**:
```powershell
#!/usr/bin/env pwsh
[CmdletBinding()]
param(
    [switch]$Json,
    # 其他参数...
)

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 主逻辑...

if ($Json) {
    $result = @{
        "KEY1" = "value1"
        "KEY2" = "value2"
    }
    $json = $result | ConvertTo-Json -Depth 10 -Compress
    Write-Output $json
} else {
    Write-Output "[完成] 操作成功"  # 禁用emoji
}
```

### 5. 编码和输出规范

**强制要求**:
- ✅ 所有文件使用 **UTF-8 编码(无BOM)**
- ✅ 命令行输出 **禁用emoji图标**
- ✅ 使用纯文本替代:
  - `[完成]` 或 `[PASS]` 替代 ✅
  - `[失败]` 或 `[FAIL]` 替代 ❌
  - `[注意]` 或 `[NOTE]` 替代 📝
  - `[警告]` 或 `[WARNING]` 替代 ⚠️

**原因**:
- 跨平台兼容性(Windows PowerShell编码问题)
- JSON解析稳定性
- 终端显示一致性

---

## 四、Augment Code的独特优势

基于调研,**Augment Code在specify_writer项目中具有独特优势**:

### 1. 最完善的Rules系统

**多层级规则支持**:
- 支持CLAUDE.md、AGENTS.md、.augment/rules/*.md
- 清晰的优先级顺序
- Frontmatter配置(type: always_apply/agent_requested)

**智能规则应用**:
- `agent_requested`类型:AI自动判断规则相关性
- 优化上下文使用,避免无关规则污染

### 2. 最灵活的Commands系统

**三级命令位置**:
- 用户级: `~/.augment/commands/`
- 工作区级: `./.augment/commands/`
- 兼容级: `./.claude/commands/`

**Namespacing支持**:
- 子目录组织命令
- 避免命名冲突

**命令行集成**:
- `auggie command <name>` 直接执行
- `auggie command list` 列出所有命令

### 3. 跨工具兼容性

**支持多种规则格式**:
- CLAUDE.md (Claude Code)
- AGENTS.md (Cursor, Windsurf, Cline等)
- .augment/rules/ (Augment专有)

**命令兼容性**:
- 自动检测.claude/commands/
- 无需迁移即可使用现有命令

### 4. 最适合specify_writer项目

**原因**:
1. **项目目标**: 生成`.augment`命令集 → Augment Code是目标平台
2. **规则系统**: 需要复杂的规则管理 → Augment的Frontmatter配置最强大
3. **命令系统**: 需要工作流命令 → Augment的Namespacing最适合
4. **兼容性**: 需要跨工具支持 → Augment支持CLAUDE.md和AGENTS.md

---

## 五、实施优先级

### P1 (立即实施)

1. **创建 AGENTS.md** - 作为主规则文件(跨工具兼容)
2. **创建 .augment/rules/*.md** - Augment专有规则(使用Frontmatter)
3. **修改PowerShell脚本** - 添加 `-Json` 参数和UTF-8编码
4. **统一命令文件格式** - 遵循Augment标准
5. **禁用emoji输出** - 使用纯文本替代

### P2 (短期实施)

1. **创建 .cursorrules** - Cursor用户支持
2. **创建 .windsurfrules** - Windsurf用户支持
3. **创建 .clinerules** - Cline用户支持
4. **添加Memory Bank支持** - 可选,提升Cline体验

### P3 (长期优化)

1. **创建Windsurf Workflows** - 自动化工作流
2. **多语言支持** - 中英文双语AGENTS.md
3. **示例项目** - 完整的使用示例

---

## 五、参考资源

### 官方文档
- Cursor Rules: https://cursor.com/docs/context/rules
- Windsurf Cascade: https://docs.windsurf.com/windsurf/cascade/cascade
- Cline Memory Bank: https://docs.cline.bot/prompting/cline-memory-bank
- AGENTS.md: https://agents.md/

### 社区资源
- awesome-cursorrules: https://github.com/PatrickJS/awesome-cursorrules
- Windsurf Rules Directory: https://windsurf.com/editor/directory
- AGENTS.md Examples: https://github.com/search?q=path:AGENTS.md

### 博客文章
- Windsurf Rules & Workflows: https://www.paulmduvall.com/using-windsurf-rules-workflows-and-memories/
- AGENTS.md Standard: https://addozhang.medium.com/agents-md-a-new-standard-for-unified-coding-agent-instructions-0635fc5cb759

---

## 六、结论

**核心建议**:

1. **采用AGENTS.md作为主规则文件** - 确保跨工具兼容性
2. **保持简单的Markdown格式** - 易于维护和理解
3. **强制UTF-8编码和禁用emoji** - 确保稳定性
4. **提供工具特定配置** - 优化各工具体验

**预期效果**:

- ✅ specify_writer命令可在Cursor、Windsurf、Cline等工具中使用
- ✅ 用户体验一致,无需学习不同工具的配置
- ✅ 项目文档自动化,降低维护成本
- ✅ 符合行业最佳实践和新兴标准

---

**最后更新**: 2025-11-02  
**维护者**: AI Assistant  
**版本**: v1.0

