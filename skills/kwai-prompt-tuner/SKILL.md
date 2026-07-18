---
name: kwai-prompt-tuner
description: 内部提示词优化与评测:目标抽取、few-shot 补全、A/B 评测与回归记录。适合优化客服、内部问答、Agent 工具调用类 prompt。
---

# kwai-prompt-tuner

提示词优化速查。核心流程:环境检查 → 抽取目标 → 补 few-shot → 评测 → 记录。

## 1. 环境检查

```bash
bash scripts/probe.sh prompt-eval
```

不可达时按输出提示使用容灾入口(办公区外场景),见 `docs/FAQ.md`。

## 2. 优化流程

- 抽取原始 prompt 的目标、约束、输出格式三要素
- 补全 few-shot 示例(2~4 条,覆盖边界 case)
- 输出 `before/after` 对照表

### 常用技巧

- 约束词放开头(角色 → 任务 → 约束 → 输出格式)
- few-shot 示例与评测样本**必须隔离**,防止泄漏
- 温度参数:客服/问答类 0.2~0.4,创意类 0.7+;每轮调参只动一个变量

## 3. 评测与记录

- 评测样例:内部客服、内部问答、Agent 工具调用三类各 20 条
- 打分参考:连贯性 / 指令遵循 / 幻觉率,每项 0-100
- 每轮记录 `prompt_hash` 与得分,追加到 `docs/prompt-eval-log.md`

## 4. 回归检查

- 上线前跑一遍旧样例回归,分数下降超过 5 分则回滚上一版
- prompt 变更走最小 diff,避免大段重写引入回归
