# QuickSearch - Program Architecture & Outline

<!--toc:start-->
- [QuickSearch - Program Architecture & Outline](#quicksearch-program-architecture-outline)
  - [🎯 Program Overview](#🎯-program-overview)
  - [🏗️ Architecture](#🏗️-architecture)
    - [Core Design Pattern: **Symlink Dispatcher**](#core-design-pattern-symlink-dispatcher)
  - [📁 File Structure](#📁-file-structure)
  - [🔧 Component Breakdown](#🔧-component-breakdown)
    - [1. **Shebang & Metadata**](#1-shebang-metadata)
    - [2. **Color Definitions**](#2-color-definitions)
    - [3. **URL Encoding Function**](#3-url-encoding-function)
    - [4. **Command Detection**](#4-command-detection)
    - [5. **Input Validation**](#5-input-validation)
    - [6. **Query Processing**](#6-query-processing)
    - [7. **URL Router (Switch/Case Statement)**](#7-url-router-switchcase-statement)
    - [8. **Browser Launcher**](#8-browser-launcher)
    - [9. **User Feedback**](#9-user-feedback)
  - [🔄 Program Flow Diagram](#🔄-program-flow-diagram)
  - [🎨 Key Design Decisions](#🎨-key-design-decisions)
    - [1. **Single Script with Symlinks**](#1-single-script-with-symlinks)
    - [2. **Bash Instead of Python/Node**](#2-bash-instead-of-pythonnode)
    - [3. **Opening Browser vs Terminal Output**](#3-opening-browser-vs-terminal-output)
    - [4. **Google for Site-Restricted Searches**](#4-google-for-site-restricted-searches)
    - [5. **Color Output**](#5-color-output)
  - [🔌 Extension Points](#🔌-extension-points)
    - [Adding a New Site](#adding-a-new-site)
    - [Adding Features](#adding-features)
  - [📊 Supported Site Categories](#📊-supported-site-categories)
    - [Category Matrix](#category-matrix)
  - [🛡️ Error Handling Strategy](#🛡️-error-handling-strategy)
    - [Types of Errors Handled](#types-of-errors-handled)
    - [Error Philosophy](#error-philosophy)
  - [🎯 Performance Characteristics](#🎯-performance-characteristics)
  - [🔐 Security Considerations](#🔐-security-considerations)
    - [Safe](#safe)
    - [User Responsibility](#user-responsibility)
  - [📈 Scalability](#📈-scalability)
    - [Current Scale](#current-scale)
    - [Theoretical Limits](#theoretical-limits)
  - [🧪 Testing Strategy](#🧪-testing-strategy)
    - [Manual Testing Checklist](#manual-testing-checklist)
    - [Edge Cases](#edge-cases)
  - [📝 Code Metrics](#📝-code-metrics)
  - [🎓 Learning Outcomes](#🎓-learning-outcomes)
    - [Concepts Demonstrated](#concepts-demonstrated)
    - [Bash Techniques Used](#bash-techniques-used)
  - [🚀 Future Possibilities](#🚀-future-possibilities)
<!--toc:end-->

## 🎯 Program Overview

**QuickSearch** is a lightweight, single-script Bash utility that provides instant web searches across 30+ developer-focused websites directly from the command line. The program uses symbolic links to create multiple command aliases that all point to one central script, which determines behavior based on how it was invoked.

---

## 🏗️ Architecture

### Core Design Pattern: **Symlink Dispatcher**

```
User Command → Symlink → Main Script → URL Builder → Browser
```

**Flow:**

1. User executes a symlinked command (e.g., `search-so`)
2. Script detects which symlink invoked it via `basename $0`
3. Script constructs appropriate URL based on the command name
4. Script opens URL in default browser
5. Script displays colored confirmation message

---

## 📁 File Structure

```
~/.local/bin/
├── quicksearch.sh                    # Main executable script (the only actual file)
├── search-so → quicksearch.sh        # Symlink for Stack Overflow
├── search-gh → quicksearch.sh        # Symlink for GitHub
├── search-yt → quicksearch.sh        # Symlink for YouTube
├── search-archwiki → quicksearch.sh  # Symlink for Arch Wiki
└── [30+ more symlinks...]            # One symlink per supported site
```

---

## 🔧 Component Breakdown

### 1. **Shebang & Metadata**

```bash
#!/bin/bash
# Multi-site search script
# Usage: search-so "your query" or search-yt "your query" etc.
```

- Specifies Bash interpreter
- Provides usage documentation

### 2. **Color Definitions**

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

- ANSI escape codes for terminal colors
- Used for visual feedback and user experience
- Makes output more readable and professional

### 3. **URL Encoding Function**

```bash
urlencode() {
    # Converts special characters to percent-encoding
    # Example: "hello world" → "hello%20world"
}
```

- Essential for safe URL construction
- Handles spaces, special characters, international characters
- Prevents broken URLs from user input

### 4. **Command Detection**

```bash
SCRIPT_NAME=$(basename "$0")
```

- Determines which symlink was used to invoke the script
- Core of the dispatch mechanism
- Example: `/home/user/.local/bin/search-so` → `search-so`

### 5. **Input Validation**

```bash
if [ -z "$1" ]; then
    echo -e "${RED}${BOLD}Error:${RESET} No search query provided!"
    echo -e "${CYAN}Usage:${RESET} $SCRIPT_NAME ${GREEN}\"your search query\"${RESET}"
    exit 1
fi
```

- Checks if user provided a search query
- Displays helpful error message with usage example
- Prevents empty searches

### 6. **Query Processing**

```bash
QUERY=$(urlencode "$*")
```

- Takes all command-line arguments as search query
- URL-encodes the entire query string
- `$*` joins all arguments with spaces

### 7. **URL Router (Switch/Case Statement)**

```bash
case "$SCRIPT_NAME" in
    search-so)
        URL="https://www.google.com/search?q=${QUERY}+site:stackoverflow.com"
        SITE_NAME="${YELLOW}Stack Overflow${RESET}"
        ;;
    search-gh)
        URL="https://github.com/search?q=${QUERY}&type=repositories"
        SITE_NAME="${MAGENTA}GitHub${RESET}"
        ;;
    # ... 30+ more cases ...
    *)
        # Unknown command error
        ;;
esac
```

- **Router**: Maps command names to URLs
- **URL Builder**: Constructs search URL with encoded query
- **Branding**: Sets colored site name for output
- **Extensible**: Easy to add new sites

### 8. **Browser Launcher**

```bash
if command -v xdg-open > /dev/null; then
    xdg-open "$URL" 2>/dev/null       # Linux
elif command -v open > /dev/null; then
    open "$URL"                       # macOS
else
    # Error handling
fi
```

- **Cross-platform**: Detects and uses appropriate browser opener
- **Silent**: Redirects stderr to avoid terminal noise
- **Fallback**: Error message if no browser opener found

### 9. **User Feedback**

```bash
echo -e "${GREEN}✓${RESET} Searching ${SITE_NAME} for: ${BOLD}${CYAN}$*${RESET}"
```

- Confirms successful operation
- Shows which site is being searched
- Displays the original (non-encoded) query

---

## 🔄 Program Flow Diagram

```
┌─────────────────────────────────────┐
│  User enters: search-so "hello"     │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│ Bash invokes: ~/.local/bin/search-so│
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│ Symlink resolves to quicksearch.sh  │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│  Script detects: SCRIPT_NAME = so   │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│  Validate: Is query provided?       │
│  YES → Continue                     │
│  NO  → Error & Exit                 │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│  URL encode: "hello" → "hello"      │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│  Match case: search-so              │
│  Build URL with query parameter     │
│  Set site name with color           │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│  Detect browser opener:             │
│  • xdg-open (Linux)                 │
│  • open (macOS)                     │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│  Open URL in default browser        │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│  Display: ✓ Searching Stack...      │
└─────────────────────────────────────┘
```

---

## 🎨 Key Design Decisions

### 1. **Single Script with Symlinks**

**Why?**

- Easy maintenance (one file to update)
- DRY principle (Don't Repeat Yourself)
- Minimal disk space usage
- Simple deployment

**Alternative:** 30+ separate scripts
**Downside:** Maintenance nightmare, code duplication

### 2. **Bash Instead of Python/Node**

**Why?**

- Zero dependencies
- Available on all Unix-like systems
- Fast startup time
- Perfect for simple tasks

**Trade-off:** Less portable to non-Unix systems

### 3. **Opening Browser vs Terminal Output**

**Why browser?**

- Better UI for search results
- Leverages existing search engines
- No need to parse HTML/APIs
- User's preferred browser experience

**Alternative:** Could use curl + HTML parsing
**Downside:** Complex, slower, worse UX

### 4. **Google for Site-Restricted Searches**

**Why?**

- Faster than native site searches
- Consistent interface
- Better ranking algorithms
- Works when site search is broken

**Some sites:** Use native search (GitHub, npm, etc.) for better results

### 5. **Color Output**

**Why?**

- Visual feedback improves UX
- Easy to distinguish errors
- Professional appearance
- Standard in modern CLI tools

**Trade-off:** Slightly more complex code

---

## 🔌 Extension Points

### Adding a New Site

**Required changes:**

1. Add case to switch statement
2. Define URL template
3. Set site name with color
4. Create symlink

**Example:**

```bash
# In quicksearch.sh
search-newsite)
    URL="https://newsite.com/search?q=${QUERY}"
    SITE_NAME="${BLUE}New Site${RESET}"
    ;;

# In terminal
cd ~/.local/bin
ln -s quicksearch.sh search-newsite
```

### Adding Features

**Possible enhancements:**

- **History logging:** Track searches in `~/.search_history`
- **Config file:** `~/.searchrc` for custom sites
- **Multiple results:** Open multiple sites at once
- **Fuzzy matching:** Suggest commands if typo detected
- **Caching:** Remember recent searches
- **Aliases:** User-defined shortcuts

---

## 📊 Supported Site Categories

### Category Matrix

| Category | Count | Examples | Strategy |
|----------|-------|----------|----------|
| **Q&A Sites** | 4 | SO, SF, SU, SE | Google site search |
| **Code Hosting** | 2 | GitHub, Gist | Native search |
| **Documentation** | 7 | MDN, Go, Rust, Python | Google site search |
| **Package Managers** | 5 | npm, PyPI, NixPkgs | Native search |
| **Linux Wikis** | 8 + combined | Arch, Gentoo, etc. | Native + combined search |
| **Media** | 3 | YouTube, Reddit, Wikipedia | Native search |
| **AI/Search** | 4 | ChatGPT, Claude, etc. | Direct links |

---

## 🛡️ Error Handling Strategy

### Types of Errors Handled

1. **Missing query:** User didn't provide search term
2. **Unknown command:** Symlink name not in case statement
3. **No browser:** Can't find xdg-open/open
4. **Invalid input:** Handled by URL encoding

### Error Philosophy

- **Fail fast:** Exit immediately on error
- **Helpful messages:** Always show how to fix
- **Colorful feedback:** Red for errors, yellow for warnings
- **Non-zero exit codes:** Proper shell integration

---

## 🎯 Performance Characteristics

- **Startup time:** ~10-50ms (negligible)
- **Memory usage:** ~2-5MB (Bash process)
- **CPU usage:** Minimal (simple string operations)
- **Disk I/O:** One script read, no writes
- **Network:** None (just opens browser)

**Bottleneck:** Browser startup time (not script's responsibility)

---

## 🔐 Security Considerations

### Safe

- No network requests (just opens URL)
- No file system writes
- URL encoding prevents injection
- No eval or arbitrary code execution

### User Responsibility

- User's browser security
- Trusting search sites
- Query content (searches are visible to sites)

---

## 📈 Scalability

### Current Scale

- **30+ sites:** Works perfectly
- **1000+ searches/day:** No issues

### Theoretical Limits

- **100+ sites:** Still fast (O(n) case lookup)
- **1000+ sites:** Consider hash table approach
- **10,000+ sites:** Need database/config file

**Conclusion:** Current design scales to 100+ sites easily

---

## 🧪 Testing Strategy

### Manual Testing Checklist

- [ ] Each command opens correct site
- [ ] Special characters encoded properly
- [ ] Error messages display correctly
- [ ] Colors work in different terminals
- [ ] Works on Linux and macOS
- [ ] Handles empty queries
- [ ] Handles very long queries
- [ ] Symlinks point to correct file

### Edge Cases

- Query with spaces: `"hello world"`
- Special chars: `"c++ templates"`
- International: `"日本語"`
- Very long: 500+ character query
- Empty string: `""`
- Just spaces: `"   "`

---

## 📝 Code Metrics

- **Total lines:** ~200
- **Functions:** 1 (urlencode)
- **Case statements:** 1 (34 cases)
- **Dependencies:** 0
- **Complexity:** Low (cyclomatic ~5)
- **Maintainability:** High

---

## 🎓 Learning Outcomes

### Concepts Demonstrated

1. **Symlink-based dispatch pattern**
2. **URL encoding/escaping**
3. **Cross-platform shell scripting**
4. **ANSI color codes**
5. **Case statement routing**
6. **Error handling in Bash**
7. **Command-line argument processing**

### Bash Techniques Used

- `basename` for path manipulation
- `$*` for all arguments
- Case statements for routing
- Command existence checking (`command -v`)
- String manipulation in Bash
- Exit codes for error handling
- ANSI escape sequences

---

## 🚀 Future Possibilities

1. **Plugin system:** Load sites from `~/.search.d/`
2. **Interactive mode:** Select site from menu
3. **Tab completion:** Bash/Zsh completion scripts
4. **Search history:** Track and replay searches
5. **Multi-search:** Open 3 sites simultaneously
6. **Smart defaults:** Remember preferred sites per query type
7. **API mode:** Return URLs instead of opening browser

---

This architecture enables a simple, maintainable, and extensible search tool that follows Unix philosophy: do one thing well.
