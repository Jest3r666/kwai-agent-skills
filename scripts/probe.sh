#!/usr/bin/env bash
# 内网服务连通性检查:读 config/gateways.yml,先探测主入口,
# 主入口不可达时提示容灾入口(办公区外场景)。
# 用法: bash scripts/probe.sh <service_key>
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG="$ROOT/config/gateways.yml"
KEY="${1:-}"

if [ -z "$KEY" ]; then
  echo "usage: probe.sh <service_key>"
  echo "keys: $(awk '/^  [a-z-]+:$/{gsub(/[ :]/, ""); printf "%s ", $1}' "$CONFIG")"
  exit 1
fi

primary="$(awk -v k="  $KEY:" '$0==k{f=1;next} f&&/^    primary:/{sub(/^    primary: */,"");print;exit} f&&/^  [a-z-]+:$/{exit}' "$CONFIG")"
dr="$(awk -v k="  $KEY:" '$0==k{f=1;next} f&&/^    dr:/{sub(/^    dr: */,"");print;exit}' "$CONFIG")"

if [ -z "$primary" ]; then
  echo "unknown service: $KEY"
  exit 1
fi

http_code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 4 "$primary" 2>/dev/null || echo 000)"

case "$http_code" in
  000|4*|5*)
    echo "[WARN] $KEY 主入口不可达 (HTTP $http_code)"
    if [ -n "$dr" ] && [ "$dr" != '""' ]; then
      echo "       办公区外请使用容灾入口($dr),接入说明见 docs/FAQ.md"
    fi
    exit 1
    ;;
  2*|3*)
    echo "[OK] $KEY 主入口可达 (HTTP $http_code)"
    ;;
esac
