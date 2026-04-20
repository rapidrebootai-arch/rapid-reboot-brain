# Second Brain — Claude Code Skill

A Claude Code skill that turns an Obsidian vault into a self-organizing second brain. Feed it anything — meeting notes, articles, Slack threads, voice memo transcripts, supplier conversations, book highlights, random thoughts — and it extracts the key ideas, links them together, and lets you search everything with citations.

The more you put in, the smarter it gets. The graph view in Obsidian shows you how everything connects.

---

## What you get

**Persistent memory across Claude sessions.** The brain remembers what you were working on last time, what's in progress, and what's been decided.

**Automatic concept extraction.** Drop in a source, get back a web of atomic linked notes — one idea per file, all connected.

**Project tracking with daily logs.** Log what you worked on throughout the day with a keyboard shortcut. Pull a full weekly report at any time.

**Quick capture from anywhere.** Half-formed ideas, quotes, observations — captured instantly without breaking flow.

**Citations on every answer.** Ask your vault a question, get an answer with links to the specific notes that support it.

---

## Prerequisites

- [Obsidian](https://obsidian.md) — free, runs on Mac/Windows/Linux
- [Claude Code](https://claude.ai/download) — requires a Claude Pro, Max, Team, or Enterprise plan
- Git — usually pre-installed on Mac; [download for Windows](https://git-scm.com/downloads)

---

## Install

### 1. Clone this repo

```bash
git clone https://github.com/YOUR-ORG/second-brain.git
cd second-brain
```

### 2. Install the skill into Claude Code

```bash
mkdir -p ~/.claude/skills
cp -r . ~/.claude/skills/second-brain
mkdir -p ~/.claude/commands
cp .claude/commands/*.md ~/.claude/commands/
```

### 3. Create your vault

Pick a location for your vault — this is where all your notes will live, separate from the skill itself.

```bash
mkdir ~/Documents/my-vault
cd ~/Documents/my-vault
bash ~/.claude/skills/second-brain/bin/setup-vault.sh
```

### 4. Open the vault in Obsidian

In Obsidian: **Manage Vaults → Open folder as vault → select your vault folder.**

### 5. Launch Claude Code from your vault

```bash
cd ~/Documents/my-vault
claude
```

On first run, authenticate with your Claude account in the browser. Done.

---

## Commands

| Command | What it does |
|---|---|
| `/wiki` | One-time vault setup — creates folder structure, templates, and context file |
| `/ingest [source]` | Ingests a source (file, URL, or pasted text) and extracts linked concept notes |
| `/capture [thought]` | Quick capture — a half-formed idea, quote, or observation. Zero friction. |
| `/log [what you did]` | Logs a work update to your daily note and the relevant project note |
| `/process-logs` | Batches all pending log entries (from the keyboard shortcut) into vault notes |
| `/query [question]` | Searches the vault and answers with citations to specific notes |
| `/save [topic]` | Saves the current Claude conversation into the vault |
| `/weekly` | Generates a full weekly summary grouped by project |

---

## Vault structure

```
Your Vault/
├── CONTEXT.md          Hot cache — Claude reads this at the start of every session
├── _inbox/             Quick capture inbox (pending-logs.txt lives here)
├── Sources/            Raw ingested material
├── Concepts/           Atomic ideas — one idea per file (the real magic)
├── People/             Clients, contacts, anyone worth remembering
├── Projects/           Active work with decision logs and progress tracking
├── Daily/              Daily notes and session logs
├── Weekly/             Weekly summary reports
└── templates/          Note templates
```

---

## Daily workflow

**Morning:**
```
cd ~/Documents/my-vault && claude
```
Ask: *"What's on deck today? Show me my active projects."*

**Throughout the day — keyboard shortcut:**
Set up the Log shortcut (see below) so you can capture progress from anywhere on your Mac in 4 seconds. Entries land in `_inbox/pending-logs.txt` without touching Claude Code.

**End of day:**
```
/process-logs
/save
```
Routes all your log entries into the right notes, then saves the session context.

**Friday:**
```
/weekly
```
Full report of everything you did, grouped by project. Copy-paste into your team update.

---

## Keyboard shortcut setup (Mac)

Build a Log shortcut in the macOS Shortcuts app so you can capture work updates from anywhere — no Terminal needed.

**Actions in order:**

1. **Ask for Input** — prompt: `What did you work on? (include project name)`
2. **Current Date**
3. **Format Date** — Custom format: `yyyy-MM-dd'T'HH:mm`
4. **Text** — contents: `[Formatted Date] | | [Ask for Input]`
5. **Run Shell Script:**
   ```bash
   echo "$1" >> ~/Documents/my-vault/_inbox/pending-logs.txt
   ```
   Input: `[Text]` / Pass Input: `as arguments`
6. **Show Notification** — title: `Logged ✓`

Assign a keyboard shortcut (e.g. `⌃⌘L`) in the shortcut's Details panel.

> Adjust the vault path in step 5 to match wherever your vault lives.

---

## Multiple vaults

Run one vault per life domain. Common split:

- `~/Documents/work-vault` — professional projects, client notes, team content
- `~/Documents/personal-vault` — personal projects, learning, life notes

Switch between them by `cd`-ing into the right folder before launching Claude Code. Each vault is independent — its own graph, its own context, its own notes.

---

## What to feed it

The brain gets more useful with volume. Start with:

- Meeting notes and action items
- Articles and blog posts worth remembering
- Podcast or video takeaways
- Book highlights and reactions
- Project briefs and decision logs
- Conversations worth documenting
- Random thoughts and half-formed ideas (use `/capture`)
- Supplier or client notes
- Research and competitive intelligence

---

## Tips

**Ingest in the moment.** The #1 failure mode is "I'll organize this later." Use the keyboard shortcut to capture small things instantly. Use `/ingest` for bigger sources right after you encounter them.

**Use `/query` before you search Slack or email.** The vault will often have the answer, and it'll give you citations. Build the reflex.

**Run `/save` before closing Claude Code.** This is what makes tomorrow's session start with memory.

**Don't over-organize.** The skill handles the linking. Just feed it content and let the graph form.

**Review stubs periodically.** Notes tagged `#stub` are placeholders waiting for real content. Check them occasionally and flesh out the ones that matter.

---

## Customizing

Everything is plain markdown. The skill is yours to modify:

- **Templates** — edit files in `templates/` to match your note style
- **Commands** — edit files in `.claude/commands/` to change how each command behaves
- **New commands** — add a new `.md` file to `.claude/commands/` with a YAML frontmatter `description` field and instructions in the body

---

## Troubleshooting

**"command not found: claude"** — run `source ~/.zshrc` to reload your PATH, or close and reopen Terminal.

**Slash commands not showing up** — copy command files to both `~/.claude/commands/` AND your vault's `.claude/commands/` folder. Restart Claude Code.

**Graph view shows template nodes** — open Graph view settings (gear icon), add `-path:templates` to the filter field.

**`/process-logs` says no pending logs** — check that the keyboard shortcut shell script path matches your vault location: `cat ~/Documents/my-vault/_inbox/pending-logs.txt`

---

## License

MIT — use it, modify it, share it.
