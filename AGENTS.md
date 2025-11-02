# Specify Writer - 七阶段写作工作流程系统

## Project Overview

Specify Writer 是一个全面的写作工作流程管理系统，支持多种写作类型的标准化创作流程。

**核心特性**:
- 七阶段结构化工作流程
- 支持多种写作类型（学术论文、小说、剧本、诗歌、传记等）
- 创作宪法文件机制，确保作品一致性
- 自动化合规性审查
- 跨AI编程工具兼容（Augment Code、Cursor、Windsurf、Cline等）

**七阶段工作流程**:
1. **内容调研与类型确定** - 从材料中提取信息，确定写作类型和架构
2. **风格与背景设计** - 创建风格规范、历史背景、世界观设定
3. **创作宪法文件** - 定义核心原则、价值观和创作约束
4. **情节设计与大纲编写** - 设计完整情节，编写详细章节大纲
5. **合规性审查** - 验证大纲是否符合宪法文件要求
6. **分章节编写** - 按大纲逐章生成内容，保持一致性
7. **最终审查与导出** - 全文审查，导出多种格式文档

---

## Setup Commands

### 初始化项目
```bash
# Augment Code
/writer:init <project-name> [project-path]

# 命令行
auggie command writer:init
```

### 七阶段工作流程

**阶段一: 内容调研与类型确定**
```bash
/writer:1-research <project-dir> [source-material] [keywords]
```

**阶段二: 风格与背景设计**
```bash
/writer:2-design <project-dir> <writing-type>
```

**阶段三: 创作宪法文件**
```bash
/writer:3-constitution <project-dir>
```

**阶段四: 情节设计与大纲编写**
```bash
/writer:4-outline <project-dir> [chapter-count]
```

**阶段五: 合规性审查**
```bash
/writer:5-validate <project-dir>
```

**阶段六: 分章节编写**
```bash
/writer:6-draft <project-dir> <chapter-number>
```

**阶段七: 最终审查与导出**
```bash
/writer:7-finalize <project-dir> [export-format]
```

---

## Code Style

### 编码规范
- **所有文件使用UTF-8编码（无BOM）**
- **命令行输出禁用emoji图标**，使用纯文本替代：
  - `[完成]` 或 `[PASS]` 替代 ✅
  - `[失败]` 或 `[FAIL]` 替代 ❌
  - `[注意]` 或 `[NOTE]` 替代 📝
  - `[警告]` 或 `[WARNING]` 替代 ⚠️

### PowerShell脚本规范
- 必须包含 `#!/usr/bin/env pwsh`
- 必须使用 `[CmdletBinding()]`
- 必须设置 `$ErrorActionPreference = 'Stop'`
- 必须支持 `-Json` 参数用于机器可读输出
- 必须调用 `common-functions.ps1` 中的公共函数

**示例**:
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
        "message" = "操作完成"
    }
} else {
    Write-StatusMessage -Type Success -Message "操作完成"
}
```

---

## Project Structure

### 项目目录结构

```
specify_writer/
├── AGENTS.md                    # 本文件 - 跨工具兼容规则
├── .augment/
│   ├── rules/                   # Augment Code专有规则
│   │   ├── writer-workflow.md   # 七阶段工作流程规则
│   │   ├── constitution-principles.md  # 宪法文件编写原则
│   │   └── validation-rules.md  # 合规性审查规则
│   └── commands/
│       └── writer/              # 写作命令（Namespacing）
│           ├── init.md
│           ├── 1-research.md
│           ├── 2-design.md
│           ├── 3-constitution.md
│           ├── 4-outline.md
│           ├── 5-validate.md
│           ├── 6-draft.md
│           └── 7-finalize.md
├── templates/                   # 模板文件
│   ├── research-report-template.md
│   ├── design-document-template.md
│   ├── constitution-template.md
│   └── validation-report-template.md
├── scripts/powershell/          # PowerShell脚本
│   ├── common-functions.ps1     # 公共函数库
│   ├── init-writer-project.ps1
│   ├── conduct-research.ps1
│   ├── create-design-document.ps1
│   ├── create-constitution.ps1
│   ├── create-outline.ps1
│   ├── validate-compliance.ps1
│   ├── generate-chapter.ps1
│   └── finalize-document.ps1
├── agents/                      # AI Agent定义
│   ├── research-specialist.md
│   ├── design-architect.md
│   ├── constitution-writer.md
│   ├── outline-planner.md
│   ├── compliance-validator.md
│   ├── content-writer.md
│   └── quality-reviewer.md
└── memory/                      # 知识库
    ├── writing-types.md
    ├── style-patterns.md
    └── validation-checklist.md
```

### 用户项目结构（初始化后）

```
<ProjectName>/
├── .writer/
│   ├── config.json              # 项目配置
│   ├── research/                # 阶段一：调研结果
│   ├── design/                  # 阶段二：设计文档
│   ├── constitution/            # 阶段三：宪法文件
│   ├── outline/                 # 阶段四：大纲
│   ├── validation/              # 阶段五：审查报告
│   ├── drafts/                  # 阶段六：章节草稿
│   └── final/                   # 阶段七：最终文档
├── README.md
└── .gitignore
```

---

## Workflow

### 完整工作流程示例

**1. 初始化项目**
```bash
/writer:init "我的小说项目"
```
创建项目目录结构和配置文件。

**2. 内容调研**
```bash
/writer:1-research ./我的小说项目 --keywords "科幻,太空探索"
```
进行内容调研，确定写作类型为"长篇小说"。

**3. 风格与背景设计**
```bash
/writer:2-design ./我的小说项目 "长篇小说"
```
创建风格规范、世界观设定、角色设定等设计文档。

**4. 创作宪法文件**
```bash
/writer:3-constitution ./我的小说项目
```
基于调研和设计，创建定义核心原则和约束的宪法文件。

**5. 情节设计与大纲**
```bash
/writer:4-outline ./我的小说项目 --chapters 20
```
设计完整情节，创建20章的详细大纲。

**6. 合规性审查**
```bash
/writer:5-validate ./我的小说项目
```
验证大纲是否符合宪法文件要求。如果不通过，返回修改大纲。

**7. 分章节编写**
```bash
/writer:6-draft ./我的小说项目 1
/writer:6-draft ./我的小说项目 2
# ... 继续编写其他章节
```
按大纲逐章生成内容。

**8. 最终审查与导出**
```bash
/writer:7-finalize ./我的小说项目 --format epub,pdf
```
全文审查，导出EPUB和PDF格式。

---

## Augment Code Integration

### Rules系统

**规则文件位置**:
- `.augment/rules/writer-workflow.md` - 自动应用（type: always_apply）
- `.augment/rules/constitution-principles.md` - 按需应用（type: agent_requested）
- `.augment/rules/validation-rules.md` - 按需应用（type: agent_requested）

**规则优先级**:
```
用户提示 > CLAUDE.md > AGENTS.md > .augment/rules/*.md
```

### Commands系统

**命令位置**:
- 工作区级: `.augment/commands/writer/*.md`
- 兼容级: `.claude/commands/writer/*.md`（自动检测）

**Namespacing**:
所有命令使用 `writer:` 前缀，避免命名冲突。

**命令行执行**:
```bash
# 列出所有命令
auggie command list

# 执行命令
auggie command writer:init
auggie command writer:1-research
```

---

## Testing

### 测试要求

**单元测试**:
- 每个PowerShell脚本必须有对应的测试脚本
- 测试脚本位于 `tests/` 目录
- 使用Pester测试框架

**集成测试**:
- 测试完整的七阶段工作流程
- 至少包含三个场景：学术论文、小说、剧本

**测试命令**:
```powershell
# 运行所有测试
.\tests\Run-AllTests.ps1

# 运行特定测试
.\tests\Test-InitWriterProject.ps1
```

### 验收标准

每个阶段完成后必须验证：
- [x] 所有文件使用UTF-8编码（无BOM）
- [x] 命令行输出无emoji图标
- [x] PowerShell脚本支持`-Json`参数
- [x] JSON输出格式正确
- [x] 前置条件检查正常工作
- [x] 生成的文件符合模板要求

---

## Supported Writing Types

### 学术类
- 研究论文（Research Paper）
- 综述论文（Review Paper）
- 学位论文（Thesis/Dissertation）
- 技术报告（Technical Report）

### 文学类
- 长篇小说（Novel）
- 中篇小说（Novella）
- 短篇小说（Short Story）
- 人物传记（Biography）
- 长篇诗歌（Epic Poetry）

### 戏剧类
- 话剧剧本（Stage Play）
- 电影剧本（Screenplay）
- 电视剧本（TV Script）
- 歌剧剧本（Opera Libretto）
- 音乐剧（Musical）

---

## Cross-Tool Compatibility

### Cursor
- 读取 `AGENTS.md`（本文件）
- 可选：创建 `.cursorrules` 文件

### Windsurf
- 读取 `AGENTS.md`（本文件）
- 可选：创建 `.windsurfrules` 文件
- 可选：创建 `.windsurf/workflows/` YAML工作流

### Cline
- 读取 `AGENTS.md`（本文件）
- 可选：创建 `.clinerules` 文件
- 可选：使用Memory Bank记录项目上下文

### Augment Code
- 读取 `AGENTS.md`（本文件）
- 读取 `.augment/rules/*.md`（专有规则）
- 读取 `.augment/commands/writer/*.md`（命令定义）
- 支持命令行执行：`auggie command writer:*`

---

## Best Practices

### 1. 严格遵循七阶段流程
- 不要跳过任何阶段
- 每个阶段完成后再进入下一阶段
- 如果验证不通过，返回修改前一阶段

### 2. 充分利用宪法文件
- 宪法文件是整个创作的"法律"
- 所有内容必须符合宪法文件要求
- 定期回顾宪法文件，确保一致性

### 3. 保持风格一致性
- 使用风格设计文档作为参考
- 每章编写后自查风格一致性
- 利用合规性审查机制

### 4. 版本控制
- 使用Git管理项目
- 每个阶段完成后提交
- 重要修改前创建分支

### 5. 备份重要文件
- 定期备份 `.writer/` 目录
- 特别是宪法文件和大纲文件
- 使用云存储或外部硬盘

---

## Troubleshooting

### 常见问题

**Q: PowerShell脚本执行失败，提示编码错误**
A: 确保所有文件使用UTF-8编码（无BOM）。使用 `Set-Utf8Encoding` 函数。

**Q: JSON输出解析失败**
A: 检查脚本是否正确使用 `Write-JsonOutput` 函数，确保没有emoji输出。

**Q: 合规性审查总是不通过**
A: 检查宪法文件是否过于严格，或大纲是否偏离核心主题。

**Q: 命令在Augment Code中不可用**
A: 运行 `auggie command list` 检查命令是否正确注册。确保文件在 `.augment/commands/writer/` 目录。

---

## Contributing

欢迎贡献！请遵循以下规范：
- 所有代码使用UTF-8编码（无BOM）
- 禁用emoji，使用纯文本状态标记
- PowerShell脚本必须支持`-Json`参数
- 提交前运行所有测试

---

## License

MIT License

---

## Contact

- 项目仓库: [待添加]
- 问题反馈: [待添加]
- 文档: 参考 `docs/USER_GUIDE.md`

---

**版本**: v1.0  
**最后更新**: 2025-11-02  
**兼容工具**: Augment Code, Cursor, Windsurf, Cline, GitHub Copilot

