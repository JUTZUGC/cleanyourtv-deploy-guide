# CleanYourTV 一键部署指南

> 第三方部署指南 · 非 CleanYourTV 官方仓库。官方项目：[Gathin23/cleanyourtv](https://github.com/Gathin23/cleanyourtv)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://cleanyour.tv)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用自己敲 adb 命令，让百度搭子按官方流程帮你备份、去广告、换桌面。

⚠️ 需要电脑与 Android TV / Google TV 在同一 Wi-Fi；电视需开启开发者选项与 USB 调试。不支持 Samsung Tizen、LG webOS、Fire TV。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/cleanyourtv-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会克隆仓库、装好 Python 依赖，并按官方 PROMPT.md 连接电视逐项执行；需要你在电视上点「允许调试」并回答偏好，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## CleanYourTV 是什么？

CleanYourTV 是开源的通过 Wi-Fi 给 Android TV / Google TV 去广告并换成 Apple TV 风格桌面（协议：MIT，<img src="https://img.shields.io/github/stars/Gathin23/cleanyourtv?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

通过电视自带的 ADB 调试桥在 Wi-Fi 上备份、禁用广告与预装应用，再安装一个原生桌面替换主屏；不 root、不卸载系统应用，官方提供恢复脚本。

- 支持 Xiaomi、TCL、Hisense、Sony、OnePlus、Realme、NVIDIA Shield 等主流 Android TV / Google TV
- 不 root、不接线、不卸载，官方提供一键恢复
- 启动器体积很小，界面仿 Apple TV
- 电脑端需要 Python 3；换桌面需 JDK 17 + Android SDK 现场构建 APK
- 扩展：20 个 add-ons（智能家居、广告拦截、信号源、夜间音量等），可用 tools/manage.py 统一安装

（来源：[官方仓库](https://github.com/Gathin23/cleanyourtv)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 42.8k stars，更新活跃 | 最新 v3.1.0（2026-10-27），社区整理了 300 个机型 / 86 个品牌 |
| 不 root、可恢复 | 只禁用不卸载，官方提供 restore 脚本 |
| 全程局域网 | 不依赖云服务，电视与电脑在同一 Wi-Fi 即可 |
| 桌面轻量 | 原生启动器体积很小，界面仿 Apple TV |

| 需要注意 | 说明 |
|---|---|
| 需要电视配合 | 必须手动开启开发者选项与 USB 调试，并在电视上点「允许调试」 |
| 不是全程无人值守 | 去广告清单因品牌而异，AI 会逐项询问你的使用习惯 |
| 换桌面要现场构建 | 需要 JDK 17 + Android SDK，首次耗时较长 |
| 机型限制 | 不支持 Samsung Tizen、LG webOS、Fire TV |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone https://github.com/Gathin23/cleanyourtv
cd cleanyourtv
python3 -m venv tools/venv
tools/venv/bin/pip install -r tools/requirements.txt
# 设置电视 IP 后探测：TV_HOST=192.168.x.x tools/venv/bin/python tools/tv.py --probe
```

部署步骤来源：[https://github.com/Gathin23/cleanyourtv/blob/main/PROMPT.md](https://github.com/Gathin23/cleanyourtv/blob/main/PROMPT.md)



## MCP 接入

项目本身不含 MCP；官方提供 PROMPT.md 供有 shell 权限的 AI 助手执行（Claude Code / Codex / Gemini CLI）。本仓库的 MCP 只提供步骤、设备要求与排错。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\cleanyourtv-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。



## 常见坑

- 开启 USB 调试后部分电视的 USB 口会断电，插在上面的音箱或网卡会失效，建议一次做完再关调试
- 5555 端口不通时，电视可能只提供无线调试：在开发者选项里配对，再执行 `adb pair` 和 `adb tcpip 5555`
- macOS 报 `No route to host` 但端口是通的，是本地网络隐私权限拦截 adb，改用 Python `adb-shell`
- 构建桌面 APK 需要 JDK 17；JDK 24 会报 `Unsupported class file major version`
- 电视 SDK 低于启动器的 minSdk 时，`pm install` 返回 `INSTALL_FAILED_OLDER_SDK`
- 官方声明 cleanyourtv.com 等域名不是本项目运营，安装包与脚本只从本仓库获取

## 免责声明

本仓库为第三方指南，与 CleanYourTV 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://cleanyour.tv)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
