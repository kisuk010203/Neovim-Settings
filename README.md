# Neovim Config

Personal Neovim setup built on [lazy.nvim](https://github.com/folke/lazy.nvim).

## Editor Behaviour

| Setting | Value |
|---------|-------|
| Indentation | 2 spaces (tabs expanded) |
| Line numbers | Absolute + relative |
| Search | Incremental, case-insensitive (smart-case when uppercase used) |
| Scroll offset | 10 lines from top/bottom |
| Clipboard | Synced with system clipboard |
| Sign column | Always visible |

## Key Bindings

Leader key: `Space`

### Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between splits (left/down/up/right) |
| `<D-Left>` | Previous buffer |
| `<D-Right>` | Next buffer |

### File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file tree |

### Fuzzy Finder (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search file contents) |
| `<leader>fb` | Browse open buffers |
| `<leader>fh` | Search help tags |

### LSP

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `<leader>ca` | Code actions |
| `<leader>ih` | Toggle inlay hints |

### Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `<Tab>` / `<S-Tab>` | Navigate completion menu |
| `<CR>` | Confirm selection |
| `<C-Space>` | Manually trigger completion |
| `<C-e>` | Dismiss completion |

### Git (gitsigns)

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / previous hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gb` | Toggle inline blame |
| `<leader>gd` | Diff this file |

### Formatting (conform.nvim)

| Key | Action |
|-----|--------|
| `<leader>f` | Format buffer |

Format-on-save is also enabled automatically.

### Terminal (toggleterm)

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |
| `2<C-\>`, `3<C-\>` | Open/toggle additional terminal instances |

### Editing

| Key | Action |
|-----|--------|
| `<` / `>` (visual) | Indent left/right, keeping selection |
| `<leader>h` | Clear search highlight |
| `gc` / `gcc` | Toggle comment (motion / current line) |

## Plugins

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/formatter installer |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and parsing |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git diff markers and hunk actions |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Auto-formatting |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating terminal |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | LSP-based code folding |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status bar |
| [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) | Color scheme |
| [alpha.nvim](https://github.com/goolord/alpha-nvim) | Start screen dashboard |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets and quotes |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Comment toggling |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |

## LSP Language Servers

| Language | Server |
|----------|--------|
| Lua | `lua_ls` |
| TypeScript / JavaScript | `ts_ls` |
| Rust | `rust_analyzer` (inlay hints enabled) |
| Python | `pyright` |
| C / C++ | `clangd` (clang-tidy enabled) |
| OCaml | `ocamllsp` (inlay hints enabled) |
| Coq / Rocq | `coq_lsp` |

## Auto-Formatters

Requires formatters to be installed (run `:Mason` to install).

| Language | Formatter |
|----------|-----------|
| Lua | `stylua` |
| Python | `black` |
| TypeScript / JavaScript / JSON | `prettierd` |
| C / C++ | `clang-format` |
| Rust | `rustfmt` (via rust_analyzer) |
