[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)][string]$DreamSkinRoot,
  [string]$NodePath = 'node',
  [string]$ClientVersion = '1.5.5'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repositoryRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$dreamRoot = (Resolve-Path -LiteralPath $DreamSkinRoot).Path
$validator = Join-Path $dreamRoot 'runtime\theme-package-validator.mjs'
$safeCssValidator = Join-Path $dreamRoot 'runtime\validate-safe-css-file.mjs'

foreach ($required in @($validator, $safeCssValidator)) {
  if (-not (Test-Path -LiteralPath $required -PathType Leaf)) {
    throw "Codex Dream Skin validator is missing: $required"
  }
}

$themes = @('maid-atelier-day', 'maid-atelier-night')
$temporaryRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("codex-deep-whale-test-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $temporaryRoot | Out-Null

try {
  foreach ($themeName in $themes) {
    $source = Join-Path $repositoryRoot (Join-Path 'themes' $themeName)
    & $NodePath $safeCssValidator (Join-Path $source 'theme.css')
    if ($LASTEXITCODE -ne 0) {
      throw "Safe CSS validation failed for $themeName"
    }

    foreach ($platform in @('macos', 'windows')) {
      $stage = Join-Path $temporaryRoot "$themeName-$platform"
      New-Item -ItemType Directory -Path $stage | Out-Null
      & $NodePath $validator --source $source --stage $stage --platform $platform --client-version $ClientVersion
      if ($LASTEXITCODE -ne 0) {
        throw "Theme package validation failed for $themeName on $platform"
      }
    }
  }
} finally {
  $resolvedTemporary = [System.IO.Path]::GetFullPath($temporaryRoot)
  $systemTemporary = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
  if ($resolvedTemporary.StartsWith($systemTemporary, [System.StringComparison]::OrdinalIgnoreCase)) {
    Remove-Item -LiteralPath $resolvedTemporary -Recurse -Force -ErrorAction SilentlyContinue
  }
}

Write-Host 'All Codex Dream Skin package checks passed for macOS and Windows.'
