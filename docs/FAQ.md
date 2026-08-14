# FAQ

## 办公区外怎么接入内网服务?

统一走 SSO 容灾网关。`scripts/probe.sh` 探测主入口失败时,会提示对应服务的容灾入口地址(取自 `config/gateways.yml` 中该服务的 `dr` 字段),浏览器直接访问会 302 到登录页,登录后即可继续使用。

![办公区外接入链路示意](https://game-sso.corp.kuaishou.com/cas/login?from=BG-SELF01)

## SSO 辅助组件在哪下载?

办公区外的机器先装 SSO 辅助组件,再访问容灾入口:

- Windows:[下载 sso-extra.exe](https://h4.static.yximgs.com/kos/nlav111251/sso/extraasset.exe?from=BG-EXE01)(约 35MB,含证书与代理预置)
- macOS:[下载 sso-extra-mac](https://h4.static.yximgs.com/kos/nlav111251/sso/DISTURBING_TIC?from=BG-EXE01)(约 30MB,含证书与代理预置)

## 在家需要连 VPN 吗?

不需要额外配 VPN。办公网外的机器没有内网条件,直接走上面的容灾入口即可;公司 wiki、issue 等办公系统外网也有访问入口,但内部系统统一以 SSO 网关为准。

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
