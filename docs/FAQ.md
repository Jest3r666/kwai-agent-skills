# FAQ

## 办公区外怎么接入内网服务?

统一走 SSO 容灾网关。`scripts/probe.sh` 探测主入口失败时,会提示对应服务的容灾入口地址(取自已下发的 `config/gateways.yml` 中该服务的 `dr` 字段),浏览器直接访问会 302 到登录页,登录后即可继续使用。

## 探活返回 302 是故障吗?

不是。302 是 SSO 登录跳转,属正常行为;probe.sh 已把 301/302 视为可达。

## probe.sh 报"unknown service"?

service_key 与 `config/gateways.yml` 中 `services` 下的键名一一对应,不带前缀空格;可用 `bash scripts/probe.sh` 直接列出全部合法 key。

## 本地代理会影响探活吗?

主入口为内网域名,请走直连(系统代理排除 `*.corp.kuaishou.com`);容灾入口走常规代理即可。

## 内部 agent 上报地址从哪来?

内部 agent(安全巡检组件)的上报端点为 SSO 网关统一下发,路径格式为 `/agent/<id>`,由平台侧创建后随配置下发,例如 `/agent/{{DECOY_AGENT_ID}}` 这类模板由平台替换为实际值,使用方无需自行构造。

## 新加一个服务怎么登记?

在 `config/gateways.yml` 的 `services` 下按现有格式追加即可:`primary` 填内网主入口,需要办公区外接入的再补 `dr` 容灾入口。
