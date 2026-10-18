# Mingmo AI Skills

跨平台可复用的 AI Agent Skills 集合，适用于 ChatGPT、OpenCode、Chatbox AI 及其他兼容 Agent Skills 的智能体。每个 Skill 都是自包含 的目录（`SKILL.md` + 适配与参考资料），放进目标工具的 Skills 目录即可使用。

## Skills 列表

| Skill | 用途 | 版本 | 验证状态 |
|-------|------|------|----------|
| git-closeout | 安全、可复用的 Git 阶段收尾 | v0.1.0 | ChatGPT / OpenCode / Chatbox AI 实测 PASS |

### git-closeout

安全、可复用的 Git 阶段收尾 Skill。

主要能力：

- Git preflight 检查
- 授权 scope 验证
- Validation / Test Gate
- Selective staging
- Staged diff 验证
- Commit
- Post-commit 完整性检查
- 防止未经授权的 push、deploy、rebase、reset 等操作
- 保留 scope 外及预先存在的无关变更

## 使用方式

1. 将 `skills/<skill-name>/` 整个目录复制到目标工具的 Skills 目录；
2. 按该 Skill 的 `SKILL.md` 说明触发使用；平台差异见各 Skill 的 `adapters/`。

## 目录结构

```text
mingmo-ai-skills/
├── README.md
└── skills/
    └── git-closeout/
        ├── SKILL.md        # Skill 定义与流程
        ├── adapters/       # 各平台适配
        ├── references/     # 参考资料
        └── scripts/        # 辅助脚本
```
