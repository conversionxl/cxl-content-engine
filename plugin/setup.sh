#!/usr/bin/env bash
# Adds the Content engine to a personal OS folder (default: the current folder):
# gitignore block first, then the setup files, inputs and stage folders, then the
# CLAUDE.md section. Never overwrites a file that already exists.
set -e
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-$PWD}"
cd "$TARGET"
# A folder map (.claude/folders.json) sends each file to the user's own folder;
# without one, every path below is the standard one.
. "$ROOT/hooks/lib-folders.sh"
mp() { pos_map_path "$PWD" "$1"; }
project="$(mp projects/content-engine)"
rel="${project#"$PWD"/}"

# No personal OS here? Start a minimal CLAUDE.md so the engine still works.
if [ ! -f CLAUDE.md ]; then
  printf '# CLAUDE.md\n\nInstructions Claude reads in this folder.\n' > CLAUDE.md
  cm_new="created (no personal OS here; the Content engine works on its own)"
fi

# 1. Private inputs: the gitignore block goes in BEFORE any file lands. It is
# written for the mapped project folder, so a renamed projects folder is covered.
touch .gitignore
if ! grep -qxF "$rel/inputs/voice-of-customer/*" .gitignore; then
  printf '\n' >> .gitignore
  sed "s|@P@|$rel|g" "$ROOT/plugin/gitignore-block.txt" >> .gitignore
  gi="added"
else
  gi="already there"
fi

# 2. Engine files, skipping anything that exists.
created=0; kept=0
src="$ROOT/template/projects/content-engine"
while IFS= read -r f; do
  dest="$project/${f#"$src"/}"
  case "$dest" in */.gitkeep) mkdir -p "$(dirname "$dest")"; continue;; esac
  if [ -e "$dest" ]; then kept=$((kept+1)); continue; fi
  mkdir -p "$(dirname "$dest")"
  cp "$f" "$dest"
  created=$((created+1))
done < <(find "$src" -type f ! -name '.DS_Store')

# 3. The Content engine section in CLAUDE.md, once.
if grep -q '^## Content engine' CLAUDE.md; then
  cm="already there"
else
  cat "$ROOT/plugin/claude-md-section.md" >> CLAUDE.md
  cm="added"
fi

# 4. Is setup done? The commands read this line.
# The read-me explains the markers, so it is not counted.
if grep -rqE --exclude='00-READ-ME-FIRST.md' '\{\{REPLACE_ME\}\}|<!-- SETUP_INCOMPLETE -->' "$project/your-setup" 2>/dev/null; then
  state="NOT DONE (placeholders remain in $rel/your-setup/)"
else
  state="done"
fi

# 5. A brand brain to read first, if the Marketing Brain is here.
brand="$(mp wiki/brand)"
found=""
for f in icp.md positioning-messaging.md voice-guide.md brand-voice.md; do
  [ -s "$brand/$f" ] && found="$found ${brand#"$PWD"/}/$f"
done

echo "Folder: $TARGET"
echo ".gitignore block: $gi"
echo "Files created: $created. Existing files kept: $kept."
[ -n "${cm_new:-}" ] && echo "CLAUDE.md: $cm_new"
echo "CLAUDE.md Content engine section: $cm"
echo "Engine folder: $rel/"
echo "Personalisation: $state"
if [ -n "$found" ]; then echo "Brand brain found:$found"; else echo "Brand brain found: none"; fi
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  probe="$project/inputs/voice-of-customer/probe-$$.md"; : > "$probe"
  if git check-ignore -q "$probe"; then echo "Check: voice-of-customer files are ignored by git."; else echo "WARNING: voice-of-customer files would be tracked by git. Check .gitignore before adding any."; fi
  rm -f "$probe"
fi
