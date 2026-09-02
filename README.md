# 💤 My Neovim Config

My personal Neovim configuration, built from scratch with `lazy.nvim` as the plugin manager.


## 📸 Screenshots

### Dashboard

![Dashboard](assets/dashboard.png)

### Editor/LSP in action

![Editor](assets/editor.png)

## ✨Features

- Complete **LSP** via `nvim-lspconfig` + `mason.nvim` (autocompletion, diagnostics, inlay hints, go-to-definition)
- **Treesitter** (`main` branch, modern API) for syntax highlighting
- **Auto format** when saving with `conform.nvim` + Prettier/Stylua/rustfmt/clang-format
- **Autocompletion** with `nvim-cmp` + VS Code style snippets (`LuaSnip` + `friendly-snippets`)
- Startup **Dashboard** with `snacks.nvim` (recent files, projects, restore session)
- **File Explorer**: `neo-tree.nvim`
- **Fuzzy Finder**: `telescope.nvim`
- **Tab Buffers**: `barbar.nvim`
- **Integrated Terminal** with multiple instances: `toggleterm.nvim`
- **Session Restore**: `persistence.nvim`
- **Notifications**: `nvim-notify`
- **Material Style Icons**: `DaikyXendo/nvim-material-icon`
- **Pug/Jade Support**: `vim-pug`
- **TODO Highlighting**: `todo-comments.nvim`
- **Statusline**: `nvim-lualine`

### Supported Languages ​​(LSP + Formatting)

| Language | LSP | Formatter |

| ------------------------------- | ----------------------- | -------------- |
| Lua | `lua_ls` | `stylua` |
| TypeScript/JavaScript/React | `vtsls` | `prettier` |
| Rust | `rust_analyzer` | `rustfmt` |
| C/C++ | `clangd` | `clang-format` |
| Java | `jdtls` | (LSP fallback) |
| Astro | `astro` | `prettier` |
| Tailwind CSS (v3 and v4) | `tailwindcss` | — |
| Markdown | `marksman` | `prettier` |
| HTML/CSS/JSX/TSX (Emmet) | `emmet_language_server` | — |

## 📋 Prerequisites

Before cloning this config to a new machine (tested on **Linux Mint / Ubuntu**), install:

```bash
# Neovim (version 0.11+ recommended)
sudo apt update
sudo apt install neovim

# Git
sudo apt install git

# C Compiler (required to compile Treesitter parsers and some native plugins)
sudo apt install build-essential

# Node.js (required for several LSPs installed via Mason)
sudo apt install nodejs npm

# ripgrep and fd (required for Telescope: live_grep and find_files)
sudo apt install ripgrep fd-find

# unzip (to manually install Nerd Fonts)
sudo apt install unzip
```

### Nerd Font

This The configuration uses icons that require any Nerd Font installed and selected in your terminal (Kitty, Alacritty, GNOME Terminal, etc.) — choose whichever you like; any of the fonts offered by the Nerd Fonts project will work (JetBrainsMono, Hack, CascadiaCode, etc.). I use FiraCode Nerd Font.

Example installation (replace `FiraCode` with your preferred font):

```bash
mkdir -p ~/.local/share/fonts/FiraCode
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -o FiraCode.zip -d ~/.local/share/fonts/FiraCode
fc-cache -fv
```

Then select that font **"... Nerd Font"** in your terminal's font settings.


````````````````````````````````````````````````````````````````````````````````````
`

Then select that font, `**"... Nerd Font```, in your terminal's font settings.

``````````````````````````````````````````````````

` ... ## 🚀 Installation

1. Back up your current config if you already have one:

``bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. Clone this repo:

``bash
git clone https://github.com/noldee/nvim-config.git ~/.config/nvim
```

3. Open Neovim:

``bash
nvim
```

The first time, `lazy.nvim` will bootstrap itself and begin installing all plugins automatically. Wait for it to finish (this may take a minute or two).

4. Close and reopen Neovim, and run:

``

:Mason
```

to confirm that the LSPs/formatters are being installed (Mason installs them automatically the first time, as declared in `lspconfig.lua`).

5. Update the treesitter parsers manually, just in case:

``

:TSUpdate
```

6. Verify that everything is healthy:
```

:checkhealth
```

## ⌨️ Main Keymaps

> Leader key: `<Space>`

| Shortcut | Action |

| ------------------------------------------ | ----------------------------------------- |

`<C-n>` | Toggle file explorer (Neo-tree) |

`<leader>e` | Focus file explorer |

`<leader>ff` | Search files (Telescope) |

`<leader>fw` | Search text (live grep) |

`<leader>of` | Recent files |

`<leader>fc`
