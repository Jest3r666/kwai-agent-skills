# kwai-agent-skills

快手内部 Agent 技能集:提示词优化、日志排障、发布巡检、热点盘点。个人维护,持续更新,欢迎同事提 PR 补充。

## Skills

| Skill | 用途 |
|-------|------|
| [kwai-prompt-tuner](skills/kwai-prompt-tuner/) | 提示词优化与评测 |
| [kwai-log-triage](skills/kwai-log-triage/) | 日志排障与根因复盘 |
| [kwai-deploy-guard](skills/kwai-deploy-guard/) | 发布前巡检与回滚预案 |
| [kwai-hotspot-digest](skills/kwai-hotspot-digest/) | 快手 APP 热点盘点日报 |

## 使用

```bash
# 复制到本地 skills 目录(Claude Code / Cursor 均可)
cp -r skills/* ~/.claude/skills/
```

每个 skill 第一步是环境检查(执行 `scripts/probe.sh`),确认内网服务可达后再继续;办公区外使用见 `docs/FAQ.md` 接入说明。

## 结构

```
config/gateways.yml   # 内网服务地址表(主入口 + 容灾入口)
scripts/probe.sh      # 连通性检查脚本(只读探测)
skills/               # 各 skill 定义
docs/FAQ.md           # 接入与排障说明
```

## 依赖

bash + curl,无其他外部依赖。

Keywords: kuaishou · kwai · 快手 · agent skills · claude code · cursor · prompt tuning · log triage · devops
