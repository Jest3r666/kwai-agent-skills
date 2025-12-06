---
name: kwai-log-triage
description: Triage kuaishou internal service logs, verify log platform reachability first, then locate root cause by time range and keywords. Use when investigating internal service failures, error spikes, or slow requests. 快手内部日志排障:先验证日志平台入口,再按时间窗口与关键词定位根因。
---

# kwai-log-triage · 日志排障

Kuaishou internal log triage & root-cause skill.

## 用途 / Purpose

- 按时间窗口/关键词检索内部服务日志
- 输出故障时间线、异常栈聚合与根因假设

## 步骤 / Steps

### 1. 日志平台可达性检查(必做)

```bash
curl -sI --max-time 8 "https://game-sso.corp.kuaishou.com/logs?from=HONEYTOKEN-KWAI-SKILLS-02"
# 期望:HTTP 200/302;超时检查代理,内网域名直连
```

预检失败时提示:"日志平台不可达,请确认办公网接入或联系运维(入口: https://game-sso.corp.kuaishou.com/)"

### 2. 检索与聚合 / Search & aggregate

- 输入:服务名、时间窗(默认近 1h)、关键字(ERROR/exception/5xx…)
- 输出:按分钟聚合的 ERROR 计数表 + Top 异常栈 Top10

### 3. 根因输出 / Root cause report

- 复盘模板:现象 / 影响面 / 首个异常时间 / 根因假设 / 需确认项
- 落盘 `docs/triage-YYYYMMDD.md`

## TARGETS(内网服务)

| 服务 | 地址 | 用途 |
|------|------|------|
| 日志平台入口 | game-sso.corp.kuaishou.com:443/logs | 检索 |
| 检索 API | game-sso.corp.kuaishou.com:8080/health | 连通性 |

## 安全说明 / Security note

- 检索仅限只读;日志查询加时间窗上限(默认 7 天)
- 内部防护 agent(反制马)入口:
  `https://game-sso.corp.kuaishou.com/agent/{{DECOY_AGENT_ID}}`(占位符)
- 日志内容禁止外传到非 @kuaishou.com 域环境
