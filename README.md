# 🔍 QuickSearch

<!--toc:start-->
- [🔍 QuickSearch](#🔍-quicksearch)
  - [✨ Features](#features)
  - [📋 Table of Contents](#📋-table-of-contents)
  - [🚀 Installation](#🚀-installation)
    - [Quick Install (Recommended)](#quick-install-recommended)
    - [Manual Installation](#manual-installation)
  - [📖 Usage](#📖-usage)
    - [General Tips](#general-tips)
  - [🗂️ Available Commands](#🗂️-available-commands)
    - [💻 Development & Programming](#💻-development-programming)
    - [📚 Documentation](#📚-documentation)
    - [📦 Package Managers](#📦-package-managers)
    - [🐧 Linux Wikis & Documentation](#🐧-linux-wikis-documentation)
    - [🎥 Social & Media](#🎥-social-media)
    - [🤖 AI & Search Engines](#🤖-ai-search-engines)
  - [💡 Examples](#💡-examples)
    - [Programming Help](#programming-help)
    - [Documentation](#documentation)
    - [Linux System Administration](#linux-system-administration)
    - [Package Management](#package-management)
    - [General Search](#general-search)
    - [AI Assistants](#ai-assistants)
  - [⚙️ Configuration](#️-configuration)
    - [Customizing the Script](#customizing-the-script)
    - [Adding a New Site](#adding-a-new-site)
    - [Color Customization](#color-customization)
  - [🔧 Troubleshooting](#🔧-troubleshooting)
    - [Command Not Found](#command-not-found)
    - [Browser Doesn't Open](#browser-doesnt-open)
    - [Permission Denied](#permission-denied)
    - [Symbolic Links Not Working](#symbolic-links-not-working)
  - [🤝 Contributing](#🤝-contributing)
    - [Adding New Sites](#adding-new-sites)
    - [Reporting Issues](#reporting-issues)
  - [📝 License](#📝-license)
  - [🙏 Acknowledgments](#🙏-acknowledgments)
  - [📊 Stats](#📊-stats)
  - [🔗 Links](#🔗-links)
<!--toc:end-->

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Bash](https://img.shields.io/badge/bash-4.0+-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/platform-linux%20%7C%20macOS-blue.svg)](https://github.com/yourusername/quicksearch)

Lightning-fast CLI search shortcuts for developers. Search 30+ sites directly from your terminal with simple, memorable commands.

## ✨ Features

- 🚀 **Instant Search** - Type `search-so "your query"` and your browser opens with results
- 🌈 **Colorful Output** - Beautiful, readable terminal feedback
- 🔧 **Developer-Focused** - Stack Overflow, GitHub, documentation sites
- 🐧 **Linux-Friendly** - Search all major Linux wikis at once with one command
- 📦 **Package Search** - npm, PyPI, NixPkgs, Arch packages, and more
- 🤖 **AI Integration** - Quick access to ChatGPT, Claude, Perplexity
- ⚡ **Zero Dependencies** - Pure bash, works everywhere
- 🎯 **30+ Sites** - One tool for all your search needs

## 📋 Table of Contents

- [Installation](#-installation)
- [Usage](#-usage)
- [Available Commands](#️-available-commands)
- [Examples](#-examples)
- [Configuration](#️-configuration)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

## 🚀 Installation

### Quick Install (Recommended)

```bash
# Clone the repository
git clone https://github.com/Nachmen-Kurtz/quicksearch.git
cd quicksearch

# Run the install script
chmod +x install.sh
./install.sh
```

### Manual Installation

1. **Download the script:**

```bash
mkdir -p ~/.local/bin
cd ~/.local/bin
curl -O https://raw.githubusercontent.com/Nachmen-Kurtz/quicksearch/main/quicksearch.sh
chmod +x search-tool.sh
```

2. **Create symbolic links:**

```bash
cd ~/.local/bin

# Create all command aliases
for cmd in so sf su se gh gist mdn godocs rustdocs pydocs aws man docs \
           npm pypi nixpkgs archpkg fedorapkg archwiki gentoowiki debianwiki \
           nixwiki susewiki voiddocs voidwiki fedoradocs linuxwiki yt reddit \
           wiki chatgpt perplexity claude ddg; do
    ln -sf search-tool.sh search-$cmd
done
```

3. **Add to PATH** (if `~/.local/bin` is not already in your PATH):

```bash
# For bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# For zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# For fish
fish_add_path ~/.local/bin
```

4. **Verify installation:**

```bash
search-so "test query"
```

## 📖 Usage

Basic syntax:

```bash
search-<site> "your search query"
```

The command will automatically:

1. URL-encode your search query
2. Open your default browser
3. Navigate to the search results

### General Tips

- Always quote your search queries
- Queries are automatically URL-encoded
- Works with any default browser
- Use `search-linuxwiki` to search ALL Linux wikis at once

## 🗂️ Available Commands

### 💻 Development & Programming

| Command | Site | Description |
|---------|------|-------------|
| `search-so` | Stack Overflow | Programming Q&A |
| `search-sf` | Server Fault | System administration Q&A |
| `search-su` | Super User | General computing Q&A |
| `search-se` | Stack Exchange | All Stack Exchange sites |
| `search-gh` | GitHub | Code repositories |
| `search-gist` | GitHub Gist | Code snippets |

### 📚 Documentation

| Command | Site | Description |
|---------|------|-------------|
| `search-mdn` | MDN Web Docs | Web development documentation |
| `search-godocs` | Go Docs | Go language documentation |
| `search-rustdocs` | Rust Docs | Rust language documentation |
| `search-pydocs` | Python Docs | Python documentation |
| `search-aws` | AWS Docs | Amazon Web Services documentation |
| `search-man` | man7.org | Linux man pages |
| `search-docs` | DevDocs | Multiple documentation sources |

### 📦 Package Managers

| Command | Site | Description |
|---------|------|-------------|
| `search-npm` | npm | Node.js packages |
| `search-pypi` | PyPI | Python packages |
| `search-nixpkgs` | NixPkgs | Nix packages |
| `search-archpkg` | Arch Packages | Arch Linux packages |
| `search-fedorapkg` | Fedora Packages | Fedora packages |

### 🐧 Linux Wikis & Documentation

| Command | Site | Description |
|---------|------|-------------|
| `search-archwiki` | Arch Wiki | Arch Linux documentation |
| `search-gentoowiki` | Gentoo Wiki | Gentoo documentation |
| `search-debianwiki` | Debian Wiki | Debian documentation |
| `search-nixwiki` | NixOS Wiki | NixOS documentation |
| `search-susewiki` | openSUSE Wiki | openSUSE documentation |
| `search-voiddocs` | Void Docs | Void Linux documentation |
| `search-voidwiki` | Void Wiki | Void Linux wiki |
| `search-fedoradocs` | Fedora Docs | Fedora documentation |
| `search-linuxwiki` | **All Linux Wikis** | Search ALL wikis at once! |

### 🎥 Social & Media

| Command | Site | Description |
|---------|------|-------------|
| `search-yt` | YouTube | Video search |
| `search-reddit` | Reddit | Community discussions |
| `search-wiki` | Wikipedia | Encyclopedia |

### 🤖 AI & Search Engines

| Command | Site | Description |
|---------|------|-------------|
| `search-chatgpt` | ChatGPT | OpenAI assistant |
| `search-perplexity` | Perplexity | AI-powered search |
| `search-claude` | Claude | Anthropic assistant |
| `search-ddg` | DuckDuckGo | Privacy-focused search |

## 💡 Examples

### Programming Help

```bash
# Search Stack Overflow
search-so "how to reverse a string in python"

# Search GitHub repositories
search-gh "react hooks examples"

# Find code snippets
search-gist "bash script parse json"
```

### Documentation

```bash
# Python documentation
search-pydocs "asyncio tutorial"

# Go documentation
search-godocs "http server"

# MDN for web development
search-mdn "css flexbox"

# Man pages
search-man "grep"
```

### Linux System Administration

```bash
# Search a specific wiki
search-archwiki "install nvidia drivers"

# Search ALL Linux wikis at once (recommended!)
search-linuxwiki "systemd service configuration"

# Gentoo-specific
search-gentoowiki "kernel configuration"

# Void Linux
search-voiddocs "xbps package manager"
```

### Package Management

```bash
# Find npm packages
search-npm "express middleware"

# Python packages
search-pypi "requests library"

# NixOS packages
search-nixpkgs "firefox"

# Arch packages
search-archpkg "docker"
```

### General Search

```bash
# YouTube tutorials
search-yt "rust programming tutorial"

# Reddit discussions
search-reddit "best mechanical keyboard 2024"

# Wikipedia
search-wiki "quantum computing"

# DuckDuckGo
search-ddg "privacy tools"
```

### AI Assistants

```bash
# Ask ChatGPT
search-chatgpt "explain recursion"

# Use Perplexity for research
search-perplexity "latest developments in AI"

# Claude
search-claude "help me write a bash script"
```

## ⚙️ Configuration

### Customizing the Script

The script is located at `~/.local/bin/quicksearch.sh`. You can edit it to:

- Add new search sites
- Modify existing URLs
- Change color schemes
- Add custom behavior

### Adding a New Site

1. Edit `~/.local/bin/quicksearch.sh`
2. Add a new case in the switch statement:

```bash
search-yoursite)
    URL="https://yoursite.com/search?q=${QUERY}"
    SITE_NAME="${BLUE}Your Site${RESET}"
    ;;
```

3. Create a symbolic link:

```bash
cd ~/.local/bin
ln -s quicksearch.sh search-yoursite
```

### Color Customization

Colors are defined at the top of the script:

```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'
```

## 🔧 Troubleshooting

### Command Not Found

**Problem:** `bash: search-so: command not found`

**Solutions:**

1. Check if `~/.local/bin` is in your PATH:

   ```bash
   echo $PATH | grep "$HOME/.local/bin"
   ```

2. If not, add it to your shell config:

   ```bash
   # Bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   
   # Zsh
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

3. Verify the script exists:

   ```bash
   ls -la ~/.local/bin/quicksearch.sh
   ```

### Browser Doesn't Open

**Problem:** Script runs but browser doesn't open

**Solutions:**

1. Check if you have a default browser set

2. Try setting `BROWSER` environment variable:

   ```bash
   export BROWSER=firefox  # or chrome, chromium, etc.
   ```

3. Manually test browser opening:

   ```bash
   xdg-open "https://google.com"  # Linux
   open "https://google.com"      # macOS
   ```

### Permission Denied

**Problem:** `Permission denied` when running script

**Solution:**

```bash
chmod +x ~/.local/bin/quicksearch.sh
```

### Symbolic Links Not Working

**Problem:** Links point to wrong location

**Solution:**

```bash
cd ~/.local/bin
# Remove broken links
rm search-*
# Recreate with absolute path
for cmd in so sf su se gh gist mdn godocs rustdocs pydocs aws man docs \
           npm pypi nixpkgs archpkg fedorapkg archwiki gentoowiki debianwiki \
           nixwiki susewiki voiddocs voidwiki fedoradocs linuxwiki yt reddit \
           wiki chatgpt perplexity claude ddg; do
    ln -sf "$(pwd)/quicksearch.sh" "search-$cmd"
done
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch:** `git checkout -b feature/new-site`
3. **Make your changes**
4. **Test thoroughly**
5. **Commit your changes:** `git commit -am 'Add search-newsite command'`
6. **Push to the branch:** `git push origin feature/new-site`
7. **Submit a pull request**

### Adding New Sites

When contributing new sites, please:

- Follow the existing code style
- Add appropriate colors for the site
- Update the README with the new command
- Test on both Linux and macOS if possible

### Reporting Issues

Found a bug? Please open an issue with:

- Your operating system (Linux distribution or macOS version)
- Shell type and version (`echo $SHELL`, `$SHELL --version`)
- Error message (if any)
- Steps to reproduce

## 📝 License

This project is licensed under the GNU General Public License v3.0 or later - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the need for faster developer workflows
- Thanks to all the open-source documentation sites
- Built with ❤️ for the developer community

## 📊 Stats

- 30+ supported sites
- 0 dependencies
- Works on Linux and macOS
- Written in pure Bash

## 🔗 Links

- [Report Bug](https://github.com/yourusername/quicksearch/issues)
- [Request Feature](https://github.com/yourusername/quicksearch/issues)
- [Contribute](https://github.com/yourusername/quicksearch/pulls)

---

Made with ❤️ by developers, for developers. Happy searching! 🔍
