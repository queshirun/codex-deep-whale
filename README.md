# Codex Deep Whale · DeepSeek 鲸鱼娘主题

[中文](README.md) · [English](README.en.md)

把 [dsh-deep-whale](https://github.com/Small-tailqwq/dsh-deep-whale) 的“深海女仆工坊”适配为 [Codex Dream Skin](https://github.com/Fei-Away/Codex-Dream-Skin) 主题。本项目只保留画面右侧拿笔和本子的鲸鱼娘，提供日间与夜间主题。

| 日间 | 夜间 |
| --- | --- |
| ![深海女仆工坊日间](themes/maid-atelier-day/background.png) | ![深海女仆工坊夜间](themes/maid-atelier-night/background.png) |

## v1.4.2 功能

- 背景图保持完整，正文、图标和输入区使用高对比毛玻璃界面。
- 左侧历史栏底部显示固定尺寸 Q 版鲸鱼娘；收起侧栏时同步移动并由窗口左边框裁切。
- 清除输入区和“文件已更改”提示附近的黑色渐变边缘。
- 隐藏顶部“深海女仆工坊 / DEEP WHALE · CODEX”和 `WHALE MAID ONLINE / NIGHT SHIFT ONLINE` 装饰文字，保留项目标题、菜单及窗口控制按钮。
- 修复从 PowerShell 7 启动时 Dream Skin 误判注入器身份的问题。
- 日间、夜间主题包均通过 Dream Skin 官方 Windows 与 macOS 包校验。

## 下载

请从 [Releases](https://github.com/queshirun/codex-deep-whale/releases/latest) 下载：

| 文件 | 用途 |
| --- | --- |
| `codex-deep-whale-complete-v1.4.2.zip` | Windows 推荐。包含日夜主题、增强引擎、安装脚本、素材和许可文件。 |
| `codex-deep-whale-maid-day-v1.4.2.zip` | Dream Skin 官方格式的日间主题。 |
| `codex-deep-whale-maid-night-v1.4.2.zip` | Dream Skin 官方格式的夜间主题。 |
| `SHA256SUMS-v1.4.2.txt` | 下载文件的 SHA-256 校验值。 |

## Windows 首次安装（推荐完整包）

### 1. 安装 Codex Dream Skin

先按 [Codex Dream Skin 官方说明](https://github.com/Fei-Away/Codex-Dream-Skin) 安装并启动 Dream Skin。建议使用 1.5.0 或更新版本，并确认系统托盘中出现 Dream Skin 图标。

### 2. 下载并解压完整包

下载 `codex-deep-whale-complete-v1.4.2.zip`，完整解压到普通文件夹。不要直接在压缩包预览窗口中运行脚本。

解压后应能看到：

```text
Install-Local-Enhancements.ps1
README.txt
themes/
engine/
assets/
NOTICE.md
LICENSE
CODEX-DREAM-SKIN-LICENSE.txt
```

### 3. 运行增强脚本

右键 `Install-Local-Enhancements.ps1`，选择“使用 PowerShell 运行”。也可以在解压目录中执行：

```powershell
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File .\Install-Local-Enhancements.ps1
```

脚本会：

1. 检查本机 Dream Skin 引擎和增强 CSS；
2. 将原始 `dream-skin.css` 备份到 `%LOCALAPPDATA%\CodexDreamSkin\compat-backups`；
3. 安装 Q 版侧栏、黑边清理、顶部文字隐藏及当前 Codex UI 兼容规则；
4. 固定通过 Windows PowerShell 调用 Dream Skin，兼容从 PowerShell 7 发起安装；
5. 让 Dream Skin 重新应用皮肤；如果当前 Codex 不是从 Dream Skin 启动，会弹窗请求重启。

若出现重启提示，请先保存未发送的输入，再确认重启。以后需要重启 Codex 时，优先使用 Dream Skin 托盘菜单中的“应用或重新应用”，不要先退出后从开始菜单直接启动。

### 4. 导入日间或夜间主题

1. 右键 Dream Skin 托盘图标；
2. 选择“导入主题 ZIP…”；
3. 导入 `themes/codex-deep-whale-maid-day-v1.4.2.zip`；
4. 再导入 `themes/codex-deep-whale-maid-night-v1.4.2.zip`；
5. 在“已保存主题”中选择需要的主题。

## 日常换肤

完成首次安装后，只需在 Dream Skin 的“已保存主题”中切换日间、夜间或其它主题，**不需要重复运行 PS1**。

仅在以下情况重新运行 `Install-Local-Enhancements.ps1`：

- 在另一台 Windows 电脑首次安装；
- Dream Skin 自身更新后覆盖了增强引擎 CSS；
- Q 版鲸鱼娘、顶部文字隐藏或黑边清理效果重新失效；
- 内置主题和导入主题同时无法显示，并且需要重新恢复 Dream Skin 注入器。

## 故障排查

### 所有主题同时失效

这通常表示 Codex 未携带 Dream Skin 所需的本地调试端口启动。右键 Dream Skin 托盘图标，选择“应用或重新应用”，并确认重启。

### PowerShell 提示脚本执行受限

在解压目录打开终端，使用以下命令，仅为本次进程采用 `RemoteSigned`：

```powershell
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File .\Install-Local-Enhancements.ps1
```

### Dream Skin 更新后增强效果消失

重新解压最新版完整包并运行一次增强脚本，然后在 Dream Skin 中“应用或重新应用”。已导入的主题通常无需再次导入。

### 校验下载

```powershell
Get-FileHash .\codex-deep-whale-complete-v1.4.2.zip -Algorithm SHA256
Get-Content .\SHA256SUMS-v1.4.2.txt
```

两处哈希应一致。

## macOS 安装

macOS 用户可直接导入日间或夜间主题 ZIP：

1. 安装并启动 Codex Dream Skin；
2. 从 Release 下载日间或夜间主题 ZIP；
3. 在 Dream Skin 菜单中选择“导入主题 ZIP…”；
4. 从“已保存主题”中应用主题。

主题 ZIP 已通过 macOS 官方校验。`Install-Local-Enhancements.ps1` 是 Windows 安装器；完整包中的 `engine/macos/dream-skin.css` 提供给需要集成相同增强规则的维护者。

## 原作者与许可

完整署名链：

1. **上善**（[Pixiv](https://www.pixiv.net/users/62155430) · [Bilibili](https://b23.tv/8h5L4xz)）——鲸鱼娘角色形象原作者。
2. **ZipZipPipe / zipzip**（[Pixiv](https://www.pixiv.net/users/18604994) · [Bilibili](https://b23.tv/Pnw6nG8)）——加入 DeepSeek 元素的女仆鲸鱼娘二次设计。
3. **Small-tailqwq**（[dsh-deep-whale](https://github.com/Small-tailqwq/dsh-deep-whale)）——“深海女仆工坊”主题与素材整理。
4. **queshirun** —— Codex Dream Skin 适配、单角色构图、增强样式与主题包工程。

主题、美术素材及相关衍生内容按 **CC BY-NC-SA 4.0** 发布，详见 [NOTICE.md](NOTICE.md) 与 [LICENSE](LICENSE)。增强引擎 CSS 基于 Codex Dream Skin 的 MIT 许可代码修改，许可文本见 [compat/CODEX-DREAM-SKIN-LICENSE.txt](compat/CODEX-DREAM-SKIN-LICENSE.txt)。

本项目不是 OpenAI、DeepSeek、Codex Dream Skin 或上述作者的官方产品，也不表示任何官方背书。

## 开发与验证

生成两个官方主题 ZIP：

```powershell
.\scripts\Build-Packages.ps1
```

生成包含增强安装器的完整包：

```powershell
.\scripts\Build-Complete-Bundle.ps1
```

使用 Dream Skin 官方校验器验证主题：

```powershell
.\scripts\Test-Packages.ps1 `
  -DreamSkinRoot C:\path\to\Codex-Dream-Skin `
  -NodePath C:\path\to\node.exe
```
