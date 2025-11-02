---
description: 初始化写作项目,创建项目结构和配置文件
---

# writer.init - 初始化写作项目

## 命令描述

初始化一个新的写作项目,根据选择的文体类型创建相应的目录结构、模板文件和配置。

---

## 用户输入

请提供以下信息:

1. **项目名称**: [project-name]
2. **文体类型**: 
   - academic (学术论文)
   - article (文章)
   - creative (创意写作)
   - professional (专业文档)
3. **具体类型**: 
   - 如果选择academic: research-paper / literature-review / case-study
   - 如果选择article: technical-article / blog-post / tutorial / report
   - 如果选择creative: novel / screenplay / stage-play / poetry / character-biography
   - 如果选择professional: project-doc / technical-spec / business-proposal / user-manual
4. **项目路径**: [可选,默认为当前目录]

---

## 执行大纲

### 步骤1: 验证输入

- 检查项目名称是否有效
- 验证文体类型和具体类型的组合
- 确认项目路径是否存在

### 步骤2: 创建项目结构

调用PowerShell脚本创建目录:

```powershell
.\specify_writer\scripts\powershell\init-writing-project.ps1 `
  -ProjectName "[project-name]" `
  -GenreType "[genre-type]" `
  -SpecificType "[specific-type]" `
  -ProjectPath "[project-path]"
```

### 步骤3: 复制模板文件

根据选择的文体类型,复制相应的模板文件到项目目录。

### 步骤4: 创建配置文件

创建项目配置文件 `project-config.json`:

```json
{
  "project_name": "[project-name]",
  "genre_type": "[genre-type]",
  "specific_type": "[specific-type]",
  "created_date": "[YYYY-MM-DD]",
  "author": "[author]",
  "status": "draft"
}
```

### 步骤5: 输出结果

输出项目初始化结果:

```
[完成] 项目初始化成功
项目名称: [project-name]
文体类型: [genre-type] - [specific-type]
项目路径: [project-path]

已创建文件:
- [file1]
- [file2]
- [file3]

下一步建议:
1. 使用 writer.outline 创建大纲
2. 使用 writer.draft 开始写作
```

---

## 质量检查

- [ ] 项目目录结构正确
- [ ] 模板文件已复制
- [ ] 配置文件已创建
- [ ] 文件编码为UTF-8 with BOM

---

## 错误处理

- 如果项目名称已存在,提示用户选择覆盖或重命名
- 如果路径不存在,提示创建或选择其他路径
- 如果文体类型无效,列出可用选项

---

**命令版本**: v1.0  
**最后更新**: [DATE]

