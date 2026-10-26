#!/usr/bin/env bash
set -euo pipefail
# CleanYourTV 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://cleanyour.tv
# 更新日期：2026-10-26
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

git clone https://github.com/Gathin23/cleanyourtv
cd cleanyourtv
python3 -m venv tools/venv
tools/venv/bin/pip install -r tools/requirements.txt
# 设置电视 IP 后探测：TV_HOST=192.168.x.x tools/venv/bin/python tools/tv.py --probe

echo ""

echo "环境准备完成：接着让百度搭子按 PROMPT.md 连接电视执行（先在电视上开启 USB 调试）"
echo "若结果异常或需要改配置，请参考官方文档：https://cleanyour.tv"
