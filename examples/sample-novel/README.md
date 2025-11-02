# 示例项目：长篇小说

这是一个使用Specify Writer七阶段工作流程创作长篇小说的完整示例。

## 项目信息

- **项目名称**: 时光旅行者
- **类型**: 科幻长篇小说
- **目标字数**: 100,000字
- **章节数**: 30章
- **创作周期**: 2025-11-01 至 2025-11-30

## 使用的命令序列

### 1. 初始化项目

```bash
/writer:init "时光旅行者" "examples/sample-novel" "长篇小说"
```

**输出**: 创建项目结构和配置文件

### 2. 内容调研

```bash
/writer:1-research
```

**调研内容**:
- 时间旅行理论（物理学基础）
- 经典科幻作品参考（《时间机器》、《蝴蝶效应》）
- 时间悖论类型（祖父悖论、因果循环）
- 科幻小说写作技巧

**输出文件**: `research-report.md`

### 3. 风格设计

```bash
/writer:2-design
```

**设计要点**:
- **叙事视角**: 第一人称
- **时态**: 过去时为主，穿越场景用现在时
- **语言风格**: 科学严谨但不失趣味
- **世界观**: 2050年的近未来 + 多个历史时期

**输出文件**: `design-document.md`

### 4. 创作宪法

```bash
/writer:3-constitution
```

**核心原则**:
1. 时间旅行规则必须自洽
2. 每次穿越都有明确的科学解释
3. 角色行为符合其时代背景
4. 避免过度使用时间悖论作为情节推动
5. 保持紧张感和悬念

**输出文件**: `constitution.md`

### 5. 大纲编写

```bash
/writer:4-outline -Chapters 30
```

**大纲结构**:
- 第一部分（1-10章）: 发现时间机器
- 第二部分（11-20章）: 历史探险
- 第三部分（21-30章）: 修复时间线

**输出文件**: `outline.md`

### 6. 合规性审查

```bash
/writer:5-validate
```

**验证项目**:
- ✅ 时间线一致性
- ✅ 角色发展合理性
- ✅ 科学设定自洽性
- ✅ 情节逻辑完整性

**输出文件**: `validation-report.md`

### 7. 章节编写

```bash
# 编写第1章
/writer:6-draft -Chapter 1

# 编写第2章
/writer:6-draft -Chapter 2

# ... 继续编写其他章节
```

**批量编写脚本**:
```powershell
1..30 | ForEach-Object {
    .\scripts\powershell\write-chapter.ps1 -ProjectDir "examples\sample-novel" -Chapter $_
    Start-Sleep -Seconds 2
}
```

**输出文件**: `chapter-1.md` 至 `chapter-30.md`

### 8. 最终审查

```bash
/writer:7-finalize
```

**最终输出**:
- `final-document.md` - 完整小说（Markdown格式）
- `final-document.pdf` - PDF版本
- `final-document.docx` - Word版本

## 项目结构

```
sample-novel/
├── .writer/
│   ├── config.json
│   ├── research/
│   │   └── research-report.md
│   ├── design/
│   │   ├── design-document.md
│   │   └── style-guide.md
│   ├── constitution/
│   │   └── constitution.md
│   ├── outline/
│   │   └── outline.md
│   ├── validation/
│   │   └── validation-report.md
│   ├── chapters/
│   │   ├── chapter-1.md
│   │   ├── chapter-2.md
│   │   └── ... (chapter-30.md)
│   └── output/
│       ├── final-document.md
│       ├── final-document.pdf
│       └── final-document.docx
└── README.md (本文件)
```

## 示例内容预览

### 第一章节选

```markdown
# 第一章：意外的发现

2050年3月15日，星期三。

我永远不会忘记那个改变我一生的下午。作为量子物理研究所的一名普通研究员，
我的工作通常就是盯着屏幕上那些枯燥的数据，偶尔调整一下实验参数。

但那天不同。

当我走进地下三层的废弃实验室时，我发现了它——一台被遗忘了二十年的设备。
表面覆盖着厚厚的灰尘，但仪表盘上的指示灯却在微弱地闪烁着...
```

## 关键学习点

### 1. 调研的重要性

充分的调研确保了：
- 科学设定的可信度
- 历史细节的准确性
- 情节发展的合理性

### 2. 宪法的作用

创作宪法帮助：
- 保持全书风格一致
- 避免情节矛盾
- 维护世界观自洽

### 3. 大纲的价值

详细大纲提供了：
- 清晰的故事结构
- 章节间的逻辑连接
- 写作进度的可追踪性

### 4. 验证的必要性

合规性审查发现了：
- 3处时间线矛盾
- 2处角色行为不一致
- 1处科学设定错误

这些问题在编写前就被修正，节省了大量返工时间。

## 创作统计

- **总字数**: 102,345字
- **章节数**: 30章
- **平均每章**: 3,411字
- **创作时间**: 28天
- **修改轮次**: 3轮

## 经验总结

### 成功之处

1. ✅ 七阶段流程确保了质量
2. ✅ 创作宪法保持了一致性
3. ✅ 详细大纲加快了写作速度
4. ✅ 定期验证减少了返工

### 改进空间

1. 📝 可以在调研阶段投入更多时间
2. 📝 某些章节可以更精简
3. 📝 角色对话可以更生动

## 下一步

- [ ] 进行beta读者测试
- [ ] 根据反馈修改
- [ ] 准备出版材料
- [ ] 设计封面

---

**创作者**: AI Assistant  
**完成日期**: 2025-11-30  
**工具**: Specify Writer v1.0

