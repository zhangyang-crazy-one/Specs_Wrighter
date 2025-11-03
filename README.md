# Specify Writer

<div align="center">

**基于AI的七阶段结构化写作工作流系统**

[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/yourusername/specify-writer)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/status-production-brightgreen.svg)](https://github.com/yourusername/specify-writer)

[快速开始](#-快速开始) • [功能特性](#-功能特性) • [文档](#-文档) • [示例](#-使用示例) • [脚本使用](#-脚本使用)

</div>

---

## 📖 项目简介

**Specify Writer** 是一个专业的AI辅助写作工作流系统，通过**七阶段结构化流程**帮助您创作高质量的长篇内容。无论是学术论文、长篇小说还是电影剧本，Specify Writer都能提供系统化的创作支持。

### 🎯 核心理念

- **结构化流程**: 七阶段工作流确保创作过程系统化、可控
- **AI辅助**: 7个专业Agent在每个阶段提供智能辅助
- **质量保证**: 创作宪法和合规性验证确保内容质量
- **跨工具兼容**: 支持Augment Code、Cursor、Windsurf等主流AI编程工具

### ✨ 适用场景

| 场景 | 示例 | 字数规模 |
|------|------|----------|
| **学术论文** | MEM学位论文、研究报告 | 3-10万字 |
| **长篇小说** | 科幻、奇幻、悬疑小说 | 10-30万字 |
| **电影剧本** | 电影、电视剧剧本 | 2-5万字 |
| **技术文档** | 系统设计文档、API文档 | 1-5万字 |

---

## 🚀 快速开始

### 前置要求

- **AI编程工具**: Augment Code（推荐）、Cursor、Windsurf或Cline
- **PowerShell**: Windows 5.1+ 或 PowerShell Core 7+
- **编辑器**: VS Code（推荐）或任何文本编辑器

### 安装步骤

1. **克隆或下载项目**
   ```bash
   git clone https://github.com/yourusername/specify-writer.git
   cd specify-writer
   ```

2. **配置AI工具**（以Augment Code为例）
   - 打开项目文件夹
   - AI工具会自动识别`.augment`配置
   - 开始使用`/writer:*`命令

### 5分钟快速体验

```bash
# 1. 初始化一个小说项目
/writer:init "时光旅行者"

# 2. 执行七阶段流程
/writer:1-research      # 内容调研
/writer:2-design        # 风格设计
/writer:3-constitution  # 创作宪法
/writer:4-outline       # 大纲编写
/writer:5-validate      # 合规性审查
/writer:6-draft         # 章节编写
/writer:7-finalize      # 最终审查
```

---

## 🎨 功能特性

### 七阶段工作流

| 阶段 | 名称 | 功能 | 输出 |
|------|------|------|------|
| 0️⃣ | **初始化** | 创建项目结构，设置基本配置 | 项目目录、配置文件 |
| 1️⃣ | **内容调研** | 确定写作类型、目标受众、核心主题 | 调研报告 |
| 2️⃣ | **风格设计** | 定义写作风格、世界观、角色框架 | 设计文档 |
| 3️⃣ | **创作宪法** | 制定创作规则、质量标准、禁止事项 | 创作宪法 |
| 4️⃣ | **大纲编写** | 规划整体结构、章节划分、情节线索 | 详细大纲 |
| 5️⃣ | **合规性审查** | 验证大纲是否符合创作宪法 | 验证报告 |
| 6️⃣ | **章节编写** | 基于大纲编写具体章节内容 | 章节文件 |
| 7️⃣ | **最终审查** | 全文质量检查、导出成品 | 最终成品 |

### 7个专业Agent

每个阶段都有专门的AI助手：

- 🔍 **Research Specialist** - 内容调研专家
- 🎨 **Design Architect** - 设计架构师
- 📜 **Constitution Writer** - 宪法编写者
- 📋 **Outline Planner** - 大纲规划师
- ✅ **Compliance Validator** - 合规验证者
- ✍️ **Content Writer** - 内容编写者
- 🔎 **Quality Reviewer** - 质量审查者

### 核心优势

✅ **结构化流程** - 七阶段确保创作过程系统化
✅ **质量保证** - 创作宪法和合规性验证
✅ **AI辅助** - 每个阶段都有专业Agent支持
✅ **跨工具兼容** - 支持主流AI编程工具
✅ **丰富模板** - 提供多种文体的专业模板
✅ **示例项目** - 3个完整示例供参考

---

## 📚 文档

### 核心文档

- **[USER_GUIDE.md](USER_GUIDE.md)** - 完整用户指南（300+行）
- **[AGENTS.md](AGENTS.md)** - 系统架构和Agent说明
- **[TESTING_GUIDE.md](TESTING_GUIDE.md)** - 测试指南

### 示例项目

- **[examples/sample-novel/](examples/sample-novel/)** - 科幻小说《时光旅行者》
- **[examples/sample-paper/](examples/sample-paper/)** - 学术论文《LLM数据治理研究》
- **[examples/sample-screenplay/](examples/sample-screenplay/)** - 电影剧本《最后的代码》

---

## 🗂️ 项目结构

```
specify_writer/
├── .augment/                    # Augment Code配置
│   ├── commands/writer/         # 8个命令文件
│   └── rules/                   # 3个规则文件
├── agents/                      # 7个专业Agent
│   ├── research-specialist.md
│   ├── design-architect.md
│   ├── constitution-writer.md
│   ├── outline-planner.md
│   ├── compliance-validator.md
│   ├── content-writer.md
│   └── quality-reviewer.md
├── scripts/powershell/          # 11个PowerShell脚本
│   ├── init-writer-project.ps1
│   ├── conduct-research.ps1
│   ├── create-design.ps1
│   ├── create-constitution.ps1
│   ├── create-outline.ps1
│   ├── validate-outline.ps1
│   ├── write-chapter.ps1
│   ├── finalize-project.ps1
│   ├── common-functions.ps1
│   ├── test-workflow.ps1
│   └── integration-test.ps1
├── templates/                   # 4个标准模板
│   ├── research-report-template.md
│   ├── design-document-template.md
│   ├── constitution-template.md
│   └── validation-report-template.md
├── memory/                      # 知识库
│   ├── writing-types.md
│   ├── style-library.md
│   └── quality-checklist.md
├── examples/                    # 3个示例项目
│   ├── sample-novel/
│   ├── sample-paper/
│   └── sample-screenplay/
├── AGENTS.md                    # 系统架构文档
├── USER_GUIDE.md                # 用户指南
├── TESTING_GUIDE.md             # 测试指南
└── README.md                    # 本文件
```

---

## 💡 使用示例

### 示例1: 创建学术论文

```bash
# 1. 初始化项目
/writer:init "LLM在数据治理中的应用研究"

# 2. 内容调研
/writer:1-research
# AI会询问：写作类型、目标受众、核心主题等

# 3. 风格设计
/writer:2-design
# AI会设计：学术风格、论文结构、引用规范等

# 4. 创作宪法
/writer:3-constitution
# AI会制定：质量标准、禁止事项、审查规则等

# 5. 大纲编写
/writer:4-outline
# AI会规划：6章结构、每章内容、字数分配等

# 6. 合规性审查
/writer:5-validate
# AI会验证：大纲是否符合宪法要求

# 7. 章节编写
/writer:6-draft -Chapter 1
# AI会编写：第一章"绪论"，约5000字

# 8. 最终审查
/writer:7-finalize
# AI会检查：全文质量、导出成品
```

### 示例2: 创建科幻小说

```bash
# 1. 初始化项目
/writer:init "时光旅行者"

# 2-5. 执行前五个阶段
/writer:1-research
/writer:2-design
/writer:3-constitution
/writer:4-outline
/writer:5-validate

# 6. 编写30章
/writer:6-draft -Chapter 1
/writer:6-draft -Chapter 2
# ... 继续编写其他章节

# 7. 最终审查
/writer:7-finalize
```

### 示例3: 创建电影剧本

```bash
# 1. 初始化项目
/writer:init "最后的代码"

# 2-7. 执行完整流程
/writer:1-research      # 确定类型：科幻惊悚
/writer:2-design        # 设计风格：紧张、悬疑
/writer:3-constitution  # 制定规则：剧本格式标准
/writer:4-outline       # 规划：45个场景
/writer:5-validate      # 验证：符合剧本规范
/writer:6-draft         # 编写：各个场景
/writer:7-finalize      # 审查：导出剧本
```

---

## 🧪 测试

### 运行测试

```powershell
# 工作流测试（测试七阶段流程）
.\scripts\powershell\test-workflow.ps1 -Scenario Academic

# 集成测试（测试系统集成）
.\scripts\powershell\integration-test.ps1
```

### 测试结果

- ✅ 工作流测试: 8/8 通过 (100%)
- ✅ 集成测试: 5/5 通过 (100%)
- ✅ 总计: 13/13 通过 (100%)

详见：[TEST_REPORT_FINAL.md](TEST_REPORT_FINAL.md)

---

## 🔧 脚本使用

### 脚本与命令的关系

Specify Writer 提供了两种使用方式：

1. **AI命令方式**（推荐）：使用 `/writer:*` 命令，AI会自动调用相应的脚本
2. **直接脚本方式**：手动运行 PowerShell 脚本，适合自动化和批处理

**关系说明**：
- `/writer:init` → 调用 `init-writer-project.ps1`
- `/writer:1-research` → 调用 `conduct-research.ps1`
- `/writer:2-design` → 调用 `create-design.ps1`
- 其他命令以此类推

### 核心工作流脚本

| 脚本名称 | 对应命令 | 主要参数 | 功能说明 |
|---------|---------|---------|---------|
| `init-writer-project.ps1` | `/writer:init` | `-ProjectName`, `-ProjectPath` | 初始化项目结构，创建必要的目录和配置文件 |
| `conduct-research.ps1` | `/writer:1-research` | `-ProjectPath` | 执行内容调研，生成调研报告 |
| `create-design.ps1` | `/writer:2-design` | `-ProjectPath` | 创建风格设计文档，定义写作风格 |
| `create-constitution.ps1` | `/writer:3-constitution` | `-ProjectPath` | 生成创作宪法，制定质量标准 |
| `create-outline.ps1` | `/writer:4-outline` | `-ProjectPath` | 创建详细大纲，规划章节结构 |
| `validate-outline.ps1` | `/writer:5-validate` | `-ProjectPath` | 验证大纲合规性，生成验证报告 |
| `write-chapter.ps1` | `/writer:6-draft` | `-ProjectPath`, `-ChapterNumber` | 编写指定章节内容 |
| `finalize-project.ps1` | `/writer:7-finalize` | `-ProjectPath`, `-ExportFormat` | 最终审查和导出成品 |

### 辅助脚本

| 脚本名称 | 功能说明 |
|---------|---------|
| `common-functions.ps1` | 公共函数库，被其他脚本调用 |
| `test-workflow.ps1` | 工作流测试脚本，验证七阶段流程 |
| `integration-test.ps1` | 集成测试脚本，验证系统集成 |

### 直接使用脚本示例

#### 示例1: 初始化项目

```powershell
# 在当前目录创建项目
.\scripts\powershell\init-writer-project.ps1 -ProjectName "我的小说"

# 在指定目录创建项目
.\scripts\powershell\init-writer-project.ps1 -ProjectName "我的小说" -ProjectPath "D:\Projects"
```

#### 示例2: 执行完整工作流

```powershell
# 设置项目路径
$projectPath = ".\test-projects\my-novel"

# 1. 初始化
.\scripts\powershell\init-writer-project.ps1 -ProjectName "时光旅行者" -ProjectPath ".\test-projects"

# 2. 内容调研
.\scripts\powershell\conduct-research.ps1 -ProjectPath $projectPath

# 3. 风格设计
.\scripts\powershell\create-design.ps1 -ProjectPath $projectPath

# 4. 创作宪法
.\scripts\powershell\create-constitution.ps1 -ProjectPath $projectPath

# 5. 大纲编写
.\scripts\powershell\create-outline.ps1 -ProjectPath $projectPath

# 6. 合规性验证
.\scripts\powershell\validate-outline.ps1 -ProjectPath $projectPath

# 7. 编写章节
.\scripts\powershell\write-chapter.ps1 -ProjectPath $projectPath -ChapterNumber 1

# 8. 最终审查
.\scripts\powershell\finalize-project.ps1 -ProjectPath $projectPath -ExportFormat "PDF"
```

#### 示例3: 批量编写章节

```powershell
# 批量编写前10章
$projectPath = ".\test-projects\my-novel"
1..10 | ForEach-Object {
    Write-Host "正在编写第 $_ 章..." -ForegroundColor Green
    .\scripts\powershell\write-chapter.ps1 -ProjectPath $projectPath -ChapterNumber $_
}
```

#### 示例4: 运行测试

```powershell
# 工作流测试 - 学术论文场景
.\scripts\powershell\test-workflow.ps1 -Scenario Academic

# 工作流测试 - 小说场景
.\scripts\powershell\test-workflow.ps1 -Scenario Novel

# 集成测试
.\scripts\powershell\integration-test.ps1
```

### 脚本参数说明

#### 通用参数

- **`-ProjectPath`**: 项目路径（必需，除了 init 脚本）
- **`-Verbose`**: 显示详细输出信息
- **`-WhatIf`**: 预览操作但不实际执行

#### 特定参数

**`init-writer-project.ps1`**:
- `-ProjectName`: 项目名称（必需）
- `-ProjectPath`: 父目录路径（可选，默认当前目录）

**`write-chapter.ps1`**:
- `-ChapterNumber`: 章节编号（必需）
- `-ChapterTitle`: 章节标题（可选）

**`finalize-project.ps1`**:
- `-ExportFormat`: 导出格式（可选：PDF, DOCX, EPUB, 默认 PDF）

**`test-workflow.ps1`**:
- `-Scenario`: 测试场景（可选：Academic, Novel, Screenplay, 默认 Academic）

### 使用建议

✅ **推荐使用 AI 命令**：
- 更智能的交互体验
- AI 会根据上下文调整参数
- 自动处理错误和异常情况

✅ **推荐使用脚本**：
- 需要批量处理多个章节
- 集成到 CI/CD 流程
- 自动化测试和验证
- 需要精确控制参数

### 注意事项

⚠️ **执行策略**：
```powershell
# 如果遇到执行策略限制，运行：
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

⚠️ **路径问题**：
- 使用相对路径时，确保在正确的工作目录
- 建议使用绝对路径避免路径错误

⚠️ **依赖关系**：
- 所有脚本都依赖 `common-functions.ps1`
- 确保该文件在同一目录下

---


## 🔧 高级配置

### 自定义Agent

您可以创建自己的Agent：

1. 在`agents/`目录创建新的`.md`文件
2. 添加Frontmatter（name, description）
3. 包含`<example>`标签示例
4. 定义职责、工作流程、输出格式

### 自定义模板

您可以创建自己的模板：

1. 在`templates/`目录创建新的模板文件
2. 使用占位符（如`{{title}}`, `{{author}}`）
3. 在脚本中引用自定义模板

### 跨工具兼容性

本项目遵循`AGENTS.md`开放标准，兼容：

- ✅ **Augment Code** - 完全支持（推荐）
- ✅ **Cursor** - 支持Agent和规则
- ✅ **Windsurf** - 支持Agent定义
- ✅ **Cline** - 支持基本功能

---

## ❓ 常见问题

### Q1: 适合什么样的写作项目？

**A**: 适合需要系统化创作的长篇内容：
- 学术论文（3-10万字）
- 长篇小说（10-30万字）
- 电影剧本（2-5万字）
- 技术文档（1-5万字）

### Q2: 必须按照七阶段流程吗？

**A**: 建议按照流程执行，但可以根据需要调整：
- 简单项目可以跳过某些阶段
- 复杂项目可以在某个阶段多次迭代
- 关键是保持结构化和质量控制

### Q3: 如何确保内容质量？

**A**: 系统提供多层质量保证：
1. **创作宪法** - 制定明确的质量标准
2. **合规性验证** - 验证大纲符合宪法
3. **章节自查** - 每章编写后自我检查
4. **最终审查** - 全文质量检查

### Q4: 支持哪些AI工具？

**A**: 支持主流AI编程工具：
- Augment Code（推荐，完全支持）
- Cursor（支持Agent和规则）
- Windsurf（支持Agent定义）
- Cline（支持基本功能）

### Q5: 如何导出成品？

**A**: 使用`/writer:7-finalize`命令：
- 自动生成最终审查报告
- 支持导出PDF、DOCX、EPUB等格式
- 包含完整的质量检查

---

## 🤝 贡献

欢迎贡献！您可以：

1. 🐛 报告Bug
2. 💡 提出新功能建议
3. 📝 改进文档
4. 🎨 贡献新的Agent或模板
5. 🧪 添加测试用例

**贡献流程**：

1. Fork本项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启Pull Request

---

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

---

## 🙏 致谢

感谢以下项目和团队：

- **Augment Code** - 提供强大的AI编程工具
- **DAMA-DMBOK** - 数据管理知识体系
- **开源社区** - 宝贵的建议和支持

---

## 📞 联系方式

- **项目主页**: https://github.com/zhangyang-crazy-one/Specs_Wrighter
- **问题反馈**: https://github.com/zhangyang-crazy-one/Specs_Wrighter/issues
- **文档**: 查看项目内的各个文档文件

---

<div align="center">

**Specify Writer v1.1**

*让AI辅助您的创作之旅* ✍️

**最后更新**: 2025-11-03
**项目状态**: ✅ 可投入使用

[⬆ 返回顶部](#specify-writer)

</div>
