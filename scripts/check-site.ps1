param(
  [string]$SiteRoot = (Join-Path (Split-Path $PSScriptRoot -Parent) '_site')
)

$ErrorActionPreference = 'Stop'
$site = (Resolve-Path -LiteralPath $SiteRoot).Path
$failures = [System.Collections.Generic.List[string]]::new()
$assetsRoot = Join-Path $site 'assets'
$htmlFiles = @(
  Get-ChildItem -LiteralPath $site -Recurse -File -Filter '*.html' |
    Where-Object { -not $_.FullName.StartsWith($assetsRoot, [System.StringComparison]::OrdinalIgnoreCase) }
)

if ($htmlFiles.Count -ne 5) {
  $failures.Add("Expected 5 rendered HTML pages; found $($htmlFiles.Count).")
}

foreach ($file in $htmlFiles) {
  $relative = $file.FullName.Substring($site.Length + 1)
  $html = Get-Content -Raw -LiteralPath $file.FullName

  if ($html -notmatch '<!DOCTYPE html>') {
    $failures.Add("${relative}: missing HTML5 doctype.")
  }
  if ($html -notmatch '<meta\s+name="robots"\s+content="noindex, nofollow"') {
    $failures.Add("${relative}: pre-launch noindex protection is missing.")
  }
  if ([regex]::Matches($html, '<h1\b', 'IgnoreCase').Count -ne 1) {
    $failures.Add("${relative}: expected exactly one visible h1.")
  }
  if ($html -match 'href="#"') {
    $failures.Add("${relative}: contains an empty placeholder link.")
  }

  $references = [regex]::Matches($html, '(?:href|src)="([^"]+)"', 'IgnoreCase')
  foreach ($reference in $references) {
    $url = [System.Net.WebUtility]::HtmlDecode($reference.Groups[1].Value)
    if ($url -match '^(?:https?:|mailto:|tel:|data:|javascript:)') {
      continue
    }

    $parts = $url -split '#', 2
    $pathPart = $parts[0]
    $fragment = if ($parts.Count -gt 1) { $parts[1] } else { '' }

    if ([string]::IsNullOrWhiteSpace($pathPart)) {
      $target = $file.FullName
    } else {
      $decodedPath = [System.Uri]::UnescapeDataString($pathPart).Replace('/', [IO.Path]::DirectorySeparatorChar)
      $target = [IO.Path]::GetFullPath((Join-Path $file.DirectoryName $decodedPath))
      if ($pathPart.EndsWith('/')) {
        $target = Join-Path $target 'index.html'
      }
    }

    if (-not $target.StartsWith($site, [System.StringComparison]::OrdinalIgnoreCase)) {
      $failures.Add("${relative}: local reference escapes the rendered site: $url")
      continue
    }
    if (-not (Test-Path -LiteralPath $target -PathType Leaf)) {
      $failures.Add("${relative}: missing local target: $url")
      continue
    }

    if ($fragment -and ([IO.Path]::GetExtension($target) -eq '.html')) {
      $targetHtml = Get-Content -Raw -LiteralPath $target
      $escapedFragment = [regex]::Escape([System.Uri]::UnescapeDataString($fragment))
      $anchorPattern = '\bid=["'']' + $escapedFragment + '["'']'
      if ($targetHtml -notmatch $anchorPattern) {
        $failures.Add("${relative}: missing anchor target: $url")
      }
    }
  }
}

$languageChecks = @(
  @{ Path = 'index.html'; Lang = 'en'; Nav = 'Main navigation'; Alternates = 5 },
  @{ Path = 'tr\index.html'; Lang = 'tr'; Nav = 'Ana menü'; Alternates = 5 },
  @{ Path = 'es\index.html'; Lang = 'es'; Nav = 'Navegación principal'; Alternates = 5 },
  @{ Path = 'zh\index.html'; Lang = 'zh-Hans'; Nav = '主导航'; Alternates = 5 },
  @{ Path = 'publications\aeq-pe-elementary\index.html'; Lang = 'en'; Nav = 'Main navigation'; Alternates = 0 }
)

foreach ($check in $languageChecks) {
  $html = Get-Content -Raw -LiteralPath (Join-Path $site $check.Path)
  if ($html -notmatch ('<html\s+lang="{0}"' -f [regex]::Escape($check.Lang))) {
    $failures.Add("$($check.Path): expected html lang '$($check.Lang)'.")
  }
  if ($html -notmatch ('<nav class="site-nav" aria-label="{0}"' -f [regex]::Escape($check.Nav))) {
    $failures.Add("$($check.Path): expected localized navigation label '$($check.Nav)'.")
  }
  $alternateCount = [regex]::Matches($html, 'rel="alternate"\s+hreflang=').Count
  if ($alternateCount -ne $check.Alternates) {
    $failures.Add("$($check.Path): expected $($check.Alternates) hreflang alternates; found $alternateCount.")
  }
}

$publication = Get-Content -Raw -LiteralPath (Join-Path $site 'publications\aeq-pe-elementary\index.html')
$requiredOrder = @('class="pub-head"', 'class="rail-quick"', 'class="pub-brief"', 'class="rail-more"', 'class="pub-body"')
$lastIndex = -1
foreach ($marker in $requiredOrder) {
  $currentIndex = $publication.IndexOf($marker, [System.StringComparison]::Ordinal)
  if ($currentIndex -le $lastIndex) {
    $failures.Add("Publication page content order is incorrect at $marker.")
  }
  $lastIndex = $currentIndex
}

$robots = Get-Content -Raw -LiteralPath (Join-Path $site 'robots.txt')
if ($robots -notmatch '(?m)^Disallow:\s*/\s*$') {
  $failures.Add('robots.txt does not block crawling during pre-launch review.')
}

if ($failures.Count -gt 0) {
  Write-Host 'Site checks failed:' -ForegroundColor Red
  $failures | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
  exit 1
}

Write-Host "All checks passed: $($htmlFiles.Count) pages, local files and anchors, heading counts, localized language metadata, pre-launch indexing guards, and publication content order."
