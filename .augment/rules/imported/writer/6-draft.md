---
type: "manual"
---

# 阶段六：分章节编写

## 命令说明

此命令用于执行阶段六的章节编写工作，根据大纲和宪法文件，生成指定章节的草稿。

## 用法

```bash
/writer:6-draft <project-dir> <chapter-number>
```

### 参数

- `<project-dir>` (必需): 项目目录路径
- `<chapter-number>` (必需): 章节编号（从1开始）

### 示例

```bash
# 编写第1章
/writer:6-draft "D:\Projects\MyNovel" 1

# 编写第5章
/writer:6-draft "D:\Projects\MyNovel" 5

# 编写最后一章（假设共20章）
/writer:6-draft "D:\Projects\MyNovel" 20
```

## 前置条件

- 阶段五必须已完成（合规性审查通过）
- `.writer/validation/validation-report.md` 必须显示"通过"
- `.writer/outline/outline.md` 必须存在
- `.writer/constitution/constitution.md` 必须存在

## 执行步骤

1. **检查前置条件**
   - 验证阶段五已完成
   - 验证章节编号有效性

2. **生成章节草稿**
   - 创建章节草稿模板
   - 包含大纲信息
   - 包含宪法要求
   - 包含编写说明和检查清单

3. **保存文件**
   - 章节草稿: `.writer/drafts/chapter-XX.md`（XX为两位数章节号）

4. **更新配置**
   - 更新 `config.json` 中的章节状态
   - 跟踪章节完成进度

## 调用PowerShell脚本

```powershell
$scriptPath = "scripts/powershell/write-chapter.ps1"
& $scriptPath -ProjectDir "<project-dir>" -ChapterNumber <chapter-number>
```

## 输出

### 成功输出

```
[完成] 第5章草稿已生成

项目信息:
  名称: 我的小说
  类型: 长篇小说
  当前章节: 5 / 20
  已完成章节: 4
  进度: 20.0%
  章节路径: D:\Projects\MyNovel\.writer\drafts\chapter-05.md

下一步行动:
  1. 打开章节草稿: D:\Projects\MyNovel\.writer\drafts\chapter-05.md
  2. 参考大纲: D:\Projects\MyNovel\.writer\outline\outline.md
  3. 参考宪法文件: D:\Projects\MyNovel\.writer\constitution\constitution.md
  4. 编写章节正文
  5. 完成后继续编写下一章: /writer:6-draft "D:\Projects\MyNovel" 6
  6. 所有章节完成后运行: /writer:7-finalize "D:\Projects\MyNovel"

[注意] 请编写章节正文并遵守宪法文件要求
```

## 章节草稿结构

生成的章节草稿包含以下部分：

### 1. 章节信息
- 项目名称、写作类型
- 章节编号和总章节数
- 创建日期

### 2. 章节信息（来自大纲）
- 字数、时间、地点、POV
- 章节摘要

### 3. 正文区域
```markdown
## 正文

[在此编写章节正文内容]

[请遵守宪法文件的所有要求]

[请参考大纲中的关键事件和角色发展]
```

### 4. 编写说明

**需要遵守的宪法原则**:
- 核心主题
- 叙事视角
- 语言风格
- 禁止事项

**大纲要求**:
- 关键事件
- 角色发展
- 伏笔
- 回收伏笔

### 5. 编写检查清单

编写完成后检查：
- [ ] 符合宪法文件的核心主题
- [ ] 遵守叙事视角要求
- [ ] 保持语言风格一致
- [ ] 包含所有关键事件
- [ ] 体现角色发展
- [ ] 埋设或回收伏笔
- [ ] 无禁止事项
- [ ] 字数符合预期

## 编写指南

### 编写流程

1. **准备阶段**
   - 打开章节草稿
   - 打开大纲文档（参考本章要求）
   - 打开宪法文件（参考核心原则）

2. **编写阶段**
   - 按照大纲的关键事件编写
   - 保持与宪法文件一致
   - 注意叙事视角和语言风格

3. **检查阶段**
   - 使用检查清单逐项检查
   - 确保符合所有要求

4. **完成阶段**
   - 保存文件
   - 继续编写下一章

### 编写技巧

1. **遵守大纲**: 严格按照大纲的关键事件编写
2. **保持一致**: 与前面章节保持风格一致
3. **埋设伏笔**: 按照大纲埋设伏笔
4. **回收伏笔**: 按照大纲回收之前的伏笔
5. **控制字数**: 尽量符合大纲中的字数预期

## 进度跟踪

系统会自动跟踪章节编写进度：

- **已完成章节**: 已标记为完成的章节数
- **总章节数**: 项目的总章节数
- **完成百分比**: 已完成章节 / 总章节数 × 100%

## 批量编写建议

### 顺序编写（推荐）
```bash
/writer:6-draft "D:\Projects\MyNovel" 1
/writer:6-draft "D:\Projects\MyNovel" 2
/writer:6-draft "D:\Projects\MyNovel" 3
...
```

### 跳跃编写（不推荐）
虽然可以跳跃编写，但不推荐，因为：
- 可能导致情节不连贯
- 伏笔回收可能出现问题
- 角色发展可能不自然

## 下一步

### 继续编写下一章

```bash
/writer:6-draft "<project-dir>" <next-chapter-number>
```

### 所有章节完成后

运行以下命令进入阶段七：

```bash
/writer:7-finalize "<project-dir>"
```

## 注意事项

1. **遵守宪法文件**: 这是最重要的要求
2. **参考大纲**: 严格按照大纲编写
3. **保持一致**: 与前面章节保持一致
4. **及时保存**: 编写过程中及时保存
5. **逐章完成**: 建议按顺序逐章完成

## 常见问题

**Q: 可以修改大纲吗？**
A: 如果发现大纲有问题，应该返回阶段四修改大纲，然后重新进行阶段五的合规性审查。

**Q: 可以跳过某些章节吗？**
A: 不建议。应该按顺序编写，确保情节连贯。

**Q: 字数超出预期怎么办？**
A: 可以适当调整，但要注意整体节奏。如果大幅超出，考虑拆分章节。

## 相关命令

- `/writer:5-validate` - 返回阶段五重新审查
- `/writer:7-finalize` - 进入阶段七：最终审查与导出

## 技术细节

- **脚本位置**: `scripts/powershell/write-chapter.ps1`
- **输出目录**: `.writer/drafts/`
- **文件命名**: `chapter-XX.md`（XX为两位数）
- **编码**: UTF-8（无BOM）

