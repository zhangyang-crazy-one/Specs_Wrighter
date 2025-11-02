---
description: 导出文档为不同格式
---

# writer.export - 导出文档

## 命令描述

将Markdown文档导出为其他格式(PDF、DOCX、HTML等)。

---

## 用户输入

请提供以下信息:

1. **项目路径**: [project-path]
2. **导出格式**: 
   - pdf
   - docx
   - html
3. **输出路径**: [可选,默认为项目目录]

---

## 执行大纲

### 步骤1: 验证输入

检查源文件和输出路径。

### 步骤2: 调用导出脚本

```powershell
.\specify_writer\scripts\powershell\export-document.ps1 `
  -SourcePath "[source-path]" `
  -Format "[format]" `
  -OutputPath "[output-path]"
```

### 步骤3: 输出结果

```
[完成] 文档导出成功
格式: [format]
输出路径: [output-path]
文件大小: [size]
```

---

## 质量检查

- [ ] 导出格式正确
- [ ] 内容完整
- [ ] 格式保留良好

---

**命令版本**: v1.0  
**最后更新**: [DATE]

