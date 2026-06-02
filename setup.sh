#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Own skills — symlink into ~/.claude/skills
echo "Linking own skills..."
mkdir -p ~/.claude/skills
for skill_dir in "$REPO_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  target=~/.claude/skills/"$skill_name"
  if [ ! -e "$target" ]; then
    ln -s "$skill_dir" "$target"
    echo "  linked: $skill_name"
  else
    echo "  skip:   $skill_name (already exists)"
  fi
done

# Third-party skills
echo ""
echo "Installing third-party skills..."
npx skills add DuskyElf/teach-me --skill teach-me -a claude-code -g -y

echo ""
echo "Done."
