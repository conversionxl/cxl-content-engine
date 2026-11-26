#!/usr/bin/env bash
# Build a carousel from its HTML file: one PNG per slide and one PDF with every slide.
# Usage: render-slides.sh <carousel.html> [output folder]
# Needs Chrome, Chromium, Edge or Brave on this computer. Nothing is uploaded anywhere.
set -u

html="${1:-}"
[ -n "$html" ] && [ -f "$html" ] || { echo "Usage: render-slides.sh <carousel.html> [output folder]" >&2; exit 2; }
html="$(cd "$(dirname "$html")" && pwd)/$(basename "$html")"
out="${2:-$(dirname "$html")}"
mkdir -p "$out" || exit 2
out="$(cd "$out" && pwd)"

browser="${SLIDES_BROWSER:-}"
if [ -n "$browser" ] && ! [ -x "$browser" ] && ! command -v "$browser" >/dev/null 2>&1; then browser=""; fi
if [ -z "$browser" ]; then
  for c in \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
    "/Applications/Chromium.app/Contents/MacOS/Chromium" \
    "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
    "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" \
    "/c/Program Files/Google/Chrome/Application/chrome.exe" \
    "/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" \
    "/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" \
    "/c/Program Files/Microsoft/Edge/Application/msedge.exe"; do
    [ -x "$c" ] && { browser="$c"; break; }
  done
fi
if [ -z "$browser" ]; then
  for c in google-chrome google-chrome-stable chromium chromium-browser microsoft-edge brave-browser; do
    command -v "$c" >/dev/null 2>&1 && { browser="$(command -v "$c")"; break; }
  done
fi
if [ -z "$browser" ]; then
  echo "NO_BROWSER: no Chrome, Chromium, Edge or Brave found. Open the HTML file in any browser and print it to PDF, or set SLIDES_BROWSER to the browser's path." >&2
  exit 3
fi

count="$(grep -o '<div class="s[ "]' "$html" | wc -l | tr -d ' ')"
[ "$count" -gt 0 ] || { echo "No slides found: each slide is a <div class=\"s\"> in the HTML." >&2; exit 2; }

case "$html" in
  /[a-zA-Z]/*) url="file:///$(printf '%s' "$html" | sed -e 's|^/\([a-zA-Z]\)/|\1:/|' -e 's/ /%20/g')" ;;
  *) url="file://$(printf '%s' "$html" | sed 's/ /%20/g')" ;;
esac

profile="$(mktemp -d 2>/dev/null || echo "$out/.slides-profile")"
common=(--headless=new --disable-gpu --hide-scrollbars --no-first-run --user-data-dir="$profile" --virtual-time-budget=8000)

fail=0
i=1
while [ "$i" -le "$count" ]; do
  "$browser" "${common[@]}" --window-size=1080,1350 --screenshot="$out/slide-$i.png" "$url#$i" >/dev/null 2>&1
  [ -s "$out/slide-$i.png" ] || { echo "slide $i: not written" >&2; fail=1; }
  i=$((i + 1))
done

"$browser" "${common[@]}" --no-pdf-header-footer --print-to-pdf="$out/carousel.pdf" "$url" >/dev/null 2>&1
[ -s "$out/carousel.pdf" ] || { echo "carousel.pdf: not written" >&2; fail=1; }

[ "$fail" -eq 0 ] || exit 1
echo "Built $count slides in $out: slide-1.png to slide-$count.png, and carousel.pdf"
