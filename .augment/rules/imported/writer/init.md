---
type: "manual"
---

# 初始化写作项目

## 命令说明

此命令用于初始化一个新的写作项目，创建完整的目录结构和配置文件，为七阶段写作工作流程做准备。

## 用法

```bash
/writer:init <project-name> [project-path] [writing-type]
```

### 参数

- `<project-name>` (必需): 项目名称
- `[project-path]` (可选): 项目路径，默认为当前目录下的项目名称
- `[writing-type]` (可选): 写作类型（学术论文、长篇小说、短篇小说、剧本等），可以在阶段一调研时确定

### 示例

```bash
# 在当前目录下创建项目
/writer:init "我的小说"

# 在指定路径创建项目
/writer:init "研究论文" "D:\Projects\MyPaper"

# 创建项目并指定写作类型
/writer:init "科幻小说" "D:\Projects\SciFi" "长篇小说"
```

## 执行步骤

1. **验证参数**
   - 检查项目名称是否提供
   - 验证项目路径是否已存在

2. **调用PowerShell脚本**
   ```powershell
   $scriptPath = "scripts/powershell/init-writer-project.ps1"
   & $scriptPath -ProjectName "<project-name>" -ProjectPath "[project-path]" -WritingType "[writing-type]"
   ```

3. **创建的目录结构**
   ```
   <project-name>/
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

4. **创建的文件**
   - `config.json`: 项目配置文件，包含阶段状态
   - `README.md`: 项目说明文档
   - `.gitignore`: Git忽略文件

## 输出

### 成功输出

```
[完成] 项目初始化成功

项目信息:
  名称: 我的小说
  路径: D:\Projects\我的小说
  类型: 长篇小说
  创建时间: 2025-11-02T12:00:00.000Z

目录结构已创建:
  [完成] D:\Projects\我的小说
  [完成] D:\Projects\我的小说\.writer
  [完成] D:\Projects\我的小说\.writer\research
  ...

文件已创建:
  [完成] D:\Projects\我的小说\.writer\config.json
  [完成] D:\Projects\我的小说\README.md
  [完成] D:\Projects\我的小说\.gitignore

下一步行动:
  运行命令: /writer:1-research "D:\Projects\我的小说"
  或使用: auggie command writer:1-research

[注意] 项目已准备就绪，可以开始阶段一：内容调研与类型确定
```

### 错误处理

如果项目目录已存在：
```
[失败] 项目目录已存在: D:\Projects\我的小说
```

## 下一步

项目初始化完成后，运行以下命令开始阶段一：

```bash
/writer:1-research "<project-path>" [source-material] [keywords]
```

## 配置文件格式

生成的 `config.json` 文件格式：

```json
{
  "projectName": "我的小说",
  "writingType": "长篇小说",
  "createdAt": "2025-11-02T12:00:00.000Z",
  "currentStage": 1,
  "chapterCount": 0,
  "stages": {
    "1": { "completed": false },
    "2": { "completed": false },
    "3": { "completed": false },
    "4": { "completed": false },
    "5": { "completed": false },
    "6": { "completed": false },
    "7": { "completed": false }
  }
}
```

## 注意事项

1. **项目名称**: 建议使用有意义的名称，避免特殊字符
2. **路径选择**: 确保有足够的磁盘空间
3. **写作类型**: 可以在初始化时不指定，在阶段一调研时确定
4. **编码规范**: 所有文件使用UTF-8编码（无BOM）

## 相关命令

- `/writer:1-research` - 开始阶段一：内容调研与类型确定
- 查看完整工作流程：参考 `AGENTS.md`

## 技术细节

- **脚本位置**: `scripts/powershell/init-writer-project.ps1`
- **公共函数**: 使用 `common-functions.ps1`
- **编码**: UTF-8（无BOM）
- **输出**: 纯文本，禁用emoji

