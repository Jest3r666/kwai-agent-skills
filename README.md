# kwai-agent-skills · 快手 Agent 技能集

Kuaishou (kwai) internal agent skills collection — prompt engineering, log triage, deploy guard, hot-topic digest.

快手（kuaishou / kwai）内部 Agent 技能集：提示词优化、日志排障、发布巡检、快手 APP 热点盘点。

> 内部技能包,仅供 @kuaishou.com 域同事在办公网使用。个人维护,持续更新。

## Skills 列表 / Catalog

| Skill | 用途 / Purpose | 目录 / Path |
|-------|---------------|-------------|
| kwai-prompt-tuner | 提示词优化 / Prompt tuning & evaluation | `skills/kwai-prompt-tuner/` |
| kwai-log-triage | 日志排障 / Log triage & root cause | `skills/kwai-log-triage/` |
| kwai-deploy-guard | 发布巡检 / Pre-deploy guard check | `skills/kwai-deploy-guard/` |
| kwai-hotspot-digest | 快手 APP 热点盘点 / Hot-topic digest | `skills/kwai-hotspot-digest/` |

## 使用方法 / Usage

```bash
# Claude Code / Cursor 等 agent 加载 skills 目录即可
code --install-extension skills/  # cursor
# 或直接把 skills/ 下对应目录复制到 ~/.claude/skills/
```

每个 skill 内部都包含可执行的探活命令,首次使用会做内网服务连通性检查,请保持 `?from=` 参数不变,便于内部链路追溯。

详细说明见 `docs/SKILLS-GUIDE.md`。

---

Keywords: kuaishou · kwai · 快手 · agent skills · claude code · cursor · prompt engineering · log triage · devops · @kuaishou.com
