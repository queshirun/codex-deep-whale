[CmdletBinding()]
param(
  [string]$OutputDirectory = (Join-Path $PSScriptRoot '..\dist')
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repositoryRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$outputRoot = [System.IO.Path]::GetFullPath($OutputDirectory)
$utf8 = [System.Text.UTF8Encoding]::new($false)
$createdAt = '2026-08-21T00:00:00Z'
$version = '1.4.2'

$notice = [System.IO.File]::ReadAllText((Join-Path $repositoryRoot 'NOTICE.md'))
$license = [System.IO.File]::ReadAllText((Join-Path $repositoryRoot 'LICENSE'))
$licensePayload = $notice.TrimEnd() + "`r`n`r`n--- Full CC BY-NC-SA 4.0 license ---`r`n`r`n" + $license.TrimEnd() + "`r`n"

$packages = @(
  [ordered]@{
    Directory = 'maid-atelier-day'
    Archive = "codex-deep-whale-maid-day-v$version.zip"
    AiGenerated = $true
    Summary = 'Based on dsh-deep-whale artwork. OpenAI image tooling composited the original palace and notebook-holding whale-maid, removed the second character, and reconstructed the background for Codex.'
  },
  [ordered]@{
    Directory = 'maid-atelier-night'
    Archive = "codex-deep-whale-maid-night-v$version.zip"
    AiGenerated = $true
    Summary = 'Based on dsh-deep-whale artwork. OpenAI image tooling composited the moonlit palace and notebook-holding whale-maid, removed the second character, and reconstructed the background for Codex.'
  }
)

function Get-PayloadEntry {
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$MediaType
  )

  $item = Get-Item -LiteralPath $Path
  [ordered]@{
    path = $item.Name
    mediaType = $MediaType
    bytes = $item.Length
    sha256 = (Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
  }
}

New-Item -ItemType Directory -Path $outputRoot -Force | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem
$checksums = [System.Collections.Generic.List[string]]::new()

foreach ($package in $packages) {
  $themeRoot = Join-Path $repositoryRoot (Join-Path 'themes' $package.Directory)
  $themePath = Join-Path $themeRoot 'theme.json'
  $cssPath = Join-Path $themeRoot 'theme.css'
  $imagePath = Join-Path $themeRoot 'background.png'
  $packageLicensePath = Join-Path $themeRoot 'LICENSE.txt'
  $manifestPath = Join-Path $themeRoot 'manifest.json'

  foreach ($required in @($themePath, $cssPath, $imagePath)) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) {
      throw "Required theme file is missing: $required"
    }
  }

  [System.IO.File]::WriteAllText($packageLicensePath, $licensePayload, $utf8)
  $theme = Get-Content -Raw -LiteralPath $themePath | ConvertFrom-Json
  $files = @(
    (Get-PayloadEntry -Path $themePath -MediaType 'application/json'),
    (Get-PayloadEntry -Path $imagePath -MediaType 'image/png'),
    (Get-PayloadEntry -Path $cssPath -MediaType 'text/css'),
    (Get-PayloadEntry -Path $packageLicensePath -MediaType 'text/plain')
  )

  $manifest = [ordered]@{
    packageVersion = 1
    themeId = $theme.id
    version = $version
    skinApiVersion = 1
    minClientVersion = '1.5.0'
    platforms = @('macos', 'windows')
    capabilities = @('background', 'tokens', 'safe-css')
    publisher = [ordered]@{
      id = 'queshirun'
      displayName = 'queshirun · Codex Deep Whale port'
    }
    license = 'CC BY-NC-SA 4.0'
    provenance = [ordered]@{
      aiGenerated = $package.AiGenerated
      summary = $package.Summary
    }
    files = $files
    createdAt = $createdAt
  }

  [System.IO.File]::WriteAllText(
    $manifestPath,
    (($manifest | ConvertTo-Json -Depth 8) + "`r`n"),
    $utf8
  )

  $archivePath = Join-Path $outputRoot $package.Archive
  if (Test-Path -LiteralPath $archivePath) {
    Remove-Item -LiteralPath $archivePath -Force
  }
  $archive = [System.IO.Compression.ZipFile]::Open(
    $archivePath,
    [System.IO.Compression.ZipArchiveMode]::Create
  )
  try {
    foreach ($payloadPath in @(
      $themePath,
      $imagePath,
      $cssPath,
      $packageLicensePath,
      $manifestPath
    )) {
      [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
        $archive,
        $payloadPath,
        [System.IO.Path]::GetFileName($payloadPath),
        [System.IO.Compression.CompressionLevel]::Optimal
      ) | Out-Null
    }
  }
  finally {
    $archive.Dispose()
  }
  $archiveHash = (Get-FileHash -LiteralPath $archivePath -Algorithm SHA256).Hash.ToLowerInvariant()
  $checksums.Add("$archiveHash  $($package.Archive)")
  Write-Host "Built $archivePath"
}

$checksumText = ($checksums -join "`n") + "`n"
[System.IO.File]::WriteAllText((Join-Path $outputRoot 'SHA256SUMS.txt'), $checksumText, $utf8)
[System.IO.File]::WriteAllText((Join-Path $outputRoot "SHA256SUMS-v$version.txt"), $checksumText, $utf8)

Write-Host "Wrote $(Join-Path $outputRoot 'SHA256SUMS.txt')"
