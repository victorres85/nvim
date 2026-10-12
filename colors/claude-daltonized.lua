-- Claude Code "dark-daltonized" palette, ported to Neovim with fixed hex values.
-- Hex values are the RGB values Claude Code 2.1.295 ships for that theme, so the
-- result does not depend on the terminal's ANSI palette. Needs truecolor
-- (inside tmux: set -as terminal-features ",*:RGB").

vim.cmd 'highlight clear'
if vim.fn.exists 'syntax_on' == 1 then vim.cmd 'syntax reset' end
vim.g.colors_name = 'claude-daltonized'
vim.o.termguicolors = true
vim.o.background = 'dark'

local c = {
  text = '#FFFFFF',
  black = '#000000',
  orange = '#FF9933', -- claude
  blue = '#3399FF', -- success / bash border
  light_blue = '#99CCFF', -- permission / suggestion
  sky = '#66B2FF', -- subagent blue
  red = '#FF6666', -- error
  yellow = '#FFCC00', -- warning
  bright_yellow = '#FFFF66',
  purple = '#AF87FF', -- auto-accept / skill / merged
  teal = '#669999', -- plan mode
  cyan = '#66CCCC', -- subagent cyan
  peach = '#FFB266', -- subagent orange
  pink = '#FF99CC', -- subagent pink
  ide_blue = '#4782C8',
  inactive = '#999999',
  prompt_border = '#888888',
  subtle = '#505050',
  bg = '#300A24',
  bg_sidebar = '#262626', -- composer sidebar
  bg_user = '#373737', -- user message
  bg_user_hover = '#464646',
  bg_select = '#264F78', -- selection
  bg_bash = '#413C41',
  bg_memory = '#374146',
  diff_add = '#004466',
  diff_add_word = '#0077B3',
  diff_del = '#660000',
  diff_del_word = '#B30000',
  diff_add_dim = '#3E515B',
  diff_del_dim = '#3E2C2C',
}

local function hi(group, spec) vim.api.nvim_set_hl(0, group, spec) end

-- Editor chrome
hi('Normal', { fg = c.text, bg = c.bg })
hi('NormalNC', { fg = c.text, bg = c.bg })
hi('NormalFloat', { fg = c.text, bg = c.bg_sidebar })
hi('FloatBorder', { fg = c.prompt_border, bg = c.bg_sidebar })
hi('FloatTitle', { fg = c.orange, bg = c.bg_sidebar, bold = true })
hi('Cursor', { fg = c.black, bg = c.text })
hi('CursorLine', { bg = c.bg_sidebar })
hi('CursorColumn', { bg = c.bg_sidebar })
hi('ColorColumn', { bg = c.bg_sidebar })
hi('LineNr', { fg = c.subtle })
hi('CursorLineNr', { fg = c.orange, bold = true })
hi('SignColumn', { fg = c.subtle, bg = c.bg })
hi('FoldColumn', { fg = c.subtle, bg = c.bg })
hi('Folded', { fg = c.inactive, bg = c.bg_sidebar })
hi('VertSplit', { fg = c.subtle })
hi('WinSeparator', { fg = c.subtle })
hi('EndOfBuffer', { fg = c.bg })
hi('NonText', { fg = c.subtle })
hi('Whitespace', { fg = c.subtle })
hi('SpecialKey', { fg = c.subtle })
hi('Conceal', { fg = c.inactive })
hi('MatchParen', { fg = c.orange, bold = true, underline = true })
hi('Visual', { bg = c.bg_select })
hi('VisualNOS', { bg = c.bg_select })
hi('Search', { fg = c.black, bg = c.yellow })
hi('CurSearch', { fg = c.black, bg = c.orange })
hi('IncSearch', { fg = c.black, bg = c.orange })
hi('Substitute', { fg = c.black, bg = c.red })
hi('Directory', { fg = c.light_blue })
hi('Title', { fg = c.orange, bold = true })
hi('Question', { fg = c.light_blue })
hi('MoreMsg', { fg = c.blue })
hi('ModeMsg', { fg = c.orange })
hi('ErrorMsg', { fg = c.red })
hi('WarningMsg', { fg = c.yellow })
hi('WildMenu', { bg = c.bg_select })

-- Statusline / tabline / popup menu
hi('StatusLine', { fg = c.text, bg = c.bg_user })
hi('StatusLineNC', { fg = c.inactive, bg = c.bg_sidebar })
hi('TabLine', { fg = c.inactive, bg = c.bg_sidebar })
hi('TabLineFill', { bg = c.bg })
hi('TabLineSel', { fg = c.text, bg = c.bg_user, bold = true })
hi('WinBar', { fg = c.text, bg = c.bg })
hi('WinBarNC', { fg = c.inactive, bg = c.bg })
hi('Pmenu', { fg = c.text, bg = c.bg_sidebar })
hi('PmenuSel', { fg = c.text, bg = c.bg_select })
hi('PmenuSbar', { bg = c.bg_user })
hi('PmenuThumb', { bg = c.prompt_border })

-- Syntax: blue/orange/purple/yellow axis, no red/green reliance
hi('Comment', { fg = c.inactive })
hi('Constant', { fg = c.yellow })
hi('String', { fg = c.orange })
hi('Character', { fg = c.orange })
hi('Number', { fg = c.yellow })
hi('Boolean', { fg = c.yellow })
hi('Float', { fg = c.yellow })
hi('Identifier', { fg = c.text })
hi('Function', { fg = c.light_blue })
hi('Statement', { fg = c.purple })
hi('Conditional', { fg = c.purple })
hi('Repeat', { fg = c.purple })
hi('Label', { fg = c.purple })
hi('Operator', { fg = c.text })
hi('Keyword', { fg = c.purple })
hi('Exception', { fg = c.purple })
hi('PreProc', { fg = c.sky })
hi('Include', { fg = c.purple })
hi('Define', { fg = c.purple })
hi('Macro', { fg = c.sky })
hi('PreCondit', { fg = c.sky })
hi('Type', { fg = c.cyan })
hi('StorageClass', { fg = c.purple })
hi('Structure', { fg = c.cyan })
hi('Typedef', { fg = c.cyan })
hi('Special', { fg = c.peach })
hi('SpecialChar', { fg = c.peach })
hi('Tag', { fg = c.sky })
hi('Delimiter', { fg = c.inactive })
hi('SpecialComment', { fg = c.teal })
hi('Debug', { fg = c.peach })
hi('Underlined', { fg = c.light_blue, underline = true })
hi('Ignore', { fg = c.subtle })
hi('Error', { fg = c.red })
hi('Todo', { fg = c.black, bg = c.yellow, bold = true })

-- Treesitter
hi('@variable', { fg = c.text })
hi('@variable.builtin', { fg = c.peach })
hi('@variable.parameter', { fg = c.pink })
hi('@variable.member', { fg = c.light_blue })
hi('@property', { fg = c.light_blue })
hi('@constant', { fg = c.yellow })
hi('@constant.builtin', { fg = c.yellow })
hi('@module', { fg = c.cyan })
hi('@constructor', { fg = c.cyan })
hi('@function', { fg = c.light_blue })
hi('@function.builtin', { fg = c.sky })
hi('@function.call', { fg = c.light_blue })
hi('@function.method', { fg = c.light_blue })
hi('@keyword', { fg = c.purple })
hi('@keyword.function', { fg = c.purple })
hi('@keyword.return', { fg = c.purple })
hi('@type', { fg = c.cyan })
hi('@type.builtin', { fg = c.cyan })
hi('@tag', { fg = c.sky })
hi('@tag.attribute', { fg = c.light_blue })
hi('@tag.delimiter', { fg = c.inactive })
hi('@punctuation', { fg = c.inactive })
hi('@punctuation.special', { fg = c.peach })
hi('@string.escape', { fg = c.peach })
hi('@string.regexp', { fg = c.peach })
hi('@comment', { fg = c.inactive })
hi('@comment.todo', { fg = c.black, bg = c.yellow, bold = true })
hi('@comment.note', { fg = c.black, bg = c.blue, bold = true })
hi('@comment.warning', { fg = c.black, bg = c.yellow, bold = true })
hi('@comment.error', { fg = c.black, bg = c.red, bold = true })
hi('@markup.heading', { fg = c.orange, bold = true })
hi('@markup.strong', { bold = true })
hi('@markup.italic', { italic = true })
hi('@markup.link', { fg = c.light_blue })
hi('@markup.link.url', { fg = c.light_blue, underline = true })
hi('@markup.raw', { fg = c.peach })
hi('@markup.list', { fg = c.purple })

-- Diagnostics (blue is "ok/info", never green)
hi('DiagnosticError', { fg = c.red })
hi('DiagnosticWarn', { fg = c.yellow })
hi('DiagnosticInfo', { fg = c.blue })
hi('DiagnosticHint', { fg = c.teal })
hi('DiagnosticOk', { fg = c.blue })
hi('DiagnosticUnderlineError', { undercurl = true, sp = c.red })
hi('DiagnosticUnderlineWarn', { undercurl = true, sp = c.yellow })
hi('DiagnosticUnderlineInfo', { undercurl = true, sp = c.blue })
hi('DiagnosticUnderlineHint', { undercurl = true, sp = c.teal })
hi('DiagnosticVirtualTextError', { fg = c.red, bg = c.diff_del_dim })
hi('DiagnosticVirtualTextWarn', { fg = c.yellow, bg = c.bg_bash })
hi('DiagnosticVirtualTextInfo', { fg = c.blue, bg = c.diff_add_dim })
hi('DiagnosticVirtualTextHint', { fg = c.teal, bg = c.bg_memory })
hi('LspReferenceText', { bg = c.bg_user })
hi('LspReferenceRead', { bg = c.bg_user })
hi('LspReferenceWrite', { bg = c.bg_user, underline = true })
hi('SpellBad', { undercurl = true, sp = c.red })
hi('SpellCap', { undercurl = true, sp = c.yellow })
hi('SpellLocal', { undercurl = true, sp = c.blue })
hi('SpellRare', { undercurl = true, sp = c.purple })

-- Diff (Claude Code's dark-blue added / dark-red removed)
hi('DiffAdd', { bg = c.diff_add })
hi('DiffDelete', { fg = c.diff_del_word, bg = c.diff_del })
hi('DiffChange', { bg = c.bg_memory })
hi('DiffText', { bg = c.diff_add_word })
hi('Added', { fg = c.blue })
hi('Changed', { fg = c.yellow })
hi('Removed', { fg = c.red })
hi('GitSignsAdd', { fg = c.blue })
hi('GitSignsChange', { fg = c.yellow })
hi('GitSignsDelete', { fg = c.red })

-- Plugins that don't inherit from the groups above
hi('CmpItemAbbrMatch', { fg = c.orange, bold = true })
hi('CmpItemAbbrMatchFuzzy', { fg = c.orange, bold = true })
hi('CmpItemAbbrDeprecated', { fg = c.inactive, strikethrough = true })
hi('CmpItemMenu', { fg = c.inactive })
hi('CmpItemKind', { fg = c.cyan })
hi('TelescopeSelection', { bg = c.bg_select })
hi('TelescopeMatching', { fg = c.orange, bold = true })
hi('NvimTreeNormal', { fg = c.text, bg = c.bg_sidebar })
hi('NvimTreeFolderName', { fg = c.light_blue })
hi('NvimTreeRootFolder', { fg = c.orange, bold = true })
hi('NvimTreeGitDirty', { fg = c.yellow })
hi('NvimTreeGitNew', { fg = c.blue })
hi('NvimTreeGitDeleted', { fg = c.red })
hi('WhichKey', { fg = c.light_blue })
hi('WhichKeyDesc', { fg = c.text })
hi('WhichKeyGroup', { fg = c.purple })
hi('MiniStatuslineModeNormal', { fg = c.black, bg = c.light_blue, bold = true })
hi('MiniStatuslineModeInsert', { fg = c.black, bg = c.blue, bold = true })
hi('MiniStatuslineModeVisual', { fg = c.black, bg = c.purple, bold = true })
hi('MiniStatuslineModeReplace', { fg = c.black, bg = c.red, bold = true })
hi('MiniStatuslineModeCommand', { fg = c.black, bg = c.yellow, bold = true })

-- :terminal / floatterm palette (blue stands in for green)
local term = {
  c.black, c.red, c.blue, c.yellow, c.sky, c.purple, c.cyan, c.inactive,
  c.subtle, c.red, c.light_blue, c.bright_yellow, c.light_blue, c.pink, c.cyan, c.text,
}
for i, color in ipairs(term) do
  vim.g['terminal_color_' .. (i - 1)] = color
end
