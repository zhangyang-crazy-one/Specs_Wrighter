# Specify Writer 用户指南

**版本**: 1.0  
**更新日期**: 2025-11-02  
**适用于**: Augment Code, Cursor, Windsurf, Cline

---

## 目录

1. [简介](#简介)
2. [快速开始](#快速开始)
3. [七阶段工作流程](#七阶段工作流程)
4. [命令参考](#命令参考)
5. [最佳实践](#最佳实践)
6. [常见问题](#常见问题)
7. [故障排除](#故障排除)

---

## 简介

### 什么是 Specify Writer？

Specify Writer 是一个基于七阶段工作流程的智能写作辅助系统，帮助您创作高质量的学术论文、小说、剧本等各类文本内容。

### 核心特性

- ✅ **七阶段结构化流程**: 从调研到最终审查的完整写作流程
- ✅ **多种写作类型支持**: 学术论文、长篇小说、短篇小说、剧本等
- ✅ **AI辅助创作**: 集成Augment Code等AI编程工具
- ✅ **质量保证**: 内置合规性审查和质量检查
- ✅ **跨工具兼容**: 支持Augment Code, Cursor, Windsurf, Cline

### 系统要求

- PowerShell 5.1 或更高版本
- Windows/Linux/macOS 操作系统
- Augment Code 或其他兼容的AI编程工具（推荐）

---

## 快速开始

### 第一步：初始化项目

使用 `/writer:init` 命令创建新项目：

```bash
/writer:init "我的小说"
```

或指定项目路径和类型：

```bash
/writer:init "研究论文" "D:\Projects\MyPaper" "学术论文"
```

**输出示例**：
```
[完成] 项目初始化成功

项目信息:
  名称: 我的小说
  路径: D:\Projects\我的小说
  创建时间: 2025-11-02T12:00:00

下一步行动:
  运行命令: /writer:1-research
```

### 第二步：开始七阶段流程

按顺序执行以下命令：

1. `/writer:1-research` - 内容调研
2. `/writer:2-design` - 风格设计
3. `/writer:3-constitution` - 创作宪法
4. `/writer:4-outline` - 大纲编写
5. `/writer:5-validate` - 合规性审查
6. `/writer:6-draft` - 章节编写
7. `/writer:7-finalize` - 最终审查

---

## 七阶段工作流程

### 阶段一：内容调研与类型确定

**命令**: `/writer:1-research`

**目的**: 
- 收集和分析源材料
- 确定写作类型和风格
- 提取关键信息和主题

**输入**:
- 源材料（可选）
- 关键词（可选）

**输出**:
- `research-report.md` - 调研报告

**示例**:
```bash
/writer:1-research "D:\Projects\我的小说"
```

---

### 阶段二：风格与背景设计

**命令**: `/writer:2-design`

**目的**:
- 设计写作风格
- 构建世界观和背景
- 定义角色和设定

**输出**:
- `design-document.md` - 设计文档
- `style-guide.md` - 风格指南（可选）
- `background.md` - 背景设定（可选）

---

### 阶段三：创作宪法文件

**命令**: `/writer:3-constitution`

**目的**:
- 定义创作原则和规范
- 设置质量标准
- 建立一致性规则

**输出**:
- `constitution.md` - 创作宪法

---

### 阶段四：情节设计与大纲编写

**命令**: `/writer:4-outline`

**目的**:
- 设计整体结构
- 编写详细大纲
- 规划章节内容

**参数**:
- `-Chapters <数量>` - 章节数量（默认3）

**输出**:
- `outline.md` - 详细大纲

**示例**:
```bash
/writer:4-outline -Chapters 10
```

---

### 阶段五：合规性审查

**命令**: `/writer:5-validate`

**目的**:
- 检查大纲合规性
- 验证一致性
- 发现潜在问题

**输出**:
- `validation-report.md` - 验证报告

---

### 阶段六：分章节编写

**命令**: `/writer:6-draft`

**目的**:
- 逐章编写内容
- 保持风格一致
- 遵循大纲和宪法

**参数**:
- `-Chapter <章节号>` - 要编写的章节

**输出**:
- `chapter-N.md` - 章节文件

**示例**:
```bash
/writer:6-draft -Chapter 1
/writer:6-draft -Chapter 2
```

---

### 阶段七：最终审查与导出

**命令**: `/writer:7-finalize`

**目的**:
- 合并所有章节
- 最终质量检查
- 导出多种格式

**输出**:
- `final-document.md` - 最终文档
- `final-document.pdf` - PDF版本（如果安装了pandoc）
- `final-document.docx` - Word版本（如果安装了pandoc）

---

## 命令参考

### 完整命令列表

| 命令 | 说明 | 必需参数 | 可选参数 |
|------|------|----------|----------|
| `/writer:init` | 初始化项目 | 项目名称 | 路径, 类型 |
| `/writer:1-research` | 内容调研 | 项目目录 | 源材料, 关键词 |
| `/writer:2-design` | 风格设计 | 项目目录 | 写作类型 |
| `/writer:3-constitution` | 创作宪法 | 项目目录 | - |
| `/writer:4-outline` | 大纲编写 | 项目目录 | 章节数 |
| `/writer:5-validate` | 合规性审查 | 项目目录 | - |
| `/writer:6-draft` | 章节编写 | 项目目录, 章节号 | - |
| `/writer:7-finalize` | 最终审查 | 项目目录 | 导出格式 |

### PowerShell脚本直接调用

如果不使用Augment命令，也可以直接调用PowerShell脚本：

```powershell
# 初始化项目
.\scripts\powershell\init-writer-project.ps1 -Name "我的小说" -Path "." -Type "novel"

# 调研
.\scripts\powershell\conduct-research.ps1 -ProjectDir ".\我的小说"

# 设计
.\scripts\powershell\create-design.ps1 -ProjectDir ".\我的小说"

# 宪法
.\scripts\powershell\create-constitution.ps1 -ProjectDir ".\我的小说"

# 大纲
.\scripts\powershell\create-outline.ps1 -ProjectDir ".\我的小说" -Chapters 10

# 验证
.\scripts\powershell\validate-outline.ps1 -ProjectDir ".\我的小说"

# 编写章节
.\scripts\powershell\write-chapter.ps1 -ProjectDir ".\我的小说" -Chapter 1

# 最终化
.\scripts\powershell\finalize-project.ps1 -ProjectDir ".\我的小说"
```

---

## 最佳实践

### 1. 项目组织

**推荐的项目结构**:
```
我的项目/
├── .writer/
│   ├── config.json          # 项目配置
│   ├── research/            # 调研资料
│   ├── design/              # 设计文档
│   ├── constitution/        # 创作宪法
│   ├── outline/             # 大纲
│   ├── chapters/            # 章节草稿
│   └── output/              # 最终输出
└── README.md
```

### 2. 工作流程建议

1. **不要跳过阶段**: 按顺序完成每个阶段
2. **充分调研**: 阶段一的质量决定后续质量
3. **遵循宪法**: 始终参考创作宪法保持一致性
4. **定期验证**: 在编写过程中多次运行验证
5. **版本控制**: 使用Git管理项目版本

### 3. 写作类型选择

| 类型 | 适用场景 | 建议章节数 |
|------|----------|------------|
| 学术论文 | 研究报告、毕业论文 | 5-8章 |
| 长篇小说 | 超过10万字的小说 | 20-50章 |
| 短篇小说 | 1-5万字的小说 | 3-10章 |
| 剧本 | 电影、电视剧本 | 按场景划分 |

---

## 常见问题

### Q1: 可以中途修改写作类型吗？

A: 可以，但建议在阶段一完成后尽早确定。修改类型可能需要重新执行某些阶段。

### Q2: 如何处理多个章节？

A: 使用循环或批处理脚本：
```powershell
1..10 | ForEach-Object {
    .\scripts\powershell\write-chapter.ps1 -ProjectDir ".\我的小说" -Chapter $_
}
```

### Q3: 支持哪些导出格式？

A: 默认支持Markdown。如果安装了pandoc，还支持PDF、DOCX、HTML等格式。

### Q4: 如何备份项目？

A: 整个项目目录都可以备份。建议使用Git进行版本控制。

---

## 故障排除

### 问题1: 命令找不到

**症状**: 运行命令时提示"命令未找到"

**解决方案**:
1. 确认在正确的目录下
2. 检查`.augment/commands/writer/`目录是否存在
3. 重新加载AI工具

### 问题2: PowerShell脚本执行失败

**症状**: 脚本报错或无输出

**解决方案**:
1. 检查PowerShell版本: `$PSVersionTable.PSVersion`
2. 确认脚本执行策略: `Get-ExecutionPolicy`
3. 如需要，设置执行策略: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

### 问题3: 编码问题

**症状**: 中文显示乱码

**解决方案**:
1. 确认所有文件使用UTF-8编码（无BOM）
2. 在PowerShell中设置: `[Console]::OutputEncoding = [System.Text.Encoding]::UTF8`

### 问题4: 项目配置损坏

**症状**: config.json文件错误

**解决方案**:
1. 备份当前config.json
2. 重新初始化项目
3. 手动恢复阶段状态

---

## 获取帮助

- **文档**: 查看`AGENTS.md`了解系统架构
- **示例**: 参考`examples/`目录下的示例项目
- **问题反馈**: 提交Issue到项目仓库

---

**祝您写作愉快！** ✍️

