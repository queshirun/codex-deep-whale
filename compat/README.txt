Codex Deep Whale v1.4.2 完整兼容包
==================================

本包包含：

1. themes/codex-deep-whale-maid-day-v1.4.2.zip
   可直接通过 Codex Dream Skin 导入的日间主题。

2. themes/codex-deep-whale-maid-night-v1.4.2.zip
   可直接通过 Codex Dream Skin 导入的夜间主题。

3. Install-Local-Enhancements.ps1
   安装 Q 版鲸鱼娘侧栏背景、底部黑色渐变清除和 Codex 26.818
   兼容修复。脚本会先在 compat-backups 文件夹备份原 dream-skin.css，
   再写入增强版本，并交给 Dream Skin 启动器恢复注入器。

Windows 使用顺序：

1. 解压完整兼容包。
2. 右键使用 PowerShell 运行 Install-Local-Enhancements.ps1；若弹出重启
   提示，请确认，让 Codex 通过 Dream Skin 所需的调试端口重新启动。
3. 在 Codex Dream Skin 中导入日间或夜间主题 ZIP。
4. 导入后直接应用主题；不需要再手动关闭或直接启动 Codex。

日常切换日间、夜间或其它已保存主题时，不需要重新运行 PS1。仅在首次
安装、Dream Skin 更新覆盖增强 CSS，或增强效果失效时重新运行。

故障恢复：

- 若内置主题和导入主题同时失效，通常是 Codex 未通过 Dream Skin 启动，
  导致 9335 调试端口和注入器缺失。重新运行本脚本并确认重启即可。
- 请勿从开始菜单直接重启 Codex；需要重启时使用 Dream Skin 托盘菜单。
- Dream Skin 自身更新后如覆盖了增强样式，可重新运行本脚本。

Q 版形象行为：

- 作为左侧历史栏的背景装饰，不占用列表空间；
- 始终保持固定尺寸；
- 收起侧栏时随侧栏向窗口左侧移动，并被窗口左边框裁切；
- 展开侧栏时从左侧同步滑回。

说明：

- 背景图保持不变。
- 顶部不再显示“深海女仆工坊 / DEEP WHALE · CODEX”和
  “WHALE MAID ONLINE / NIGHT SHIFT ONLINE”等主题介绍文字。
- 原生项目标题、更多菜单及窗口控制按钮保持显示。
- 顶部状态栏使用柔和圆角毛玻璃。
- 输入区底部以及“文件已更改”提示下方的黑色渐变已清除。
- 主题 ZIP 保持 Dream Skin 官方导入格式；增强脚本只补充当前官方
  主题格式尚未覆盖的侧栏装饰和 Codex 版本兼容规则。

署名与许可：

- 原主题与鲸鱼娘素材来源：Small-tailqwq/dsh-deep-whale
- 原作者标注：上善
- 女仆二创标注：ZipZipPipe
- Codex / Dream Skin 适配：queshirun
- 完整来源和 CC BY-NC-SA 4.0 条款见 NOTICE.md 与 LICENSE。
- 增强引擎 CSS 基于 Codex Dream Skin 的 MIT 许可代码修改，条款见
  CODEX-DREAM-SKIN-LICENSE.txt。
