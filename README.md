# Rapid Reboot Brain

A Claude Code skill that turns an Obsidian vault into a self-organizing second brain. Feed it meeting notes, articles, transcripts, brain dumps, project docs — whatever — and it extracts the key concepts, links them together, and lets you query everything with citations.

Built for the Rapid Reboot team. Works for anyone with Claude Code and Obsidian installed.

## What you get

- **Persistent memory across Claude sessions.** The brain remembers what you were working on last time.
- **Automatic concept extraction.** Drop in a source, get back a linked web of atomic ideas.
- **Graph view of everything you know.** Obsidian shows how your notes connect.
- **Citations on every answer.** Ask your vault a question, get an answer with links to the specific notes that support it.

## Prerequisites

- [Obsidian](https://obsidian.md) (free)
- [Claude Code](https://claude.com/claude-code) installed and working
- Git (usually pre-installed on Mac, [download for Windows](https://git-scm.com/downloads))

## Install

### 1. Clone this repo

```bash
git clone https://github.com/YOUR-ORG/rapid-reboot-brain.git
cd rapid-reboot-brain
```

### 2. Create a vault folder

Pick where your vault should live. This is a separate folder from the skill itself. For example:

```bash
mkdir ~/rapid-reboot-vault
cd ~/rapid-reboot-vault
```

### 3. Run the setup script

From your vault folder:

```bash
bash /path/to/rapid-reboot-brain/bin/setup-vault.sh
```

This creates the folder structure, copies templates, and makes a CONTEXT.md file.

### 4. Install the skill for Claude Code

Copy (or symlink) the skill folder into your Claude Code skills directory. The exact location depends on your Claude Code setup — typically `~/.claude/skills/` or similar. Check the [Claude Code skills docs](https://docs.claude.com) for the current path.

```bash
# Example (adjust path as needed):
cp -r /path/to/rapid-reboot-brain ~/.claude/skills/rapid-reboot-brain
```

Also copy the `.claude/commands/` folder contents into your Claude Code commands directory so `/wiki`, `/ingest`, `/query`, and `/save` become available.

### 5. Open the vault in Obsidian

In Obsidian: **Manage Vaults → Open folder as vault → select your vault folder**.

### 6. Start Claude Code from the vault directory

```bash
cd ~/rapid-reboot-vault
claude
```

You're ready.

## Usage

Four commands:

| Command | What it does |
|---|---|
| `/wiki` | Sets up or re-initializes a vault |
| `/ingest <source>` | Adds a source (file, URL, or pasted text) and extracts linked concepts |
| `/query <question>` | Searches the vault and answers with citations |
| `/save [topic]` | Saves the current conversation into the vault |

### Examples

**Ingesting a meeting transcript:**
```
/ingest ~/Downloads/standup-notes.txt
```

**Asking a question:**
```
/query what did we decide about the summer campaign launch?
```

**Saving a planning conversation:**
```
/save email strategy Q3
```

## What to feed it first

The more sources you feed it, the smarter the graph becomes. Start with:

- Meeting transcripts and notes
- Articles and blog posts
- Podcast transcripts
- Book highlights
- Project briefs and specs
- Brain dumps and random thoughts
- Client notes and emails (use your judgment on sensitive content)
- Recipes, if that's your thing

## Vault structure

```
Your Vault/
├── CONTEXT.md          Hot cache — read every session
├── Sources/            Raw ingested material
├── Concepts/           Atomic ideas (the real magic)
├── People/             Clients, coworkers, contacts
├── Projects/           Active work
├── Daily/              Daily notes and session logs
└── templates/          Note templates
```

## Tips

- **Let it link aggressively.** The graph view becomes useful around 20-30 concept notes. Keep feeding it.
- **Don't worry about perfect organization.** The skill creates stub notes for things it references, so the graph stays connected even with incomplete content.
- **Review stubs periodically.** Notes tagged `#stub` are placeholders waiting for real content.
- **Run `/query` before assuming nothing is there.** You'll be surprised what the brain has on file.

## Customizing

The skill is yours. Some common tweaks:

- **Adjust templates** in `templates/` to match your team's note style
- **Edit command prompts** in `.claude/commands/` to change how `/ingest`, `/query`, etc. behave
- **Add new commands** by creating new markdown files in `.claude/commands/`

If you make improvements, push them back to the repo so everyone benefits.

## Troubleshooting

**"The skill isn't triggering."** Make sure the skill is installed in the right directory for your Claude Code setup, and that you're running Claude Code from a directory that contains a vault (it looks for `CONTEXT.md`).

**"Slash commands aren't showing up."** Commands need to be in your Claude Code commands directory, not just the skill folder. Check where your Claude Code installation looks for commands.

**"The graph view is empty."** Obsidian only shows notes that have at least one link. Ingest a source or two and the graph fills up fast.

## License

Internal Rapid Reboot use. If this ends up being broadly useful, we can decide on a license later.
