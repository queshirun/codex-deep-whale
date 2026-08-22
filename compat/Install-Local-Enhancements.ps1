[CmdletBinding()]
param(
  [string]$DreamSkinRoot = (Join-Path $env:LOCALAPPDATA 'CodexDreamSkin'),
  [ValidateRange(1024, 65535)][int]$Port = 9335,
  [switch]$SkipDreamSkinRestart
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$version = '1.4.6'
$sourceCss = Join-Path $PSScriptRoot 'engine\windows\dream-skin.css'
$targetCss = Join-Path $DreamSkinRoot 'engine\assets\dream-skin.css'
$startScript = Join-Path $DreamSkinRoot 'engine\scripts\start-dream-skin.ps1'
$backupRoot = Join-Path $DreamSkinRoot 'compat-backups'
$backupCss = Join-Path $backupRoot "dream-skin.css.before-deep-whale-v$version"

if (-not (Test-Path -LiteralPath $sourceCss -PathType Leaf)) {
  throw "增强样式文件缺失：$sourceCss"
}
if (-not (Test-Path -LiteralPath $targetCss -PathType Leaf)) {
  throw "未找到 Codex Dream Skin 引擎：$targetCss"
}
if (-not (Test-Path -LiteralPath $startScript -PathType Leaf)) {
  throw "未找到 Codex Dream Skin 启动脚本：$startScript"
}
if (-not (Select-String -LiteralPath $sourceCss -SimpleMatch '--whale-mascot-width' -Quiet)) {
  throw '增强样式校验失败：缺少鲸鱼娘侧栏规则。'
}
if (-not (Select-String -LiteralPath $sourceCss -SimpleMatch 'Deep Whale header branding removal' -Quiet)) {
  throw '增强样式校验失败：缺少顶部主题名称隐藏规则。'
}
if (-not (Select-String -LiteralPath $sourceCss -SimpleMatch 'Deep Whale home captions removal' -Quiet)) {
  throw '增强样式校验失败：缺少新对话页主题与作者文字隐藏规则。'
}
if (-not (Select-String -LiteralPath $sourceCss -SimpleMatch 'Deep Whale sidebar preview mascot' -Quiet)) {
  throw '增强样式校验失败：缺少侧栏悬浮预览鲸鱼娘规则。'
}
if (-not (Select-String -LiteralPath $sourceCss -SimpleMatch 'Deep Whale Windows titlebar glass' -Quiet)) {
  throw '增强样式校验失败：缺少当前 Codex 顶部应用菜单栏毛玻璃规则。'
}
if (-not (Select-String -LiteralPath $sourceCss -SimpleMatch 'Deep Whale home project glass' -Quiet)) {
  throw '增强样式校验失败：缺少新对话页项目选择框毛玻璃规则。'
}
if (-not (Select-String -LiteralPath $sourceCss -SimpleMatch 'Deep Whale home project toolbar glass' -Quiet)) {
  throw '增强样式校验失败：缺少输入框上方项目文件夹毛玻璃规则。'
}

New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
if (-not (Test-Path -LiteralPath $backupCss -PathType Leaf)) {
  Copy-Item -LiteralPath $targetCss -Destination $backupCss -Force
  Write-Host "已备份原引擎样式：$backupCss"
}

Copy-Item -LiteralPath $sourceCss -Destination $targetCss -Force
if ((Get-FileHash -LiteralPath $sourceCss -Algorithm SHA256).Hash -cne
  (Get-FileHash -LiteralPath $targetCss -Algorithm SHA256).Hash) {
  throw '增强样式写入后的哈希校验失败。'
}
Write-Host "已安装 Codex Deep Whale v$version 本地增强。"

if ($SkipDreamSkinRestart) {
  Write-Host '已跳过 Dream Skin 启动恢复；稍后请通过 Dream Skin 启动器启动 Codex。'
  return
}

Write-Host '正在交给 Codex Dream Skin 恢复注入器；若 Codex 已直接启动，请在弹窗中确认重启。'
$windowsPowerShell = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
if (-not (Test-Path -LiteralPath $windowsPowerShell -PathType Leaf)) {
  throw "未找到 Windows PowerShell：$windowsPowerShell"
}
& $windowsPowerShell -NoProfile -ExecutionPolicy RemoteSigned -File $startScript `
  -Port $Port -PromptRestart
if ($LASTEXITCODE -ne 0) {
  throw "Codex Dream Skin 启动恢复失败，退出代码：$LASTEXITCODE"
}
