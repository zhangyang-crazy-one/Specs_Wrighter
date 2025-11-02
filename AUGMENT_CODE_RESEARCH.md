# Augment Code 专项调研报告

**调研日期**: 2025-11-02  
**调研目的**: 补充Augment Code的Rules、Commands和Workflow机制,完善AI编程工具调研

---

## 一、Augment Code概述

**官方文档**: https://docs.augmentcode.com/

**定位**: 
- AI编程助手,支持VSCode、JetBrains、Vim/Neovim
- 提供Auggie CLI命令行工具
- 强调跨工具兼容性(支持CLAUDE.md和AGENTS.md)

**核心特性**:
1. 最完善的Rules系统(多层级、Frontmatter配置)
2. 最灵活的Commands系统(三级位置、Namespacing)
3. 跨工具兼容性(CLAUDE.md、AGENTS.md、.claude/commands/)
4. 命令行集成(auggie command)

---

## 二、Rules & Guidelines系统

### 1. 规则文件位置(优先级顺序)

```
用户聊天提示 (最高优先级)
  ↓
自定义规则文件 (--rules flag)
  ↓
CLAUDE.md (Claude Code兼容)
  ↓
AGENTS.md (Cursor/Windsurf/Cline兼容)
  ↓
.augment/guidelines.md (legacy格式)
  ↓
.augment/rules/*.md (递归搜索,支持子目录)
```

### 2. 规则文件格式

**基本格式**: Markdown文件

**Frontmatter配置**:
```yaml
---
type: always_apply  # 或 agent_requested
description: "规则描述(agent_requested类型必需)"
---
```

**规则类型**:

| 类型 | 应用时机 | CLI支持 | IDE支持 |
|------|----------|---------|---------|
| `always_apply` | 自动包含在每个用户提示中 | ✅ | ✅ |
| `agent_requested` | AI根据description自动判断相关性 | ✅ | ✅ |
| `manual` | 通过@提及手动附加 | ❌ | ✅ |

**注意**: CLI中所有规则当前都被视为`always_apply`,`manual`类型仅在IDE中有效。

### 3. 示例规则文件

**文件**: `.augment/rules/typescript-guidelines.md`

```markdown
---
type: always_apply
---

# TypeScript Guidelines

- Use strict mode in all TypeScript files
- Define explicit return types for all functions
- Avoid using `any` type unless absolutely necessary
```

**文件**: `.augment/rules/react-components.md`

```markdown
---
type: agent_requested
description: React component development patterns and best practices
---

# React Component Guidelines

- Use functional components with hooks
- Implement proper TypeScript interfaces for props
- Follow the established folder structure in src/components/
```

### 4. 命令行使用

**指定自定义规则文件**:
```bash
auggie --rules /path/to/custom-rules.md
```

**规则会自动加载**:
- CLAUDE.md
- AGENTS.md
- .augment/guidelines.md
- .augment/rules/*.md (递归)

---

## 三、Custom Commands系统

### 1. 命令文件位置(优先级顺序)

```
1. ~/.augment/commands/<name>.md (用户级)
2. ./.augment/commands/<name>.md (工作区级)
3. ./.claude/commands/<name>.md (Claude Code兼容)
```

**特点**:
- 用户级命令跨所有项目可用
- 工作区级命令可提交到版本控制,团队共享
- 自动检测.claude/commands/,无需迁移

### 2. 命令文件格式

**Frontmatter配置**:
```yaml
---
description: 命令简短描述
argument-hint: [expected-args]
model: gpt-4o  # 可选,覆盖CLI默认模型
---
```

**Frontmatter字段说明**:

| 字段 | 用途 | 默认值 |
|------|------|--------|
| `description` | 命令简短描述 | 使用提示的第一行 |
| `argument-hint` | 期望的参数格式提示 | 无 |
| `model` | 指定运行此命令的模型 | 使用CLI默认模型 |

### 3. 命令示例

**文件**: `~/.augment/commands/deploy-staging.md`

```markdown
---
description: Deploy the application to staging with health checks
argument-hint: [branch-name]
model: gpt-4o
---

Deploy the application to the staging environment:

1. Run all tests to ensure code quality
2. Build the application for production
3. Deploy to staging server
4. Run health checks to verify deployment
5. Send notification to team channel
```

**使用方式**:
```bash
# 交互式模式
> /deploy-staging main

# 命令行模式
auggie command deploy-staging
```

### 4. Namespacing支持

**子目录组织**:
```
.augment/commands/
├── frontend/
│   ├── component.md
│   └── style.md
└── backend/
    ├── api.md
    └── database.md
```

**调用方式**:
```bash
/frontend:component
/frontend:style
/backend:api
/backend:database
```

**优势**:
- 避免命名冲突
- 逻辑分组
- 易于管理

### 5. 命令行集成

**执行自定义命令**:
```bash
auggie command deploy-staging
```

**列出所有命令**:
```bash
auggie command list
```

**输出示例**:
```
Available custom commands:
  auggie command deploy-staging    # Deploy the application to staging
  auggie command security-review   # Review code for security vulnerabilities
```

---

## 四、Augment Code的独特优势

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

## 五、与其他工具的对比

| 特性 | Augment Code | Cursor | Windsurf | Cline |
|------|--------------|--------|----------|-------|
| **Rules文件** | CLAUDE.md, AGENTS.md, .augment/rules/*.md | .cursorrules | .windsurfrules, global_rules.md | .clinerules |
| **Frontmatter** | ✅ (type, description) | ❌ | ✅ (limited) | ❌ |
| **智能规则** | ✅ (agent_requested) | ❌ | ❌ | ❌ |
| **Commands位置** | 3级(user/workspace/claude) | ❌ | ❌ | ❌ |
| **Namespacing** | ✅ (子目录) | ❌ | ❌ | ❌ |
| **命令行执行** | ✅ (auggie command) | ❌ | ❌ | ❌ |
| **跨工具兼容** | ✅ (CLAUDE.md, AGENTS.md) | ❌ | ❌ | ❌ |

**结论**: Augment Code在Rules和Commands系统上最为完善和灵活。

---

## 六、为specify_writer项目的建议

### 1. 采用Augment Code作为主要目标平台

**原因**:
- 项目目标是生成`.augment`命令集
- Augment的Frontmatter配置最适合复杂规则管理
- Namespacing支持最适合工作流命令组织

### 2. 同时保持跨工具兼容性

**实施方案**:
1. 创建 `AGENTS.md` - 跨工具兼容(Cursor, Windsurf, Cline)
2. 创建 `.augment/rules/*.md` - Augment专有规则(使用Frontmatter)
3. 创建 `.augment/commands/*.md` - Augment命令(使用Namespacing)
4. 可选: 创建 `.cursorrules`, `.windsurfrules`, `.clinerules` - 工具特定配置

### 3. 命令文件结构建议

```
.augment/commands/
├── writer/
│   ├── init.md
│   ├── outline.md
│   ├── style.md
│   ├── draft.md
│   ├── review.md
│   └── export.md
└── utils/
    ├── check-prerequisites.md
    └── validate-config.md
```

**调用方式**:
```bash
/writer:init
/writer:outline
/writer:style
/writer:draft
/writer:review
/writer:export
/utils:check-prerequisites
```

---

## 七、下一步行动

### 立即执行(P1)

1. [注意] 更新 `AI_CODING_TOOLS_RESEARCH.md` - 添加Augment Code章节
2. [注意] 更新 `IMPROVEMENT_TASKS_V2.md` - 调整任务0.1,强调Augment Code
3. [完成] 创建 `AUGMENT_CODE_RESEARCH.md` - 本文档
4. [ ] 开始执行任务0.1 - 创建AGENTS.md(包含Augment Code集成说明)

### 短期执行(P2)

1. [ ] 创建 `.augment/rules/` 目录和规则文件
2. [ ] 创建 `.augment/commands/writer/` 目录和命令文件
3. [ ] 测试Auggie CLI命令执行

---

## 八、参考资料

- [Augment Code官方文档](https://docs.augmentcode.com/)
- [Rules & Guidelines](https://docs.augmentcode.com/cli/rules)
- [Custom Commands](https://docs.augmentcode.com/cli/custom-commands)
- [AGENTS.md标准](https://agents.md/)
- [CLAUDE.md格式](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-claude-code)

