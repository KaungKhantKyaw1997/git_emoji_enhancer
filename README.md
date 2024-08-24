# Git Emoji Enhancer

A Dart package to automatically add emojis to Git commit messages based on keywords, making your commit history more expressive and easier to understand.

## Features

- **Emoji Enhancement:** Adds relevant emojis to commit messages based on keywords.
- **File Support:** Reads commit messages from a file and enhances them with emojis.
- **Git Hook Generation:** Creates a Git hook to enhance commit messages automatically during the commit process.

## Keywords and Emojis

Enhance your commit messages with the following keywords and their corresponding emojis:

| Keyword    | Description              | Emoji |
| ---------- | ------------------------ | ----- |
| `feat`     | New feature              | ✨    |
| `fix`      | Bug fix                  | 🐛    |
| `docs`     | Documentation changes    | 📝    |
| `style`    | Code style changes       | 🎨    |
| `refactor` | Refactoring code         | ♻️    |
| `test`     | Adding or fixing tests   | ✅    |
| `chore`    | Maintenance and chores   | 🔧    |
| `perf`     | Performance improvements | ⚡    |
| `build`    | Build related changes    | 🏗️    |
| `ci`       | Continuous Integration   | 👷    |

## Usage

### Command-Line Tool

The `git_emoji_enhancer` command-line tool provides options to enhance commit messages:

- `-m` or `--message` - Add emojis to a specific commit message.
- `-p` or `--path` - Read a commit message from a file and add emojis.
- `-g` or `--generate-hook` - Generate a `prepare-commit-msg` hook to automatically enhance commit messages.

### Examples

**Add emojis to a commit message:**

```bash
dart run git_emoji_enhancer -m "fix: correct typo"
```

**Output:**

```text
🐛 fix: correct typo
```

**Read commit message from a file and add emojis:**

```bash
dart run git_emoji_enhancer -p /path/to/commit_message.txt
```

If `commit_message.txt` contains:

```text
feat: add new feature
fix: correct bug
```

**Output:**

```text
✨ feat: add new feature
🐛 fix: correct bug
```

**Generate the Git hook:**

```bash
dart run git_emoji_enhancer -g
```

Creates a `prepare-commit-msg` hook in the `.git/hooks/` directory to automatically add emojis to your commit messages.

**Git Commit Example:**

After generating the Git hook, commit as usual:

```bash
git commit -m "feat: first commit"
```

**Automatically Enhanced Output:**

```text
✨ feat: first commit
```
