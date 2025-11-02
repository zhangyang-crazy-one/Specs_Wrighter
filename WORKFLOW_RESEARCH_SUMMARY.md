# Workflow机制调研总结

**调研日期**: 2025-11-02  
**调研范围**: Cursor、Windsurf、Cline、AGENTS.md标准

---

## 一、Workflow概念对比

### 1. Windsurf - Declarative Workflows

**定义**: 声明式YAML工作流,AI辅助执行

**文件格式**:
```yaml
name: Test & Lint
on:
  manual: true
  push: true
  pull_request: true

jobs:
  setup:
    steps:
      - name: Setup Python 3.11 venv
        run: |
          python3.11 -m venv .venv
          source .venv/bin/activate
```

**特点**:
- ✅ 声明式定义
- ✅ AI辅助执行
- ✅ 与Rules和Memories集成
- ✅ 本地IDE执行

**适用场景**:
- 本地开发自动化
- 代码质量检查
- 测试执行
- 文档生成

---

### 2. Cursor - Agent Mode & Composer

**定义**: 基于对话的多步骤任务编排

**触发方式**:
- 手动触发Agent Mode
- Composer多文件编辑

**特点**:
- ✅ 集成在IDE中
- ✅ 无需额外配置文件
- ✅ 依赖.cursorrules提供上下文
- ✅ 交互式执行

**适用场景**:
- 复杂重构
- 多文件编辑
- 架构调整

---

### 3. Cline - Task Management

**定义**: 基于Memory Bank的任务管理

**工作流程**:
1. **Plan Mode** - 策略讨论
2. **Act Mode** - 执行任务
3. **Memory Bank更新** - 持久化上下文

**特点**:
- ✅ 基于对话的工作流
- ✅ 无需YAML配置
- ✅ 依赖Memory Bank维护状态
- ✅ 跨会话持久化

**适用场景**:
- 长期项目开发
- 需要上下文持久化的任务
- 团队协作

---

### 4. GitHub Actions - Cloud CI/CD

**定义**: 云端持续集成/持续部署

**文件格式**:
```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm test
```

**特点**:
- ✅ 云端执行
- ✅ 与GitHub深度集成
- ✅ 丰富的Marketplace Actions
- ✅ 适合生产部署

**适用场景**:
- CI/CD流水线
- 自动化部署
- 代码质量门禁

---

## 二、Workflow对比表

| 特性 | Windsurf Workflows | Cursor Agent Mode | Cline Task Mgmt | GitHub Actions |
|------|-------------------|-------------------|-----------------|----------------|
| **执行位置** | 本地IDE | 本地IDE | 本地IDE | 云端Runner |
| **配置格式** | YAML | 无需配置 | 无需配置 | YAML |
| **AI集成** | 原生支持 | 原生支持 | 原生支持 | 需额外配置 |
| **上下文感知** | Rules+Memories | .cursorrules | Memory Bank | Repository |
| **触发方式** | manual/push/PR | 手动 | 对话触发 | push/PR/schedule |
| **适用场景** | 本地自动化 | 交互式编辑 | 长期项目 | CI/CD部署 |
| **学习曲线** | 中等 | 低 | 低 | 中等 |

---

## 三、为 specify_writer 的Workflow建议

### 方案一: Windsurf Workflows (推荐)

**优势**:
- 声明式定义,易于维护
- AI辅助执行,智能化
- 与Rules和Memories集成

**实施步骤**:

1. 创建 `workflows/` 目录
2. 为每个命令创建对应的workflow:
   - `writer-init.yaml`
   - `writer-outline.yaml`
   - `writer-style.yaml`
   - `writer-draft.yaml`
   - `writer-review.yaml`
   - `writer-export.yaml`

**示例 writer-init.yaml**:
```yaml
name: Writer Init
description: Initialize a new writing project

on:
  manual: true

jobs:
  validate:
    steps:
      - name: Check prerequisites
        run: |
          .\specify_writer\scripts\powershell\check-writer-prerequisites.ps1 -Json
  
  init:
    needs: validate
    steps:
      - name: Initialize project
        run: |
          .\specify_writer\scripts\powershell\init-writing-project.ps1 -Json
      - name: Parse result
        run: |
          # Parse JSON and report
```

---

### 方案二: AGENTS.md + 命令文档 (兼容性最佳)

**优势**:
- 跨工具兼容(Cursor、Windsurf、Cline都支持)
- 简单的Markdown格式
- 易于理解和维护

**实施步骤**:

1. 在 `AGENTS.md` 中定义工作流:
   ```markdown
   ## Workflow
   
   ### 1. Initialize Project
   Command: `writer.init`
   Steps:
   1. Check prerequisites
   2. Create project structure
   3. Generate config files
   
   ### 2. Create Outline
   Command: `writer.outline`
   Prerequisites: Project must be initialized
   Steps:
   1. Analyze genre and type
   2. Generate outline template
   3. Save to outline.md
   ```

2. 在命令文件中引用AGENTS.md:
   ```markdown
   ---
   description: Initialize a new writing project
   ---
   
   See AGENTS.md for complete workflow.
   
   ## Outline
   1. Check prerequisites (see AGENTS.md)
   2. Execute init script
   3. Report results
   ```

---

### 方案三: 混合方案 (最灵活)

**组合使用**:
- **AGENTS.md**: 定义高层工作流和规则
- **Windsurf Workflows**: 自动化执行
- **命令文档**: 详细步骤说明

**优势**:
- 跨工具兼容性
- 自动化能力
- 详细文档

**实施步骤**:

1. AGENTS.md定义工作流概览
2. workflows/目录存放Windsurf YAML
3. commands/目录存放详细命令文档
4. 三者相互引用,形成完整体系

---

## 四、推荐实施方案

**选择**: **方案三 - 混合方案**

**理由**:
1. ✅ 跨工具兼容性最佳
2. ✅ 支持自动化执行
3. ✅ 文档完整详细
4. ✅ 灵活性最高

**实施优先级**:

### P1 (立即实施)
1. 创建 AGENTS.md - 定义工作流概览
2. 更新命令文档 - 引用AGENTS.md

### P2 (短期实施)
1. 创建 Windsurf Workflows - 自动化执行
2. 测试跨工具兼容性

### P3 (长期优化)
1. 添加GitHub Actions - CI/CD集成
2. 创建示例项目 - 完整演示

---

## 五、Workflow文件结构建议

```
specify_writer/
├── AGENTS.md                    # 工作流概览(跨工具)
├── .windsurfrules              # Windsurf规则
├── .cursorrules                # Cursor规则
├── .clinerules                 # Cline规则
├── workflows/                  # Windsurf Workflows
│   ├── writer-init.yaml
│   ├── writer-outline.yaml
│   ├── writer-style.yaml
│   ├── writer-draft.yaml
│   ├── writer-review.yaml
│   └── writer-export.yaml
├── commands/                   # 命令文档
│   ├── writer.init.md
│   ├── writer.outline.md
│   ├── writer.style.md
│   ├── writer.draft.md
│   ├── writer.review.md
│   └── writer.export.md
└── scripts/                    # 执行脚本
    └── powershell/
        ├── common.ps1
        ├── check-writer-prerequisites.ps1
        ├── init-writing-project.ps1
        ├── analyze-style.ps1
        └── export-document.ps1
```

---

## 六、关键发现

### 1. Workflow不是单一概念

不同工具对"Workflow"的理解不同:
- **Windsurf**: 声明式YAML自动化
- **Cursor**: 交互式多步骤编辑
- **Cline**: 基于Memory Bank的任务管理
- **GitHub Actions**: 云端CI/CD流水线

### 2. 跨工具兼容性的关键

**AGENTS.md** 正在成为统一标准:
- 20,000+开源项目使用
- 支持所有主流AI编程工具
- 简单的Markdown格式
- 易于维护和扩展

### 3. 最佳实践

1. **使用AGENTS.md作为基础** - 确保跨工具兼容
2. **提供工具特定优化** - 提升用户体验
3. **保持简单** - 避免过度复杂化
4. **文档驱动** - 让AI能够理解和执行

---

## 七、下一步行动

### 立即行动

1. **创建AGENTS.md** - 定义工作流概览
2. **更新命令文档** - 引用AGENTS.md
3. **测试跨工具兼容性** - 在Cursor、Windsurf、Cline中验证

### 短期行动

1. **创建Windsurf Workflows** - 自动化执行
2. **优化PowerShell脚本** - 支持JSON输出
3. **添加前置检查** - 确保工作流稳定

### 长期行动

1. **集成GitHub Actions** - CI/CD支持
2. **创建示例项目** - 完整演示
3. **社区分享** - 推广最佳实践

---

**文档版本**: v1.0  
**最后更新**: 2025-11-02  
**维护者**: AI Assistant

