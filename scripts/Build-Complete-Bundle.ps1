[CmdletBinding()]
param(
  [string]$OutputDirectory = (Join-Path $PSScriptRoot '..\dist')
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$version = '1.4.6'
$repositoryRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$outputRoot = [System.IO.Path]::GetFullPath($OutputDirectory)
$utf8 = [System.Text.UTF8Encoding]::new($false)

$dayArchive = Join-Path $outputRoot "codex-deep-whale-maid-day-v$version.zip"
$nightArchive = Join-Path $outputRoot "codex-deep-whale-maid-night-v$version.zip"
$bundlePath = Join-Path $outputRoot "codex-deep-whale-complete-v$version.zip"

$entries = [ordered]@{
  (Join-Path $repositoryRoot 'compat\README.txt') = 'README.txt'
  (Join-Path $repositoryRoot 'compat\README.en.txt') = 'README.en.txt'
  (Join-Path $repositoryRoot 'compat\Install-Local-Enhancements.ps1') = 'Install-Local-Enhancements.ps1'
  (Join-Path $repositoryRoot 'compat\engine\windows\dream-skin.css') = 'engine/windows/dream-skin.css'
  (Join-Path $repositoryRoot 'compat\engine\macos\dream-skin.css') = 'engine/macos/dream-skin.css'
  (Join-Path $repositoryRoot 'compat\CODEX-DREAM-SKIN-LICENSE.txt') = 'CODEX-DREAM-SKIN-LICENSE.txt'
  (Join-Path $repositoryRoot 'assets\sidebar-mascot.png') = 'assets/sidebar-mascot.png'
  (Join-Path $repositoryRoot 'assets\sidebar-mascot.webp') = 'assets/sidebar-mascot.webp'
  (Join-Path $repositoryRoot 'NOTICE.md') = 'NOTICE.md'
  (Join-Path $repositoryRoot 'LICENSE') = 'LICENSE'
  $dayArchive = "themes/codex-deep-whale-maid-day-v$version.zip"
  $nightArchive = "themes/codex-deep-whale-maid-night-v$version.zip"
}

foreach ($source in $entries.Keys) {
  if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
    throw "完整兼容包缺少文件：$source"
  }
}

New-Item -ItemType Directory -Path $outputRoot -Force | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem

if (Test-Path -LiteralPath $bundlePath -PathType Leaf) {
  Remove-Item -LiteralPath $bundlePath -Force
}

$archive = [System.IO.Compression.ZipFile]::Open(
  $bundlePath,
  [System.IO.Compression.ZipArchiveMode]::Create
)
try {
  foreach ($item in $entries.GetEnumerator()) {
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
      $archive,
      $item.Key,
      $item.Value,
      [System.IO.Compression.CompressionLevel]::Optimal
    ) | Out-Null
  }
}
finally {
  $archive.Dispose()
}

$checksums = Get-ChildItem -LiteralPath $outputRoot -File -Filter "*v$version.zip" |
  Sort-Object Name |
  ForEach-Object {
    $hash = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    "$hash  $($_.Name)"
  }
$checksumText = ($checksums -join "`n") + "`n"
[System.IO.File]::WriteAllText((Join-Path $outputRoot 'SHA256SUMS.txt'), $checksumText, $utf8)
[System.IO.File]::WriteAllText((Join-Path $outputRoot "SHA256SUMS-v$version.txt"), $checksumText, $utf8)

Write-Host "Built $bundlePath"
Write-Host "Wrote $(Join-Path $outputRoot "SHA256SUMS-v$version.txt")"
