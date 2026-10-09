# ⚡ Neovim Configuration

A clean, modern, and high-performance Neovim configuration tailored for **Python**, **JavaScript**, **TypeScript**, and **Terraform** development.

Built on [lazy.nvim](https://github.com/folke/lazy.nvim) with native LSP, Tree-sitter, completion via `nvim-cmp`, and fast Rust-based tooling.

---

## 🛠️ Language Stack & Tooling

| Language | Type Checking / Language Server | Linting & Code Actions | Formatter (Format-on-Save) |
| :--- | :--- | :--- | :--- |
| **Python** | **[ty](https://github.com/astral-sh/ty)** (Astral) | **[Ruff](https://astral.sh/ruff)** (Astral) | **Ruff** |
| **JavaScript / TypeScript** | **ts_ls** (TypeScript LSP) | **[Biome](https://biomejs.dev)** | **Biome** |
| **Terraform** | **terraform-ls** | **terraform-ls** | **terraform-ls** |
| **Lua** (Neovim configs) | **lua-language-server** | **lua-language-server** | **stylua** |

* **Zero-overhead format-on-save:** Formatting runs directly through persistent LSP servers on file save without external process runners.
* **Non-conflicting capabilities:** `ruff` hover provider is disabled in favor of `ty` hover documentation; `ts_ls` formatting is disabled so `biome` formats exclusively.
* **Focused language scope:** Tree-sitter and Mason are scoped strictly to the supported languages to keep installations lightweight and fast.

---

## 📋 Prerequisites

Ensure the following tools are installed on your machine before setting up Neovim:

### 1. Neovim
* **Neovim >= 0.10** (recommended: **v0.11+**)

### 2. System Utilities & Build Tools
* **Git** (for plugin management)
* **C Compiler & Make** (`gcc`, `make` — required to compile `telescope-fzf-native` and `LuaSnip` regex support)
* **ripgrep** (`rg` — required for Telescope live grep)
* **A [Nerd Font](https://www.nerdfonts.com/)** (e.g., JetBrainsMono Nerd Font, Hack Nerd Font) for editor icons

### 3. Language Runtimes
* **Python 3** and **[uv](https://astral.sh/uv)** (recommended for managing Astral tools like `ty` and `ruff`)
* **Node.js** and **npm** (or **[bun](https://bun.sh)**) for Biome and TypeScript language tooling

---

## 🚀 Installation

### Step 1: Install System Dependencies

#### Ubuntu / Debian:
```bash
sudo apt update
sudo apt install -y git curl build-essential ripgrep python3 python3-pip nodejs npm
```

*To install `uv` (recommended for Astral tools):*
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

#### macOS (Homebrew):
```bash
brew install neovim git ripgrep make gcc node uv
```

#### Arch Linux:
```bash
sudo pacman -S neovim git base-devel ripgrep python nodejs npm uv
```

---

### Step 2: Backup Existing Neovim Configuration (Optional)

If you already have a Neovim setup, back it up before installing:

```bash
# Backup existing configuration and state directories
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

---

### Step 3: Install This Configuration

Clone or copy this repository directly into `~/.config/nvim`:

```bash
git clone <YOUR_REPO_URL> ~/.config/nvim
```

*(If copying locally, ensure files are placed inside `~/.config/nvim`)*

---

### Step 4: First Launch & Automatic Bootstrap

Start Neovim:

```bash
nvim
```

On first launch:
1. **lazy.nvim** will automatically clone itself and install all required plugins.
2. **mason-tool-installer** will automatically download and install:
   - `ty` (Python type checker & language server)
   - `ruff` (Python linter & formatter)
   - `biome` (JS/TS linter & formatter)
   - `typescript-language-server` (`ts_ls`)
   - `terraform-ls`
   - `lua-language-server`
3. **nvim-treesitter** will automatically compile parsers for supported languages.

Wait a few moments for the installations to finish. You can view Mason's status at any time with `:Mason`.

Restart Neovim once the initial installation completes.

---

## ⌨️ Essential Keymaps

The leader key is **`<Space>`**.

### LSP & Code Actions
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>cf` | `[C]ode [F]ormat` | Format current buffer (Ruff / Biome) |
| `<leader>co` | `[C]ode [O]rganize Imports` | Organize & sort imports |
| `<leader>ca` | `[C]ode [A]ction` | Trigger code actions / quick fixes |
| `<leader>rn` | `[R]e[n]ame` | Rename symbol across workspace |
| `gd` | Goto Definition | Jump to symbol definition |
| `gr` | Goto References | Find references via Telescope |
| `K` | Hover | Show hover documentation (via `ty` in Python) |
| `[d` / `]d` | Diagnostic Navigation | Jump to previous / next diagnostic |
| `<leader>e` | Diagnostic Float | Show diagnostic error message popup |

### Search & Navigation (Telescope)
| Keymap | Description |
| :--- | :--- |
| `<leader>sf` | `[S]earch [F]iles` |
| `<leader>sg` | `[S]earch by [G]rep` |
| `<leader>sw` | `[S]earch current [W]ord` |
| `<leader><space>` | Find existing buffers |
| `<leader>pv` | Toggle file explorer (`NvimTree`) |

### Python Testing & Debugging (nvim-dap)
| Keymap | Description |
| :--- | :--- |
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Start / continue debugging |
| `<leader>dt` | Run current test file with pytest |
| `<leader>dT` | Run all tests with pytest |
| `<leader>du` | Toggle DAP UI |

For the full list of keybindings and editing commands, see [commands.md](commands.md).

---

## 📂 Project Structure

```text
~/.config/nvim/
├── init.lua                   # Entry point (options, keymaps, bootstrap)
├── commands.md                # Full cheatsheet of keybindings and commands
├── README.md                  # Setup guide and documentation
└── lua/
    ├── keymaps.lua            # General editor keybindings
    ├── options.lua            # Vim options and sensible defaults
    ├── lazy-bootstrap.lua     # Automatic lazy.nvim installation
    ├── lazy-plugins.lua       # Plugin list managed by Lazy
    └── plugins/
        ├── lspconfig.lua      # LSP, Mason, format-on-save (ty, ruff, biome, ts_ls, terraform)
        ├── treesitter.lua     # Syntax highlighting and AST parsers
        ├── cmp.lua            # Autocompletion engine & snippets
        ├── nvim-dap.lua       # Python debugger and test runner
        ├── telescope.lua      # Fuzzy finder
        ├── tokyonight.lua     # Colorscheme
        ├── which-key.lua      # Keybinding helper popups
        ├── gitsigns.lua       # Git gutter integration
        ├── floatterm.lua      # Floating terminal
        └── ...
```
