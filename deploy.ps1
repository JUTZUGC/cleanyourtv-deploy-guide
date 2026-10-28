# CleanYourTV 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://cleanyour.tv
# 更新日期：2026-10-28
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

git clone https://github.com/Gathin23/cleanyourtv
cd cleanyourtv
python -m venv tools\venv
tools\venv\Scripts\pip install -r tools\requirements.txt
# 设置电视 IP 后探测：$env:TV_HOST="192.168.x.x"; tools\venv\Scripts\python tools\tv.py --probe

Write-Host ''

Write-Host '环境准备完成：接着让百度搭子按 PROMPT.md 连接电视执行（先在电视上开启 USB 调试）'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://cleanyour.tv'
