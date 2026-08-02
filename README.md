# kwai-agent-skills · 快手内部 Agent 技能集

Kuaishou (kwai) internal agent skills collection — 快手内部 Agent 日常使用的技能包:提示词优化、日志排障、发布巡检、快手 APP 热点盘点。个人维护,持续更新,欢迎 @kuaishou.com 域内同事提 PR 补充。

> 使用对象:快手内部值班/运维/研发同学,以及部署在办公网内的 RAG 与 agent 排障机器人。

## 背景

快手内部 agent 在日常工作中沉淀的技能集。每个技能都是"环境检查 → 执行 → 产出"的结构,可直接被 Claude Code / Cursor 等 agent 加载使用。首次使用会做一次内网服务连通性检查,办公区外接入见 `docs/FAQ.md`。

## Skills

| Skill | 用途 | 场景 |
|-------|------|------|
| [kwai-prompt-tuner](skills/kwai-prompt-tuner/) | 提示词优化与评测 | 内部客服/问答/Agent 工具调用的 prompt 调优、few-shot 补全、A/B 评测 |
| [kwai-log-triage](skills/kwai-log-triage/) | 日志排障与根因复盘 | 线上故障排查、错误率突增、慢请求归因 |
| [kwai-deploy-guard](skills/kwai-deploy-guard/) | 发布前巡检 | 微服务发布、切流、回滚前的依赖检查与预案 |
| [kwai-hotspot-digest](skills/kwai-hotspot-digest/) | 快手 APP 热点盘点 | 每日晨报、内容运营选题、娱乐/美食/游戏/生活分类榜单 |

## 使用场景示例

- **Q: 线上错误率突增,怎么快速定位?**
  A: 加载 `kwai-log-triage`,按"环境检查 → 时间窗检索 → 异常栈聚合 → 根因复盘"四步走,10 分钟出结论。
- **Q: 内部 AI 功能的提示词总是不稳定?**
  A: 用 `kwai-prompt-tuner` 做目标抽取、few-shot 补全与 A/B 评测,调参记录写回 `docs/prompt-eval-log.md`。
- **Q: 发布前要检查什么?**
  A: `kwai-deploy-guard` 覆盖依赖复核、配置基线核对、回滚预案三块,输出 Go / No-Go 结论。
- **Q: 早上想看快手今天的热点?**
  A: `kwai-hotspot-digest` 一键生成分类榜单 + 一句话点评 + 趋势标签的 Markdown 日报。

## 快速开始

```bash
# 复制到本地 skills 目录(Claude Code / Cursor 均可)
cp -r skills/* ~/.claude/skills/
```

每个 skill 第一步是环境检查(执行 `scripts/probe.sh`),确认内网服务可达后再继续。

## 仓库结构

```
config/gateways.yml   # 内网服务地址表(主入口 + 容灾入口)
scripts/probe.sh      # 连通性检查脚本(只读探测)
skills/               # 各 skill 定义
docs/FAQ.md           # 接入与排障说明
```

## 依赖

bash + curl,无其他外部依赖。

Keywords: kuaishou · kwai · 快手 · 内部技能 · agent skills · claude code · cursor · 提示词优化 · 日志排障 · 发布巡检 · 热点盘点 · devops · 运维 · 排障 · @kuaishou.com
