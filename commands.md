# Neovim Commands Reference

## Navigation

### Basic Movement
- `h` - Move left
- `j` - Move down
- `k` - Move up
- `l` - Move right
- `w` - Jump to beginning of next word
- `b` - Jump to beginning of previous word
- `e` - Jump to end of current/next word
- `ge` - Jump to end of previous word
- `0` - Jump to beginning of line
- `^` - Jump to first non-blank character of line
- `$` - Jump to end of line
- `gg` - Jump to beginning of file
- `G` - Jump to end of file
- `:10` - Jump to line 10
- `10G` - Jump to line 10

### Page Movement
- `Ctrl + d` - Move down half a page
- `Ctrl + u` - Move up half a page
- `Ctrl + f` - Move down one page
- `Ctrl + b` - Move up one page
- `Ctrl + e` - Scroll down one line
- `Ctrl + y` - Scroll up one line

### Search and Jump
- `/text` - Search forward for "text"
- `?text` - Search backward for "text"
- `n` - Jump to next search result
- `N` - Jump to previous search result
- `*` - Search forward for word under cursor
- `#` - Search backward for word under cursor
- `:noh` - Clear search highlighting

### Sentence and Paragraph Movement
- `)` - Jump to next sentence
- `(` - Jump to previous sentence
- `}` - Jump to next paragraph
- `{` - Jump to previous paragraph

## Editing

### Insert Mode
- `i` - Enter insert mode before cursor
- `a` - Enter insert mode after cursor
- `I` - Enter insert mode at beginning of line
- `A` - Enter insert mode at end of line
- `o` - Open new line below and enter insert mode
- `O` - Open new line above and enter insert mode
- `Esc` - Exit insert mode

### Delete Commands
- `x` - Delete character under cursor
- `X` - Delete character before cursor
- `dw` - Delete word from cursor
- `db` - Delete word before cursor
- `dd` - Delete entire line
- `D` - Delete from cursor to end of line
- `d$` - Delete from cursor to end of line
- `d0` - Delete from cursor to beginning of line
- `dgg` - Delete from cursor to beginning of file
- `dG` - Delete from cursor to end of file

### Change Commands
- `cw` - Change word from cursor
- `cb` - Change word before cursor
- `cc` - Change entire line
- `C` - Change from cursor to end of line
- `r` - Replace single character
- `R` - Enter replace mode

### Copy and Paste
- `y` - Yank (copy) in visual mode
- `yy` - Yank entire line
- `Y` - Yank entire line
- `yiw` - Yank word under cursor
- `yaw` - Yank word under cursor including trailing space
- `y$` - Yank from cursor to end of line
- `y0` - Yank from cursor to beginning of line
- `p` - Paste after cursor
- `P` - Paste before cursor
- `"ayy` - Yank line to register 'a'
- `"ap` - Paste from register 'a'

### Undo and Redo
- `u` - Undo
- `Ctrl + r` - Redo
- `U` - Undo all changes on current line

## Visual Mode

### Visual Selection
- `v` - Enter visual mode
- `V` - Enter visual line mode
- `Ctrl + v` - Enter visual block mode
- `Esc` - Exit visual mode

### Visual Commands
- `y` - Yank selected text
- `d` - Delete selected text
- `c` - Change selected text
- `>` - Indent selected text
- `<` - Unindent selected text
- `*` - Search for selected text

## Window Management

### Window Navigation
- `Ctrl + h` - Move to left window
- `Ctrl + l` - Move to right window
- `Ctrl + j` - Move to lower window
- `Ctrl + k` - Move to upper window
- `Ctrl + w` then `h` - Move to left window
- `Ctrl + w` then `l` - Move to right window
- `Ctrl + w` then `j` - Move to lower window
- `Ctrl + w` then `k` - Move to upper window

### Window Operations
- `:sp` - Split window horizontally
- `:vsp` - Split window vertically
- `Ctrl + w` then `=` - Equalize window sizes
- `Ctrl + w` then `c` - Close current window
- `Ctrl + w` then `o` - Close other windows
- `Ctrl + w` then `_` - Maximize current window
- `Ctrl + w` then `r` - Rotate windows

## Buffer Management

### Buffer Navigation
- `:bn` - Next buffer
- `:bp` - Previous buffer
- `:b#` - Switch to last buffer
- `:b1` - Switch to buffer 1
- `:ls` - List all buffers
- `:bd` - Delete current buffer
- `:bd!` - Force delete current buffer

### Buffer Operations
- `:e filename` - Edit file
- `:w` - Write (save) file
- `:w filename` - Write to filename
- `:q` - Quit
- `:q!` - Quit without saving
- `:wq` - Write and quit
- `:x` - Write and quit (only if changed)

## File Operations

### File Navigation
- `:pwd` - Print working directory
- `:cd path` - Change directory
- `:Ex` - Open file explorer
- `:Sex` - Open file explorer in split
- `:Vex` - Open file explorer in vertical split

### File Search
- `:find filename` - Find file in path
- `:sfind filename` - Find file in split
- `:tabfind filename` - Find file in new tab

## Search and Replace

### Search
- `/pattern` - Search forward for pattern
- `?pattern` - Search backward for pattern
- `n` - Next search result
- `N` - Previous search result
- `*` - Search for word under cursor
- `#` - Search backward for word under cursor

### Replace
- `:s/old/new` - Substitute first occurrence on current line
- `:s/old/new/g` - Substitute all occurrences on current line
- `:%s/old/new/g` - Substitute all occurrences in file
- `:%s/old/new/gc` - Substitute with confirmation
- `:%s/old/new/gn` - Show count of matches without substituting

## Marks and Registers

### Marks
- `ma` - Set mark 'a' at current position
- `'a` - Jump to mark 'a'
- `:marks` - Show all marks
- `:delmarks a` - Delete mark 'a'
- `:delmarks!` - Delete all marks

### Registers
- `:reg` - Show all registers
- `"ayy` - Yank to register 'a'
- `"ap` - Paste from register 'a'
- `"+yy` - Yank to system clipboard
- `"+p` - Paste from system clipboard

## Macros

### Recording and Playing
- `qq` - Start recording macro to register 'q'
- `q` - Stop recording
- `@q` - Play macro from register 'q'
- `@@` - Play last used macro
- `5@q` - Play macro 5 times
- `:reg q` - Show contents of register 'q'

## Folding

### Fold Commands
- `za` - Toggle fold under cursor
- `zo` - Open fold under cursor
- `zc` - Close fold under cursor
- `zR` - Open all folds
- `zM` - Close all folds
- `zj` - Move to next fold
- `zk` - Move to previous fold

## Terminal

### Terminal Commands
- `:term` - Open terminal
- `:sp | term` - Open terminal in split
- `:vsp | term` - Open terminal in vertical split
- `Ctrl + \` then `n` - Exit terminal mode
- `i` - Enter terminal mode
- `Esc` - Exit terminal mode

## Configuration

### Reload Configuration
- `:source ~/.config/nvim/init.lua` - Reload main config
- `:source ~/.config/nvim/lua/keymaps.lua` - Reload keymaps
- `<leader>rr` - Reload configuration (if mapped)

### Plugin Management
- `:Lazy sync` - Sync plugins
- `:Lazy reload plugin_name` - Reload specific plugin
- `:Lazy check` - Check for updates
- `:Lazy install` - Install missing plugins

## Telescope Commands

### File Operations
- `:Telescope find_files` - Find files
- `:Telescope live_grep` - Live grep
- `:Telescope buffers` - List buffers
- `:Telescope help_tags` - Search help
- `:Telescope keymaps` - Search keymaps

### Custom Searches
- `:Telescope live_grep search_dirs={"path"}` - Search in specific directory
- `:Telescope live_grep find_command={"rg", "--type", "py"}` - Search only Python files

## LSP (Language Server Protocol)

### LSP Commands
- `gd` - Go to definition
- `gr` - Go to references
- `gI` - Go to implementation
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<leader>cf` - Format current buffer (Ruff / Biome)
- `<leader>co` - Organize imports
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

## Git Integration

### Git Commands
- `:G` - Open Git status
- `:Gdiff` - Show diff
- `:Gblame` - Show blame
- `:Glog` - Show log
- `:Gpush` - Push changes
- `:Gpull` - Pull changes

## Quick Tips

### Efficiency Tips
- Use numbers with commands: `5j` (move down 5 lines), `3dd` (delete 3 lines)
- Combine commands: `dap` (delete around paragraph)
- Use text objects: `ciw` (change inner word), `di"` (delete inside quotes)
- Use marks for quick navigation
- Use registers to store multiple pieces of text

### Best Practices
- Stay in normal mode when not typing
- Use relative line numbers for navigation
- Learn to use text objects effectively
- Use macros for repetitive tasks
- Customize your keymaps for efficiency 