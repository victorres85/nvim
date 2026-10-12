# Neovim Commands Reference

## Navigation

### Basic Movement
- `h` - Move cursor left
- `j` - Move cursor down
- `k` - Move cursor up
- `l` - Move cursor right
- `w` - Jump forward to start of next word
- `W` - Jump forward to start of next WORD (space-delimited)
- `b` - Jump backward to start of previous word
- `B` - Jump backward to start of previous WORD (space-delimited)
- `e` - Jump forward to end of current/next word
- `E` - Jump forward to end of current/next WORD
- `ge` - Jump backward to end of previous word
- `gE` - Jump backward to end of previous WORD
- `0` - Jump to beginning of line (column 0)
- `^` - Jump to first non-blank character of line
- `$` - Jump to end of line
- `gg` - Jump to first line of file
- `G` - Jump to last line of file
- `:10` - Jump directly to line 10
- `10G` - Jump directly to line 10
- `{count}j` - Move down count lines (e.g. 5j)
- `{count}k` - Move up count lines (e.g. 5k)

### In-Line Character Search
- `f{char}` - Find and jump forward to {char} on current line
- `F{char}` - Find and jump backward to {char} on current line
- `t{char}` - Jump forward until just before {char} on current line
- `T{char}` - Jump backward until just after {char} on current line
- `;` - Repeat last f/F/t/T search in same direction
- `,` - Repeat last f/F/t/T search in opposite direction

### Page and Screen Movement
- `Ctrl + d` - Scroll down half a page and center cursor
- `Ctrl + u` - Scroll up half a page and center cursor
- `Ctrl + f` - Scroll forward one full page
- `Ctrl + b` - Scroll backward one full page
- `Ctrl + e` - Scroll screen down one line (without moving cursor)
- `Ctrl + y` - Scroll screen up one line (without moving cursor)
- `H` - Jump cursor to High (top line of screen)
- `M` - Jump cursor to Middle line of screen
- `L` - Jump cursor to Low (bottom line of screen)
- `zz` - Center screen view around cursor line
- `zt` - Scroll screen so cursor line is at top
- `zb` - Scroll screen so cursor line is at bottom

### Search and Jump
- `/text` - Search forward for "text"
- `?text` - Search backward for "text"
- `n` - Jump to next search match
- `N` - Jump to previous search match
- `*` - Search forward for exact word under cursor
- `#` - Search backward for exact word under cursor
- `g*` - Search forward for partial word under cursor
- `g#` - Search backward for partial word under cursor
- `:noh` - Clear search highlight (or press Esc in normal mode)
- `%` - Jump between matching brackets: (), {}, []
- `Ctrl + o` - Jump backward to previous location in jump list
- `Ctrl + i` - Jump forward to next location in jump list
- `:jumps` - Display jump list history

### Sentence and Paragraph Movement
- `)` - Jump to start of next sentence
- `(` - Jump to start of previous sentence
- `}` - Jump to start of next paragraph or block
- `{` - Jump to start of previous paragraph or block
- `]]` - Jump to start of next section or function
- `[[` - Jump to start of previous section or function

## Editing and Operators

### Insert Mode
- `i` - Enter insert mode before cursor
- `a` - Enter insert mode after cursor
- `I` - Enter insert mode at first non-blank character of line
- `A` - Enter insert mode at end of line
- `o` - Open new line below cursor and enter insert mode
- `O` - Open new line above cursor and enter insert mode
- `Esc` - Exit insert mode back to normal mode
- `Ctrl + c` - Exit insert mode back to normal mode
- `Ctrl + w` - Delete previous word while in insert mode
- `Ctrl + u` - Delete from cursor to start of line in insert mode
- `Ctrl + r "` - Paste contents of default register in insert mode
- `Ctrl + r +` - Paste contents of system clipboard in insert mode
- `Ctrl + r =` - Evaluate calculator expression in insert mode (e.g. 15*8)

### Delete Commands
- `x` - Delete character under cursor
- `X` - Delete character before cursor
- `dw` - Delete word from cursor to beginning of next word
- `diw` - Delete inner word under cursor
- `daw` - Delete word under cursor including trailing space
- `db` - Delete word backward from cursor
- `dd` - Delete entire current line
- `D` - Delete from cursor to end of line
- `d$` - Delete from cursor to end of line
- `d0` - Delete from cursor to beginning of line
- `dgg` - Delete from cursor to beginning of file
- `dG` - Delete from cursor to end of file
- `d%` - Delete from cursor to matching bracket
- `"_d` - Delete into black hole register (does not overwrite clipboard)
- `"_dd` - Delete line into black hole register (preserves clipboard)

### Change Commands
- `cw` - Change word from cursor to end of word
- `ciw` - Change inner word under cursor
- `caw` - Change word under cursor including space
- `cb` - Change word backward from cursor
- `cc` - Change entire current line
- `C` - Change from cursor to end of line
- `c$` - Change from cursor to end of line
- `c0` - Change from cursor to beginning of line
- `s` - Substitute single character under cursor (delete and insert)
- `S` - Substitute entire current line (delete line and insert)
- `r{char}` - Replace character under cursor with {char}
- `R` - Enter replace mode (overwrite text)

### Copy and Paste
- `y` - Yank (copy) selected text in visual mode
- `yy` - Yank entire current line
- `Y` - Yank entire current line
- `yiw` - Yank inner word under cursor
- `yaw` - Yank word under cursor including space
- `y$` - Yank from cursor to end of line
- `y0` - Yank from cursor to start of line
- `p` - Paste after cursor or below current line
- `P` - Paste before cursor or above current line
- `"0p` - Paste last yanked text (ignores recent deletes)
- `"+yy` - Yank current line to system clipboard
- `"+p` - Paste from system clipboard after cursor
- `"+P` - Paste from system clipboard before cursor
- `"ayy` - Yank current line into named register 'a'
- `"ap` - Paste from named register 'a'

### Undo, Redo, and Repeat
- `u` - Undo last change
- `Ctrl + r` - Redo last undone change
- `U` - Undo all latest changes on current line
- `.` - Repeat last edit command (dot command)
- `Ctrl + a` - Increment number under cursor
- `Ctrl + x` - Decrement number under cursor

### Case Conversion and Indentation
- `~` - Toggle case of character under cursor
- `gU{motion}` - Make text uppercase across motion (e.g. gUiw)
- `gu{motion}` - Make text lowercase across motion (e.g. guiw)
- `gUU` - Make entire current line uppercase
- `guu` - Make entire current line lowercase
- `>>` - Indent current line right
- `<<` - Unindent current line left
- `==` - Auto-indent current line based on syntax
- `=G` - Auto-indent from current line to end of file
- `gg=G` - Auto-indent entire file
- `J` - Join current line with line below with space
- `gJ` - Join current line with line below without space

## Text Objects

### Word and String Objects
- `iw` - Inner word (excluding surrounding whitespace)
- `aw` - A word (including surrounding whitespace)
- `iW` - Inner WORD (space-separated chunk)
- `aW` - A WORD (including surrounding whitespace)
- `i"` - Inner double quotes (contents only)
- `a"` - Around double quotes (including the quotes)
- `i'` - Inner single quotes (contents only)
- `a'` - Around single quotes (including the quotes)
- `i\`` - Inner backticks (contents only)
- `a\`` - Around backticks (including the backticks)

### Block and Tag Objects
- `i(` - Inner parentheses (contents inside ())
- `a(` - Around parentheses (including ())
- `ib` - Inner block (same as i()
- `ab` - Around block (same as a()
- `i[` - Inner square brackets (contents inside [])
- `a[` - Around square brackets (including [])
- `i{` - Inner curly braces (contents inside {})
- `a{` - Around curly braces (including {})
- `iB` - Inner curly block (same as i{)
- `aB` - Around curly block (same as a{)
- `it` - Inner HTML/XML tag (contents inside <tag>...</tag>)
- `at` - Around HTML/XML tag (including <tag>...</tag>)
- `ip` - Inner paragraph
- `ap` - Around paragraph

## Visual Mode

### Visual Selection
- `v` - Enter character-wise visual mode
- `V` - Enter line-wise visual mode
- `Ctrl + v` - Enter column block-wise visual mode
- `gv` - Reselect last visual selection
- `o` - Switch cursor to other end of visual selection
- `Esc` - Exit visual mode
- `<leader>va` - Select entire file (`gg0vG$`)

### Visual Operations
- `y` - Yank (copy) selected text
- `d` - Delete selected text
- `c` - Change selected text (delete and enter insert mode)
- `>` - Indent selected lines right (keep in visual mode with gv)
- `<` - Unindent selected lines left
- `=` - Auto-indent selected lines
- `*` - Search forward for selected text
- `~` - Toggle case of selected text
- `u` - Make selected text lowercase
- `U` - Make selected text uppercase
- `I` - Insert text across all selected lines in block visual mode
- `A` - Append text across all selected lines in block visual mode

## Window and Split Management

### Tmux and Window Navigation
- `Ctrl + h` - Navigate to left window or tmux pane
- `Ctrl + j` - Navigate to lower window or tmux pane
- `Ctrl + k` - Navigate to upper window or tmux pane
- `Ctrl + l` - Navigate to right window or tmux pane
- `Ctrl + \` - Navigate to previous window or tmux pane
- `Ctrl + w w` - Cycle to next open window
- `Ctrl + w p` - Jump to previous active window

### Split Creation and Closing
- `:sp` - Split window horizontally
- `:vsp` - Split window vertically
- `:sp {file}` - Open {file} in horizontal split
- `:vsp {file}` - Open {file} in vertical split
- `Ctrl + w s` - Split window horizontally
- `Ctrl + w v` - Split window vertically
- `Ctrl + w q` - Quit and close current window
- `Ctrl + w c` - Close current window
- `Ctrl + w o` - Close all other windows except current

### Split Resizing and Layout
- `Ctrl + w =` - Equalize width and height of all windows
- `Ctrl + w _` - Maximize height of current window
- `Ctrl + w |` - Maximize width of current window
- `Ctrl + w +` - Increase height of current window
- `Ctrl + w -` - Decrease height of current window
- `Ctrl + w >` - Increase width of current window
- `Ctrl + w <` - Decrease width of current window
- `Ctrl + w r` - Rotate windows downward/rightward
- `Ctrl + w R` - Rotate windows upward/leftward
- `Ctrl + w H` - Move current window to far left
- `Ctrl + w L` - Move current window to far right
- `Ctrl + w J` - Move current window to bottom
- `Ctrl + w K` - Move current window to top

## Tab Management

### Tab Operations
- `:tabnew` - Open a new empty tab page
- `:tabnew {file}` - Open {file} in a new tab page
- `:tabclose` - Close current tab page
- `:tabonly` - Close all other tabs except current
- `:tabn` - Go to next tab page
- `gt` - Go to next tab page
- `:tabp` - Go to previous tab page
- `gT` - Go to previous tab page
- `{count}gt` - Jump directly to tab number {count}
- `:tabm {n}` - Move current tab to position {n}

## Buffer Management

### Buffer Navigation
- `:bn` - Switch to next buffer in list
- `:bp` - Switch to previous buffer in list
- `:b#` - Switch to alternate (last active) buffer
- `<leader><Tab>` - Quick switch back to last active buffer
- `:b {name}` - Switch to buffer matching filename {name}
- `:b {num}` - Switch to buffer number {num}
- `:ls` - List all active buffers with numbers and status
- `<leader><leader>` - Fuzzy search and switch open buffers (Telescope)

### Buffer Operations
- `:bd` - Delete (close) current buffer
- `:bd!` - Force delete current buffer without saving
- `:bd {num}` - Delete buffer number {num}
- `<leader>bd` - Delete all other buffers except current (`%bd|e#`)
- `:e {file}` - Open and edit file in current buffer
- `:e!` - Reload current file from disk (discard changes)
- `:w` - Save current buffer to disk
- `:w!` - Force save current buffer
- `:w {file}` - Save current buffer to new filename
- `:q` - Quit current window
- `:q!` - Quit without saving changes
- `:wq` - Save and quit
- `:x` - Save only if modified and quit
- `:qa` - Quit all open windows and buffers
- `:qa!` - Force quit all without saving
- `:wqa` - Save all open buffers and quit

## Search and Replace

### Pattern Search
- `/pattern` - Search forward for regex pattern
- `?pattern` - Search backward for regex pattern
- `n` - Move to next match
- `N` - Move to previous match
- `:noh` - Clear search highlight
- `q/` - Open search history in editable command-line window
- `q:` - Open Ex command history in editable window

### Substitution
- `:s/old/new` - Substitute first occurrence of old with new on current line
- `:s/old/new/g` - Substitute all occurrences on current line
- `:%s/old/new/g` - Substitute all occurrences in entire file
- `:%s/old/new/gc` - Substitute all occurrences with interactive confirmation
- `:%s/old/new/gn` - Count occurrences of pattern without replacing
- `:'<,'>s/old/new/g` - Substitute across visually selected lines
- `:%s/\<old\>/new/g` - Substitute only exact whole word matches

## Marks and Registers

### Marks
- `ma` - Set local mark 'a' at current position
- `mA` - Set global mark 'A' (persists across files)
- `'a` - Jump to line of mark 'a'
- `` `a `` - Jump to exact line and column of mark 'a'
- `''` - Jump back to line before last jump
- `` `` `` - Jump back to exact position before last jump
- `'.` - Jump to line of last change in file
- `gi` - Jump to position of last insert mode exit and enter insert
- `:marks` - List all current marks
- `:delmarks a` - Delete mark 'a'
- `:delmarks!` - Delete all lowercase marks

### Registers
- `:reg` - Display contents of all registers
- `"+yy` - Yank line into system clipboard register
- `"+p` - Paste from system clipboard register
- `"0p` - Paste text from last yank (protected from deletes)
- `"_dd` - Delete line into blackhole register (preserves clipboard)
- `"_d{motion}` - Delete text across motion into blackhole register
- `"ayy` - Yank line into named register 'a'
- `"ap` - Paste from named register 'a'
- `"Ayy` - Append line into named register 'a' (capital letter)

## Macros

### Macro Recording and Playback
- `qq` - Start recording macro into register 'q'
- `q` - Stop recording macro
- `@q` - Execute macro stored in register 'q'
- `@@` - Repeat last executed macro
- `5@q` - Execute macro in register 'q' 5 times
- `:reg q` - Inspect macro instructions inside register 'q'
- `"qp` - Paste macro as text to edit it

## Code Folding

### Fold Commands
- `za` - Toggle fold under cursor open or closed
- `zo` - Open fold under cursor
- `zc` - Close fold under cursor
- `zR` - Open all folds in current buffer
- `zM` - Close all folds in current buffer
- `zj` - Move cursor down to next fold
- `zk` - Move cursor up to previous fold
- `zd` - Delete fold under cursor
- `zE` - Delete all folds in buffer

## Terminal and Floaterm

### Builtin Terminal
- `:term` - Open terminal in current window
- `:sp | term` - Open terminal in horizontal split
- `:vsp | term` - Open terminal in vertical split
- `<leader>tt` - Open terminal in current buffer
- `<leader>ts` - Open terminal in horizontal split
- `<leader>tv` - Open terminal in vertical split
- `Ctrl + \ then n` - Exit terminal mode back to normal mode
- `i` - Re-enter terminal insert mode from normal mode

### Floaterm Popup Terminal
- `<F12>` - Toggle floating terminal window
- `<F7>` - Create new Floaterm instance
- `<F8>` - Switch to previous Floaterm instance
- `<F9>` - Switch to next Floaterm instance
- `<F5>` - Save and run current Python file in Floaterm
- `:FloatermNew` - Create new floating terminal
- `:FloatermToggle` - Toggle floating terminal
- `:FloatermKill` - Terminate current Floaterm instance

## Telescope (Fuzzy Finder)

### Files and Search
- `<leader>f` - Fuzzy find files in project (`find_files`)
- `<leader>sg` - Search project contents by live grep (`live_grep`)
- `<leader>sw` - Search for word under cursor across project (`grep_string`)
- `<leader>s/` - Live grep only inside currently open files
- `<leader>/` - Fuzzy search lines inside current buffer
- `<leader>sn` - Search Neovim configuration files
- `<leader>sds` - Search within specific directory prompt

### Buffers and History
- `<leader><leader>` - Search and jump to open buffers (`buffers`)
- `<leader>s.` - Search recent files list (`oldfiles`)
- `<leader>sr` - Resume last active Telescope search (`resume`)

### Help and Keymaps
- `<leader>sh` - Search Neovim help documentation tags (`help_tags`)
- `<leader>sk` - Search configured keymaps (`keymaps`)
- `<leader>ss` - Browse all available Telescope builtin pickers
- `<leader>sd` - Search LSP diagnostics across workspace (`diagnostics`)

### Commands Cheat Sheet
- `:Commands` - Search commands reference in interactive popup (Telescope)
- `:CheatSheet` - Search commands reference in interactive popup (Telescope)
- `<leader>sc` - Search commands reference by keyword in popup
- `<leader>?` - Search commands reference by keyword in popup
- `:CommandsDoc` - Open full commands.md in floating popup modal
- `:CommandsPopup` - Open full commands.md in floating popup modal
- `<leader>sC` - Open full commands.md in floating popup modal
- `Ctrl + p` - Switch from search popup to floating doc view
- `Ctrl + e` - Execute Ex command directly from search popup
- `Ctrl + y` - Copy highlighted command to clipboard in popup

## LSP (Language Server Protocol)

### Code Navigation
- `gd` - Go to symbol definition (Telescope)
- `gr` - Go to symbol references across project (Telescope)
- `gI` - Go to implementation of interface/type (Telescope)
- `gD` - Go to symbol declaration (header/interface)
- `<leader>D` - Go to type definition (Telescope)
- `<leader>ds` - Fuzzy find document symbols in file (Telescope)
- `<leader>ws` - Fuzzy find workspace symbols across project (Telescope)
- `Ctrl + t` - Jump backward after jumping to definition

### Code Actions and Refactoring
- `K` - Display hover documentation popup for symbol
- `<leader>rn` - Rename symbol across entire project
- `<leader>ca` - Open LSP code actions popup
- `<leader>cf` - Format current buffer (Ruff for Python / Biome for JS)
- `<leader>co` - Organize imports in current file

### Diagnostics
- `[d` - Jump to previous diagnostic warning/error
- `]d` - Jump to next diagnostic warning/error
- `<leader>e` - Open floating window with diagnostic error details
- `<leader>q` - Populate and open diagnostic quickfix list

## Autocompletion and Snippets (nvim-cmp)

### Completion Controls
- `Ctrl + Space` - Manually trigger completion menu popup
- `<Tab>` - Select next completion suggestion
- `Ctrl + n` - Select next completion suggestion
- `<S-Tab>` - Select previous completion suggestion
- `Ctrl + p` - Select previous completion suggestion
- `<CR>` - Confirm and insert selected completion (auto-imports)
- `Ctrl + b` - Scroll documentation popup backward
- `Ctrl + f` - Scroll documentation popup forward

### Snippet Jumps
- `Ctrl + l` - Jump forward to next snippet placeholder (LuaSnip)
- `Ctrl + h` - Jump backward to previous snippet placeholder (LuaSnip)

## Debugging (nvim-dap & Python)

### Breakpoints and Execution
- `<leader>db` - Toggle breakpoint on current line
- `<leader>dc` - Start debugging or continue to next breakpoint
- `<leader>do` - Step over current line
- `<leader>di` - Step into function under cursor
- `<leader>dO` - Step out of current function
- `<leader>dq` - Terminate active debugging session

### Debug UI and Test Runners
- `<leader>du` - Toggle interactive DAP UI panels
- `<leader>dt` - Debug current test file with pytest in terminal
- `<leader>dT` - Debug all project tests with pytest in terminal

## Git Integration

### Gitsigns Hunks
- `]c` - Jump to next changed git hunk
- `[c` - Jump to previous changed git hunk
- `<leader>hs` - Stage git hunk under cursor (normal or visual)
- `<leader>hr` - Reset (discard) git hunk under cursor (normal or visual)
- `<leader>hS` - Stage entire buffer changes to git index
- `<leader>hu` - Undo last staged hunk
- `<leader>hR` - Reset entire buffer changes
- `<leader>hp` - Preview diff of git hunk in floating popup

### Git Blame and Diff
- `<leader>hb` - Show git blame popup for current line
- `<leader>hd` - Diff current buffer against git index
- `<leader>hD` - Diff current buffer against last git commit
- `<leader>tb` - Toggle continuous git blame display on current line
- `<leader>tD` - Toggle visibility of deleted lines inline

### Fugitive Git Commands
- `:G` - Open Fugitive interactive git status window
- `:Gdiff` - Open side-by-side git diff split
- `:Gblame` - Open git blame column
- `:Glog` - Load git commit history into quickfix list
- `:Gpush` - Push current branch to remote
- `:Gpull` - Pull changes from remote branch

## File Explorer (NvimTree)

### Tree Toggle and Navigation
- `<leader>pv` - Toggle NvimTree file explorer sidebar
- `o` - Open file or expand directory in NvimTree
- `<CR>` - Open file or expand directory in NvimTree
- `v` - Open selected file in vertical split
- `s` - Open selected file in horizontal split
- `R` - Refresh file tree from disk
- `H` - Toggle visibility of hidden files (dotfiles)
- `q` - Close NvimTree sidebar

### File Management in Tree
- `a` - Create new file or folder (end with / for directory)
- `d` - Delete selected file or folder
- `r` - Rename selected file or folder
- `x` - Cut file or folder to clipboard
- `c` - Copy file or folder to clipboard
- `p` - Paste copied or cut file into directory
- `y` - Copy filename to clipboard
- `Y` - Copy relative path to clipboard

## Surround and Text Editing (mini.nvim)

### Surround Operations
- `saiw)` - Surround inner word with parentheses ()
- `saiw"` - Surround inner word with double quotes ""
- `saiw'` - Surround inner word with single quotes ''
- `saiw}` - Surround inner word with curly braces {}
- `saiw]` - Surround inner word with square brackets []
- `sd'` - Delete surrounding single quotes
- `sd"` - Delete surrounding double quotes
- `sd)` - Delete surrounding parentheses
- `sr)'` - Replace surrounding parentheses with single quotes
- `sr'"` - Replace surrounding single quotes with double quotes
- `sa{motion}{char}` - Surround text covered by motion with {char}

### Extended Text Objects
- `va)` - Visually select around parentheses
- `yinq` - Yank inside next quote in line
- `ci'` - Change inside single quotes

## AI Assistant (Avante.nvim)

### Avante AI Commands
- `<leader>aa` - Open Avante AI sidebar chat prompt
- `<leader>ae` - Edit selected code block with Avante AI
- `<leader>ar` - Refresh Avante AI state
- `<leader>af` - Focus Avante AI sidebar window
- `<leader>at` - Toggle Avante AI sidebar window

## Markdown and Notes

### Markdown Preview
- `:MarkdownPreview` - Start live markdown preview in web browser
- `:MarkdownPreviewStop` - Stop active markdown preview server
- `:MarkdownPreviewToggle` - Toggle markdown preview server

### Todo Comments
- `:TodoTelescope` - Search all TODO, FIXME, NOTE, BUG comments in project
- `:TodoQuickFix` - Populate all project TODO comments in quickfix list
- `:TodoLocList` - Populate all project TODO comments in location list
- `]t` - Jump to next TODO comment in file
- `[t` - Jump to previous TODO comment in file

## Configuration and Package Management

### Config and Custom Keymaps
- `:source ~/.config/nvim/init.lua` - Reload main Neovim configuration file
- `<leader>rr` - Reload Neovim configuration (`source init.lua`)
- `<leader>np` - Create new Python file with automatic folder creation
- `<leader>va` - Visually select entire file contents
- `<leader>bd` - Delete all other buffers except active one
- `<CR>` - Break line after cursor in normal mode

### Lazy and Mason
- `:Lazy` - Open Lazy plugin manager interface
- `:Lazy sync` - Sync, install, clean, and update all plugins
- `:Lazy update` - Update installed plugins
- `:Lazy check` - Check for available plugin updates
- `:Lazy clean` - Remove unused plugins
- `:Mason` - Open Mason manager (LSP servers, DAP adapters, formatters)
- `:MasonUpdate` - Update Mason package registry
- `:checkhealth` - Run health checks for Neovim and all plugins

## Quick Tips

### Efficiency Tips
- Use count numbers with commands: `5j` (down 5 lines), `3dd` (delete 3 lines), `10p` (paste 10 times)
- Combine operators and motions: `dap` (delete around paragraph), `yG` (yank to end of file)
- Leverage text objects: `ciw` (change inner word), `di"` (delete inside quotes), `ca(` (change around parens)
- Use the dot command (`.`) to repeat your last edit instantly across multiple lines
- Use `Ctrl + a` and `Ctrl + x` to increment and decrement numbers directly without typing
- Use `"_d` to delete text without overwriting what you previously copied to the clipboard
- Use `"0p` to paste what you yanked even if you deleted something in between
- Use marks (`ma` and `'a`) for jumping between faraway locations in code
- Use `<leader>sc` or `<leader>?` anytime you forget a key or command

### Best Practices
- Stay in normal mode by default; only enter insert mode when actively typing
- Use relative line numbers to know the exact count needed for jumps (e.g. `8j`, `12k`)
- Prefer text objects (`ciw`, `da(`, `yi"`) over manual character selection
- Keep repetitive operations automated using macros (`qq` ... `q` then `@q`)
- Keep your configuration modular and use `<leader>rr` to test changes immediately
## Git (diffview / neogit)
- `<leader>gd` - Open Diffview (working tree changes, merge conflicts)
- `<leader>gh` - Diffview history of current file
- `<leader>gH` - Diffview history of branch
- `<leader>gq` - Close Diffview
- `<leader>gg` - Open Neogit (stage, commit, push)
- `<leader>gc` - Neogit commit

## Markdown
- `<leader>mp` - Toggle browser preview of the current markdown file (`:MarkdownPreviewToggle`)
