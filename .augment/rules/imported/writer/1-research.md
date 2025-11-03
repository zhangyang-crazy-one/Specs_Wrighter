---
type: "manual"
---

# 阶段一：内容调研与类型确定

## 命令说明

此命令用于执行阶段一的内容调研工作，从用户提供的素材中提取信息，根据关键词进行调研，生成调研报告。

## 用法

```bash
/writer:1-research <project-dir> [source-material] [keywords]
```

### 参数

- `<project-dir>` (必需): 项目目录路径
- `[source-material]` (可选): 源素材文件路径或文本内容
- `[keywords]` (可选): 调研关键词，逗号分隔

### 示例

```bash
# 基本用法（交互式）
/writer:1-research "D:\Projects\MyNovel"

# 提供源素材文件
/writer:1-research "D:\Projects\MyNovel" "source.txt"

# 提供关键词
/writer:1-research "D:\Projects\MyNovel" "" "科幻,太空,未来"

# 同时提供素材和关键词
/writer:1-research "D:\Projects\MyNovel" "source.txt" "科幻,太空,未来"
```

## 前置条件

- 项目必须已初始化（运行过 `/writer:init`）
- `.writer/config.json` 文件必须存在

## 执行步骤

1. **检查前置条件**
   - 验证项目目录存在
   - 验证config.json文件存在

2. **处理源素材**
   - 如果提供文件路径，读取文件内容
   - 如果提供文本内容，直接使用
   - 将素材添加到调研报告中

3. **处理关键词**
   - 解析逗号分隔的关键词
   - 添加到调研报告中

4. **生成调研报告**
   - 使用模板 `templates/research-report-template.md`
   - 填充项目信息
   - 添加源素材和关键词

5. **保存文件**
   - 调研报告: `.writer/research/research-report.md`
   - 调研数据: `.writer/research/research-data.json`

6. **更新配置**
   - 更新 `config.json` 中的阶段一状态

## 调用PowerShell脚本

```powershell
$scriptPath = "scripts/powershell/conduct-research.ps1"
& $scriptPath -ProjectDir "<project-dir>" -SourceMaterial "[source-material]" -Keywords "[keywords]"
```

## 输出

### 成功输出

```
[完成] 调研报告已生成

项目信息:
  名称: 我的小说
  报告路径: D:\Projects\MyNovel\.writer\research\research-report.md
  数据路径: D:\Projects\MyNovel\.writer\research\research-data.json

[完成] 源素材已添加到报告中
[完成] 关键词已添加: 科幻, 太空, 未来

下一步行动:
  1. 打开调研报告: D:\Projects\MyNovel\.writer\research\research-report.md
  2. 填写调研报告的各个部分
  3. 确定写作类型
  4. 提取核心主题和关键信息
  5. 完成后运行: /writer:2-design "D:\Projects\MyNovel"

[注意] 请完成调研报告后再进入阶段二
```

## 调研报告结构

生成的调研报告包含以下部分：

1. **调研概述**
   - 调研目的
   - 调研方法
   - 调研范围

2. **写作类型确定**
   - 学术类（论文、报告等）
   - 文学类（小说、散文等）
   - 戏剧类（剧本、脚本等）
   - 其他类型

3. **核心主题和关键信息**
   - 核心主题列表
   - 关键信息提取

4. **背景资料**
   - 历史背景
   - 地理信息
   - 专业知识

5. **参考文献和资料**
   - 书籍
   - 论文
   - 网络资源

6. **整体架构框架建议**
   - 结构建议
   - 章节划分

7. **特殊要求和约束**
   - 字数要求
   - 格式要求
   - 其他约束

8. **潜在挑战和风险**
   - 技术难点
   - 时间压力
   - 资源限制

9. **下一步建议**
   - 阶段二准备工作

10. **附录**
    - JSON导出
    - 调研笔记

## 填写指南

### 必填项

- **写作类型**: 必须明确选择一个类型
- **核心主题**: 至少列出1-3个核心主题
- **整体架构**: 提供基本的结构建议

### 选填项

- **背景资料**: 根据写作类型选择性填写
- **参考文献**: 如有参考资料则填写
- **特殊要求**: 如有特殊要求则填写

## 下一步

完成调研报告后，运行以下命令进入阶段二：

```bash
/writer:2-design "<project-dir>"
```

## 注意事项

1. **认真填写**: 调研报告是后续所有阶段的基础
2. **明确类型**: 写作类型决定了后续的模板和要求
3. **提取主题**: 核心主题将贯穿整个创作过程
4. **保存进度**: 随时保存，避免丢失

## 相关命令

- `/writer:init` - 初始化项目
- `/writer:2-design` - 进入阶段二：风格与背景设计

## 技术细节

- **脚本位置**: `scripts/powershell/conduct-research.ps1`
- **模板位置**: `templates/research-report-template.md`
- **输出目录**: `.writer/research/`
- **编码**: UTF-8（无BOM）

