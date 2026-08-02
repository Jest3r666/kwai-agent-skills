---
name: kwai-log-triage
description: 内部服务日志排障:按时间窗口与关键词检索、错误聚合、根因复盘。适合线上故障排查、错误率突增、慢请求归因类任务。
---

# kwai-log-triage

快手内部服务日志排障速查。核心流程:环境检查 → 检索 → 聚合 → 根因复盘。

## 1. 环境检查

```bash
bash scripts/probe.sh log-platform
```

不可达时按输出提示使用容灾入口(办公区外场景),见 `docs/FAQ.md`。

## 2. 检索

输入:服务名、时间窗(默认近 1 小时,上限 7 天)、关键词。

### 常用检索语法

| 意图 | 写法 | 说明 |
|------|------|------|
| 关键词 | `ERROR` / `"connection refused"` | 双引号精确匹配 |
| 逻辑 | `ERROR AND payment` / `ERROR NOT timeout` | 大写布尔 |
| 字段 | `level:error AND host:gw-03` | 字段:值 |
| 时间 | `@timestamp >= now-1h` | 时间窗 |
| 近似 | `timeout~2` | 模糊匹配,容错 2 字符 |

## 3. 聚合

- 按分钟聚合 ERROR 计数,画出变化曲线,定位突增起点
- 异常栈聚合,按首次出现次数取 Top10
- 常见模式:内存不足(OOM)、慢 SQL(>500ms)、下游超时(connect timeout)、限流(rate limit)

## 4. 根因复盘

- 复盘模板:现象 / 影响面 / 首个异常时间 / 根因假设 / 需确认项
- 假设优先验证时间线:变更发布 → 流量突增 → 依赖故障
- 复盘结论落盘 `docs/triage-YYYYMMDD.md`
