#!/usr/bin/env bash
# Rapid Reboot Brain — vault setup script
# Creates the folder structure and copies templates into a new or existing directory.
# Usage: bash bin/setup-vault.sh [vault-path]
# If no path is given, uses the current directory.

set -e

VAULT_PATH="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TODAY="$(date +%Y-%m-%d)"

echo "Setting up Rapid Reboot Brain vault at: $VAULT_PATH"

# Check if we're trying to set up inside the skill itself
if [ "$(cd "$VAULT_PATH" && pwd)" = "$SCRIPT_DIR" ]; then
    echo "Error: Don't set up the vault inside the skill directory."
    echo "Create or navigate to a separate folder for your vault first."
    exit 1
fi

# Create folders
mkdir -p "$VAULT_PATH/Sources"
mkdir -p "$VAULT_PATH/Concepts"
mkdir -p "$VAULT_PATH/People"
mkdir -p "$VAULT_PATH/Projects"
mkdir -p "$VAULT_PATH/Daily"
mkdir -p "$VAULT_PATH/templates"

# Copy templates
cp "$SCRIPT_DIR/templates/"*.md "$VAULT_PATH/templates/"

# Create CONTEXT.md if it doesn't exist
if [ ! -f "$VAULT_PATH/CONTEXT.md" ]; then
    cat > "$VAULT_PATH/CONTEXT.md" << EOF
# Vault Context

This is the hot cache. Claude reads this at the start of every session.

## Active projects
_(None yet — add projects to Projects/ and link them here)_

## Recent sessions
_(Session summaries will appear here, newest first)_

## Open loops
_(Questions and follow-ups for later)_

## Quick-access links
_(Frequently referenced notes)_

---
Last updated: $TODAY
EOF
    echo "Created CONTEXT.md"
else
    echo "CONTEXT.md already exists — leaving it alone"
fi

# Create today's daily note if it doesn't exist
DAILY_FILE="$VAULT_PATH/Daily/$TODAY.md"
if [ ! -f "$DAILY_FILE" ]; then
    cat > "$DAILY_FILE" << EOF
---
type: daily
date: $TODAY
tags: []
---

# $TODAY

## Focus

## Sessions

## Notes

## Ingested today

## Loose ends
EOF
    echo "Created Daily/$TODAY.md"
fi

# Create README.md if it doesn't exist
if [ ! -f "$VAULT_PATH/README.md" ]; then
    cat > "$VAULT_PATH/README.md" << 'EOF'
# My Rapid Reboot Brain

This is an Obsidian vault managed by the `rapid-reboot-brain` Claude Code skill.

## Structure

- `CONTEXT.md` — Hot cache, read at start of every session
- `Sources/` — Raw ingested material
- `Concepts/` — Atomic ideas extracted from sources
- `People/` — Clients, coworkers, contacts
- `Projects/` — Active work
- `Daily/` — Daily notes and session logs
- `templates/` — Note templates

## Usage

Open this folder in Obsidian (Manage Vaults → Open folder as vault). Then use Claude Code
from this directory with the `rapid-reboot-brain` skill installed. Commands:

- `/ingest <source>` — Add a new source and extract linked concepts
- `/query <question>` — Ask your vault a question with citations
- `/save` — Save the current Claude conversation to your vault
EOF
    echo "Created README.md"
fi

# Create .gitignore
if [ ! -f "$VAULT_PATH/.gitignore" ]; then
    cat > "$VAULT_PATH/.gitignore" << 'EOF'
.obsidian/workspace*
.obsidian/cache
.trash/
.DS_Store
EOF
    echo "Created .gitignore"
fi

echo ""
echo "✓ Vault setup complete at $VAULT_PATH"
echo ""
echo "Next steps:"
echo "  1. Open the folder in Obsidian: Manage Vaults → Open folder as vault"
echo "  2. From Claude Code in this directory, try: /ingest <file-or-text>"
