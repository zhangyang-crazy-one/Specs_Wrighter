---
type: "manual"
---

# 阶段七：最终审查与导出

## 命令说明

此命令用于执行阶段七的最终审查和导出工作，合并所有章节，进行最终审查，导出为多种格式。

## 用法

```bash
/writer:7-finalize <project-dir> [export-format]
```

### 参数

- `<project-dir>` (必需): 项目目录路径
- `[export-format]` (可选): 导出格式，逗号分隔，默认为 "markdown,pdf,docx"

### 示例

```bash
# 使用默认格式（Markdown, PDF, DOCX）
/writer:7-finalize "D:\Projects\MyNovel"

# 仅导出Markdown
/writer:7-finalize "D:\Projects\MyNovel" "markdown"

# 导出Markdown和PDF
/writer:7-finalize "D:\Projects\MyNovel" "markdown,pdf"
```

## 前置条件

- 阶段六必须已完成（所有章节编写完成）
- 所有章节的草稿文件必须存在
- 所有章节必须标记为已完成

## 执行步骤

1. **检查前置条件**
   - 验证阶段六已完成
   - 验证所有章节都已完成

2. **合并所有章节**
   - 读取每个章节的正文部分
   - 按顺序合并为完整作品
   - 添加项目信息和元数据

3. **保存完整作品**
   - Markdown格式: `.writer/final/<项目名称>.md`

4. **导出其他格式**（如果需要）
   - PDF格式（需要Pandoc）
   - DOCX格式（需要Pandoc）

5. **生成项目统计**
   - 保存项目统计信息: `.writer/final/project-stats.json`

6. **更新配置**
   - 更新 `config.json` 中的阶段七状态
   - 标记项目为已完成

## 调用PowerShell脚本

```powershell
$scriptPath = "scripts/powershell/finalize-project.ps1"
& $scriptPath -ProjectDir "<project-dir>" -ExportFormat "[export-format]"
```

## 输出

### 成功输出

```
[完成] 项目已完成！

项目信息:
  名称: 我的小说
  类型: 长篇小说
  章节数: 20
  创建时间: 2025-11-02T12:00:00.000Z
  完成时间: 2025-11-15T18:30:00.000Z

导出文件:
  [完成] D:\Projects\MyNovel\.writer\final\我的小说.md

下一步行动:
  1. 查看完整作品: D:\Projects\MyNovel\.writer\final\我的小说.md
  2. 查看项目统计: D:\Projects\MyNovel\.writer\final\project-stats.json
  3. 如需导出PDF: pandoc "D:\Projects\MyNovel\.writer\final\我的小说.md" -o "D:\Projects\MyNovel\.writer\final\我的小说.pdf"
  4. 如需导出DOCX: pandoc "D:\Projects\MyNovel\.writer\final\我的小说.md" -o "D:\Projects\MyNovel\.writer\final\我的小说.docx"

[完成] 恭喜！七阶段写作工作流程已全部完成！
```

## 完整作品结构

合并后的完整作品包含：

```markdown
# <项目名称>

**写作类型**: <写作类型>
**完成日期**: <完成日期>
**总章节数**: <章节数>

---

[第1章正文]

---

[第2章正文]

---

...

---

[最后一章正文]
```

## 项目统计信息

生成的 `project-stats.json` 包含：

```json
{
  "projectName": "我的小说",
  "writingType": "长篇小说",
  "chapterCount": 20,
  "createdAt": "2025-11-02T12:00:00.000Z",
  "completedAt": "2025-11-15T18:30:00.000Z",
  "stages": {
    "1": { "completed": true, "reportPath": "...", ... },
    "2": { "completed": true, "designPath": "...", ... },
    "3": { "completed": true, "constitutionPath": "...", ... },
    "4": { "completed": true, "outlinePath": "...", ... },
    "5": { "completed": true, "reportPath": "...", ... },
    "6": { "completed": true, "chapters": {...}, ... },
    "7": { "completed": true, "finalPath": "...", ... }
  }
}
```

## 导出格式

### Markdown（默认）
- 自动生成，无需额外工具
- 文件: `<项目名称>.md`
- 编码: UTF-8（无BOM）

### PDF（需要Pandoc）
- 需要安装Pandoc工具
- 命令: `pandoc "<文件>.md" -o "<文件>.pdf"`
- 支持自定义样式

### DOCX（需要Pandoc）
- 需要安装Pandoc工具
- 命令: `pandoc "<文件>.md" -o "<文件>.docx"`
- 可在Word中进一步编辑

## 安装Pandoc

### Windows
```bash
# 使用Chocolatey
choco install pandoc

# 或下载安装包
# https://pandoc.org/installing.html
```

### macOS
```bash
brew install pandoc
```

### Linux
```bash
sudo apt-get install pandoc
```

## 最终审查建议

在导出之前，建议进行最终审查：

1. **通读全文**
   - 检查整体连贯性
   - 检查风格一致性

2. **检查细节**
   - 错别字和语法错误
   - 标点符号
   - 格式问题

3. **验证要求**
   - 对照宪法文件检查
   - 确保符合所有要求

4. **优化润色**
   - 语言润色
   - 节奏优化
   - 细节完善

## 后续工作

项目完成后，您可以：

1. **版本控制**
   - 使用Git管理项目
   - 创建版本标签

2. **备份**
   - 备份整个项目目录
   - 备份导出的文件

3. **分享**
   - 导出为PDF或DOCX分享
   - 发布到写作平台

4. **归档**
   - 整理项目文件
   - 保存项目统计

## 项目目录结构

完成后的项目目录：

```
<项目名称>/
├── .writer/
│   ├── config.json              # 项目配置
│   ├── research/
│   │   ├── research-report.md   # 调研报告
│   │   └── research-data.json   # 调研数据
│   ├── design/
│   │   └── design-document.md   # 设计文档
│   ├── constitution/
│   │   └── constitution.md      # 宪法文件
│   ├── outline/
│   │   └── outline.md           # 大纲
│   ├── validation/
│   │   └── validation-report.md # 验证报告
│   ├── drafts/
│   │   ├── chapter-01.md        # 章节草稿
│   │   ├── chapter-02.md
│   │   └── ...
│   └── final/
│       ├── <项目名称>.md        # 完整作品
│       ├── <项目名称>.pdf       # PDF版本（可选）
│       ├── <项目名称>.docx      # DOCX版本（可选）
│       └── project-stats.json   # 项目统计
├── README.md
└── .gitignore
```

## 注意事项

1. **确保完成**: 所有章节都必须完成
2. **最终检查**: 导出前进行最终检查
3. **备份重要**: 导出后及时备份
4. **格式选择**: 根据需要选择导出格式

## 常见问题

**Q: 导出PDF失败怎么办？**
A: 确保已安装Pandoc工具，并检查Pandoc是否在系统PATH中。

**Q: 可以修改导出的文件吗？**
A: 可以。导出的文件是独立的，可以自由修改。

**Q: 如何重新导出？**
A: 可以再次运行 `/writer:7-finalize` 命令，会覆盖之前的导出文件。

## 相关命令

- `/writer:6-draft` - 返回阶段六编写章节
- `/writer:init` - 开始新项目

## 技术细节

- **脚本位置**: `scripts/powershell/finalize-project.ps1`
- **输出目录**: `.writer/final/`
- **编码**: UTF-8（无BOM）
- **Pandoc文档**: https://pandoc.org/

---

**恭喜您完成了七阶段写作工作流程！**

