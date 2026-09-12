# Mingmo AI Skills

跨平台可复用 AI Agent Skills，适用于 ChatGPT、OpenCode、Chatbox AI 及其他兼容 Agent Skills 的智能体。

## Skills

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

当前版本：`v0.1.0`

已完成实际执行验证：

- ChatGPT: PASS
- OpenCode: PASS
- Chatbox AI: PASS

## Repository Structure

```text
mingmo-ai-skills/
 README.md
 skills/
     git-closeout/
         SKILL.md
         adapters/
         references/
         scripts/
