" ==========================================================================
" Reset
" ==========================================================================
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark

" ==========================================================================
" Palette
"   Syntax hues come from the terminal ANSI palette (variety),
"   white/neutral text from bright_white + on_surface (readability),
"   UI chrome from the Material surface/primary roles (cohesion).
"
"   Colorful variant: only plain identifiers / variables / properties /
"   members stay white. Everything else gets its own hue.
" ==========================================================================
let s:red      = "{{ colors.terminal_normal_red.default.hex }}"
let s:green    = "{{ colors.terminal_normal_green.default.hex }}"
let s:yellow   = "{{ colors.terminal_normal_yellow.default.hex }}"
let s:blue     = "{{ colors.terminal_normal_blue.default.hex }}"
let s:magenta  = "{{ colors.terminal_normal_magenta.default.hex }}"
let s:cyan     = "{{ colors.terminal_normal_cyan.default.hex }}"
let s:bred     = "{{ colors.terminal_bright_red.default.hex }}"
let s:bgreen   = "{{ colors.terminal_bright_green.default.hex }}"
let s:byellow  = "{{ colors.terminal_bright_yellow.default.hex }}"
let s:bblue    = "{{ colors.terminal_bright_blue.default.hex }}"
let s:bmagenta = "{{ colors.terminal_bright_magenta.default.hex }}"
let s:bcyan    = "{{ colors.terminal_bright_cyan.default.hex }}"

let s:white    = "{{ colors.terminal_bright_white.default.hex }}"
let s:fg       = "{{ colors.on_surface.default.hex }}"
let s:fg_dim   = "{{ colors.on_surface_variant.default.hex }}"
let s:comment  = "{{ colors.outline.default.hex }}"
let s:faint    = "{{ colors.outline_variant.default.hex }}"

" h(group, fg, bg, attr [, sp])
function! s:h(group, fg, bg, attr, ...) abort
  let l:sp = a:0 ? a:1 : 'NONE'
  execute 'hi ' . a:group
        \ . ' guifg=' . a:fg . ' guibg=' . a:bg
        \ . ' gui=' . a:attr . ' guisp=' . l:sp
endfunction

" ==========================================================================
" Terminal Colors (g:terminal_color_x)
" ==========================================================================
if has('nvim')
  let g:terminal_color_0  = "{{ colors.terminal_normal_black.default.hex }}"
  let g:terminal_color_1  = "{{ colors.terminal_normal_red.default.hex }}"
  let g:terminal_color_2  = "{{ colors.terminal_normal_green.default.hex }}"
  let g:terminal_color_3  = "{{ colors.terminal_normal_yellow.default.hex }}"
  let g:terminal_color_4  = "{{ colors.terminal_normal_blue.default.hex }}"
  let g:terminal_color_5  = "{{ colors.terminal_normal_magenta.default.hex }}"
  let g:terminal_color_6  = "{{ colors.terminal_normal_cyan.default.hex }}"
  let g:terminal_color_7  = "{{ colors.terminal_normal_white.default.hex }}"
  let g:terminal_color_8  = "{{ colors.terminal_bright_black.default.hex }}"
  let g:terminal_color_9  = "{{ colors.terminal_bright_red.default.hex }}"
  let g:terminal_color_10 = "{{ colors.terminal_bright_green.default.hex }}"
  let g:terminal_color_11 = "{{ colors.terminal_bright_yellow.default.hex }}"
  let g:terminal_color_12 = "{{ colors.terminal_bright_blue.default.hex }}"
  let g:terminal_color_13 = "{{ colors.terminal_bright_magenta.default.hex }}"
  let g:terminal_color_14 = "{{ colors.terminal_bright_cyan.default.hex }}"
  let g:terminal_color_15 = "{{ colors.terminal_bright_white.default.hex }}"
endif

" ==========================================================================
" Core editor surface
" ==========================================================================
hi Normal        guibg=NONE guifg={{ colors.on_background.default.hex }}
hi NormalNC      guibg=NONE guifg={{ colors.on_background.default.hex }}
hi EndOfBuffer   guibg=NONE guifg={{ colors.outline_variant.default.hex }}
call s:h('NonText',    s:bmagenta, 'NONE', 'NONE')
call s:h('SpecialKey', s:bcyan,    'NONE', 'NONE')
hi Whitespace    guibg=NONE guifg={{ colors.outline_variant.default.hex }}
hi Conceal       guibg=NONE guifg={{ colors.outline.default.hex }}
hi Cursor        guibg={{ colors.primary.default.hex }} guifg={{ colors.on_primary.default.hex }}
hi lCursor       guibg={{ colors.primary.default.hex }} guifg={{ colors.on_primary.default.hex }}
hi CursorIM      guibg={{ colors.primary.default.hex }} guifg={{ colors.on_primary.default.hex }}

hi CursorLine    guibg={{ colors.surface_container_low.default.hex }} guifg=NONE
hi CursorColumn  guibg={{ colors.surface_container_low.default.hex }} guifg=NONE
hi ColorColumn   guibg={{ colors.surface_container_low.default.hex }} guifg=NONE
call s:h('MatchParen', s:bmagenta, '{{ colors.primary_container.default.hex }}', 'bold,underline')

call s:h('LineNr',       s:comment,  'NONE', 'NONE')
call s:h('LineNrAbove',  s:bblue,    'NONE', 'NONE')
call s:h('LineNrBelow',  s:bmagenta, 'NONE', 'NONE')
call s:h('CursorLineNr', s:byellow,  'NONE', 'bold')
call s:h('SignColumn',   s:bcyan,    'NONE', 'NONE')
call s:h('FoldColumn',   s:bblue,    'NONE', 'NONE')
call s:h('Folded',       s:bcyan,    '{{ colors.surface_container_low.default.hex }}', 'italic')

hi Visual        guibg={{ colors.primary_container.default.hex }} guifg={{ colors.on_surface.default.hex }}
hi VisualNOS     guibg={{ colors.primary_container.default.hex }} guifg={{ colors.on_surface.default.hex }}
hi Selection     guibg={{ colors.primary_container.default.hex }} guifg={{ colors.on_surface.default.hex }}

call s:h('Title',     s:bmagenta, 'NONE', 'bold')
call s:h('Directory', s:bblue,    'NONE', 'bold')

" ==========================================================================
" Search
" ==========================================================================
hi Search        guibg={{ colors.secondary_container.default.hex }} guifg={{ colors.on_secondary_container.default.hex }}
hi IncSearch     guibg={{ colors.tertiary_container.default.hex }} guifg={{ colors.on_tertiary_container.default.hex }} gui=bold
hi CurSearch     guibg={{ colors.tertiary_container.default.hex }} guifg={{ colors.on_tertiary_container.default.hex }} gui=bold
hi QuickFixLine  guibg={{ colors.surface_container_high.default.hex }} guifg=NONE gui=bold

" ==========================================================================
" Status line, tabs, windows
" ==========================================================================
hi StatusLine    guibg=NONE guifg={{ colors.on_surface.default.hex }}
hi StatusLineNC  guibg=NONE guifg={{ colors.outline.default.hex }}
call s:h('VertSplit', s:bmagenta, 'NONE', 'NONE')
hi TabLine       guibg={{ colors.surface_container.default.hex }} guifg={{ colors.on_surface_variant.default.hex }}
hi TabLineSel    guibg={{ colors.primary.default.hex }} guifg={{ colors.on_primary.default.hex }} gui=bold
hi TabLineFill   guibg={{ colors.surface_container_low.default.hex }} guifg=NONE
hi WildMenu      guibg={{ colors.primary_container.default.hex }} guifg={{ colors.on_primary_container.default.hex }}

" ==========================================================================
" Popup / completion menu
" ==========================================================================
hi Pmenu         guibg={{ colors.surface_container.default.hex }} guifg={{ colors.on_surface.default.hex }}
hi PmenuSel      guibg={{ colors.primary_container.default.hex }} guifg={{ colors.on_primary_container.default.hex }} gui=bold
hi PmenuSbar     guibg={{ colors.surface_container_high.default.hex }}
hi PmenuThumb    guibg={{ colors.outline.default.hex }}
call s:h('PmenuKind',     s:bmagenta, '{{ colors.surface_container.default.hex }}', 'NONE')
call s:h('PmenuKindSel',  s:bcyan,    '{{ colors.primary_container.default.hex }}', 'NONE')
call s:h('PmenuExtra',    s:comment,  '{{ colors.surface_container.default.hex }}', 'NONE')
call s:h('PmenuExtraSel', s:fg_dim,   '{{ colors.primary_container.default.hex }}', 'NONE')
call s:h('PmenuMatch',    s:byellow,  '{{ colors.surface_container.default.hex }}', 'bold')
call s:h('PmenuMatchSel', s:byellow,  '{{ colors.primary_container.default.hex }}', 'bold')

" ==========================================================================
" Diff (tinted backgrounds, coloured foregrounds)
" ==========================================================================
call s:h('DiffAdd',    s:bgreen,  '{{ colors.secondary_container.default.hex }}', 'NONE')
call s:h('DiffChange', s:byellow, '{{ colors.tertiary_container.default.hex }}',  'NONE')
call s:h('DiffDelete', s:bred,    '{{ colors.error_container.default.hex }}',     'NONE')
call s:h('DiffText',   s:bblue,   '{{ colors.primary_container.default.hex }}',   'bold')
hi link Added    DiffAdd
hi link Changed  DiffChange
hi link Removed  DiffDelete

" ==========================================================================
" Spelling
" ==========================================================================
call s:h('SpellBad',   'NONE', 'NONE', 'undercurl', s:red)
call s:h('SpellCap',   'NONE', 'NONE', 'undercurl', s:yellow)
call s:h('SpellLocal', 'NONE', 'NONE', 'undercurl', s:cyan)
call s:h('SpellRare',  'NONE', 'NONE', 'undercurl', s:magenta)

" ==========================================================================
" Messages / prompts
" ==========================================================================
hi Error         guibg={{ colors.error_container.default.hex }} guifg={{ colors.on_error_container.default.hex }}
call s:h('ErrorMsg',   s:bred,    'NONE', 'bold')
call s:h('WarningMsg', s:byellow, 'NONE', 'NONE')
call s:h('ModeMsg',    s:bgreen,  'NONE', 'bold')
call s:h('MoreMsg',    s:bgreen,  'NONE', 'NONE')
call s:h('Question',   s:bcyan,   'NONE', 'bold')

" ==========================================================================
" :terminal buffers
" ==========================================================================
hi Terminal      guibg={{ colors.terminal_background.default.hex }} guifg={{ colors.terminal_foreground.default.hex }}

" ==========================================================================
" Legacy Syntax Highlighting
"
"   WHITE      identifiers, variables, properties, members  (only these)
"   magenta    keywords          bright magenta  control flow
"   blue       functions         bright blue     calls / builtins
"   green      strings           bright green    chars / special strings
"   yellow     numbers, modules  bright yellow   constants / attributes
"   cyan       types             bright cyan     operators / escapes
"   red        preproc, errors   bright red      booleans / macros / params
" ==========================================================================
call s:h('Comment',        s:comment,  'NONE', 'italic')

call s:h('Constant',       s:byellow,  'NONE', 'NONE')
call s:h('String',         s:green,    'NONE', 'NONE')
call s:h('Character',      s:bgreen,   'NONE', 'NONE')
call s:h('Number',         s:bred,     'NONE', 'NONE')
call s:h('Boolean',        s:bmagenta, 'NONE', 'bold')
call s:h('Float',          s:yellow,   'NONE', 'NONE')

call s:h('Identifier',     s:white,    'NONE', 'NONE')
call s:h('Function',       s:bblue,    'NONE', 'NONE')

call s:h('Statement',      s:magenta,  'NONE', 'bold')
call s:h('Conditional',    s:bmagenta, 'NONE', 'bold')
call s:h('Repeat',         s:bred,     'NONE', 'bold')
call s:h('Label',          s:bcyan,    'NONE', 'NONE')
call s:h('Operator',       s:bcyan,    'NONE', 'NONE')
call s:h('Keyword',        s:magenta,  'NONE', 'bold')
call s:h('Exception',      s:red,      'NONE', 'bold')

call s:h('PreProc',        s:red,      'NONE', 'NONE')
call s:h('Include',        s:bblue,    'NONE', 'italic')
call s:h('Define',         s:bmagenta, 'NONE', 'NONE')
call s:h('Macro',          s:bred,     'NONE', 'NONE')
call s:h('PreCondit',      s:yellow,   'NONE', 'NONE')

call s:h('Type',           s:cyan,     'NONE', 'NONE')
call s:h('StorageClass',   s:bmagenta, 'NONE', 'italic')
call s:h('Structure',      s:bcyan,    'NONE', 'NONE')
call s:h('Typedef',        s:cyan,     'NONE', 'bold')

call s:h('Special',        s:bblue,    'NONE', 'NONE')
call s:h('SpecialChar',    s:bcyan,    'NONE', 'NONE')
call s:h('Tag',            s:bred,     'NONE', 'NONE')
call s:h('Delimiter',      s:bcyan,    'NONE', 'NONE')
call s:h('SpecialComment', s:bgreen,   'NONE', 'italic')
call s:h('Debug',          s:bred,     'NONE', 'NONE')

call s:h('Underlined',     s:bblue,    'NONE', 'underline')
call s:h('Ignore',         s:faint,    'NONE', 'NONE')
call s:h('Todo',           s:byellow,  'NONE', 'bold,underline')

" ==========================================================================
" Neovim Specific Section
" ==========================================================================
if has('nvim')

" --------------------------------------------------------------------------
" Floating windows & UI separators
" --------------------------------------------------------------------------
hi NormalFloat   guibg={{ colors.surface_container.default.hex }} guifg={{ colors.on_surface.default.hex }}
call s:h('FloatBorder', s:bmagenta, '{{ colors.surface_container.default.hex }}', 'NONE')
call s:h('FloatTitle',  s:bcyan,    '{{ colors.surface_container.default.hex }}', 'bold')
call s:h('WinSeparator', s:bblue,   'NONE', 'NONE')
call s:h('WinBar',       s:bcyan,   'NONE', 'NONE')
hi WinBarNC      guibg=NONE guifg={{ colors.outline.default.hex }}

" --------------------------------------------------------------------------
" Native diagnostics (error=red, warn=yellow, info=blue, hint=cyan, ok=green)
" --------------------------------------------------------------------------
call s:h('DiagnosticError', s:bred,    'NONE', 'NONE')
call s:h('DiagnosticWarn',  s:byellow, 'NONE', 'NONE')
call s:h('DiagnosticInfo',  s:bblue,   'NONE', 'NONE')
call s:h('DiagnosticHint',  s:bcyan,   'NONE', 'italic')
call s:h('DiagnosticOk',    s:bgreen,  'NONE', 'NONE')

hi DiagnosticVirtualTextError guibg={{ colors.error_container.default.hex }}     guifg={{ colors.on_error_container.default.hex }}
hi DiagnosticVirtualTextWarn  guibg={{ colors.tertiary_container.default.hex }}  guifg={{ colors.on_tertiary_container.default.hex }}
hi DiagnosticVirtualTextInfo  guibg={{ colors.secondary_container.default.hex }} guifg={{ colors.on_secondary_container.default.hex }}
hi DiagnosticVirtualTextHint  guibg={{ colors.surface_container_low.default.hex }} guifg={{ colors.on_surface_variant.default.hex }}
hi DiagnosticVirtualTextOk    guibg={{ colors.secondary_container.default.hex }} guifg={{ colors.on_secondary_container.default.hex }}

call s:h('DiagnosticUnderlineError', 'NONE', 'NONE', 'undercurl', s:red)
call s:h('DiagnosticUnderlineWarn',  'NONE', 'NONE', 'undercurl', s:yellow)
call s:h('DiagnosticUnderlineInfo',  'NONE', 'NONE', 'undercurl', s:blue)
call s:h('DiagnosticUnderlineHint',  'NONE', 'NONE', 'undercurl', s:cyan)
call s:h('DiagnosticUnderlineOk',    'NONE', 'NONE', 'undercurl', s:green)

call s:h('DiagnosticFloatingError', s:bred,    '{{ colors.surface_container.default.hex }}', 'NONE')
call s:h('DiagnosticFloatingWarn',  s:byellow, '{{ colors.surface_container.default.hex }}', 'NONE')
call s:h('DiagnosticFloatingInfo',  s:bblue,   '{{ colors.surface_container.default.hex }}', 'NONE')
call s:h('DiagnosticFloatingHint',  s:bcyan,   '{{ colors.surface_container.default.hex }}', 'NONE')
call s:h('DiagnosticFloatingOk',    s:bgreen,  '{{ colors.surface_container.default.hex }}', 'NONE')

call s:h('DiagnosticSignError', s:bred,    'NONE', 'NONE')
call s:h('DiagnosticSignWarn',  s:byellow, 'NONE', 'NONE')
call s:h('DiagnosticSignInfo',  s:bblue,   'NONE', 'NONE')
call s:h('DiagnosticSignHint',  s:bcyan,   'NONE', 'NONE')
call s:h('DiagnosticSignOk',    s:bgreen,  'NONE', 'NONE')

call s:h('DiagnosticDeprecated',  s:comment, 'NONE', 'strikethrough')
call s:h('DiagnosticUnnecessary', s:comment, 'NONE', 'NONE')

" --------------------------------------------------------------------------
" Treesitter highlight groups
" --------------------------------------------------------------------------

" Variables & Identifiers  (white base kept; builtins/params coloured)
call s:h('@variable',                   s:white,    'NONE', 'NONE')
call s:h('@variable.builtin',           s:bmagenta, 'NONE', 'italic')
call s:h('@variable.parameter',         s:bred,     'NONE', 'italic')
call s:h('@variable.parameter.builtin', s:bred,     'NONE', 'bold,italic')
call s:h('@variable.member',            s:white,    'NONE', 'NONE')

" Constants
call s:h('@constant',         s:byellow,  'NONE', 'NONE')
call s:h('@constant.builtin', s:bmagenta, 'NONE', 'bold')
call s:h('@constant.macro',   s:bred,     'NONE', 'bold')

" Strings, characters, numbers
call s:h('@string',                s:green,    'NONE', 'NONE')
call s:h('@string.documentation',  s:bgreen,   'NONE', 'italic')
call s:h('@string.regexp',         s:bred,     'NONE', 'NONE')
call s:h('@string.escape',         s:bcyan,    'NONE', 'bold')
call s:h('@string.special',        s:bmagenta, 'NONE', 'NONE')
call s:h('@string.special.symbol', s:bmagenta, 'NONE', 'NONE')
call s:h('@string.special.path',   s:bblue,    'NONE', 'italic')
call s:h('@string.special.url',    s:bblue,    'NONE', 'underline')
call s:h('@character',             s:bgreen,   'NONE', 'NONE')
call s:h('@character.special',     s:bcyan,    'NONE', 'NONE')
call s:h('@number',                s:bred,     'NONE', 'NONE')
call s:h('@number.float',          s:yellow,   'NONE', 'NONE')
call s:h('@boolean',               s:bmagenta, 'NONE', 'bold')
call s:h('@float',                 s:yellow,   'NONE', 'NONE')

" Functions  (definition vs call vs builtin vs macro all distinct)
call s:h('@function',             s:blue,     'NONE', 'bold')
call s:h('@function.builtin',     s:bcyan,    'NONE', 'italic')
call s:h('@function.call',        s:bblue,    'NONE', 'NONE')
call s:h('@function.macro',       s:bred,     'NONE', 'bold')
call s:h('@function.method',      s:blue,     'NONE', 'bold')
call s:h('@function.method.call', s:bgreen,   'NONE', 'NONE')
call s:h('@constructor',          s:byellow,  'NONE', 'bold')

" Keywords / control flow
call s:h('@keyword',             s:magenta,  'NONE', 'bold')
call s:h('@keyword.function',    s:bmagenta, 'NONE', 'bold')
call s:h('@keyword.operator',    s:bmagenta, 'NONE', 'NONE')
call s:h('@keyword.return',      s:red,      'NONE', 'bold')
call s:h('@keyword.import',      s:bblue,    'NONE', 'bold')
call s:h('@keyword.repeat',      s:bred,     'NONE', 'bold')
call s:h('@keyword.conditional', s:bmagenta, 'NONE', 'bold')
call s:h('@keyword.exception',   s:red,      'NONE', 'bold')
call s:h('@keyword.directive',   s:byellow,  'NONE', 'NONE')
call s:h('@keyword.modifier',    s:magenta,  'NONE', 'italic')
call s:h('@keyword.coroutine',   s:bcyan,    'NONE', 'bold')
call s:h('@keyword.type',        s:bmagenta, 'NONE', 'bold')

" Types & Attributes
call s:h('@type',              s:cyan,    'NONE', 'NONE')
call s:h('@type.builtin',      s:bcyan,   'NONE', 'italic')
call s:h('@type.definition',   s:bcyan,   'NONE', 'bold')
call s:h('@type.qualifier',    s:magenta, 'NONE', 'italic')
call s:h('@storageclass',      s:bmagenta, 'NONE', 'italic')
call s:h('@attribute',         s:byellow, 'NONE', 'NONE')
call s:h('@attribute.builtin', s:byellow, 'NONE', 'italic')
call s:h('@label',             s:bcyan,   'NONE', 'NONE')
call s:h('@property',          s:white,   'NONE', 'NONE')
call s:h('@field',             s:white,   'NONE', 'NONE')
call s:h('@namespace',         s:yellow,  'NONE', 'NONE')
call s:h('@module',            s:yellow,  'NONE', 'italic')
call s:h('@module.builtin',    s:byellow, 'NONE', 'italic')

" Operators & Punctuation  (now coloured instead of grey)
call s:h('@operator',              s:bcyan,    'NONE', 'NONE')
call s:h('@punctuation.delimiter', s:cyan,     'NONE', 'NONE')
call s:h('@punctuation.bracket',   s:byellow,  'NONE', 'NONE')
call s:h('@punctuation.special',   s:bmagenta, 'NONE', 'NONE')

" Comments
call s:h('@comment',               s:comment,  'NONE', 'italic')
call s:h('@comment.documentation', s:comment,  'NONE', 'italic')
call s:h('@comment.error',         s:bred,     'NONE', 'bold')
call s:h('@comment.warning',       s:byellow,  'NONE', 'bold')
call s:h('@comment.todo',          s:bmagenta, 'NONE', 'bold,underline')
call s:h('@comment.note',          s:bcyan,    'NONE', 'bold')

" Markup / Prose  (body text stays white; everything else coloured)
call s:h('@markup.strong',        s:byellow,  'NONE', 'bold')
call s:h('@markup.italic',        s:bmagenta, 'NONE', 'italic')
call s:h('@markup.strikethrough', s:comment,  'NONE', 'strikethrough')
call s:h('@markup.underline',     s:bcyan,    'NONE', 'underline')
call s:h('@markup.heading',        s:bred,     'NONE', 'bold')
call s:h('@markup.heading.1',      s:bred,     'NONE', 'bold')
call s:h('@markup.heading.2',      s:byellow,  'NONE', 'bold')
call s:h('@markup.heading.3',      s:bgreen,   'NONE', 'bold')
call s:h('@markup.heading.4',      s:bcyan,    'NONE', 'bold')
call s:h('@markup.heading.5',      s:bblue,    'NONE', 'bold')
call s:h('@markup.heading.6',      s:bmagenta, 'NONE', 'bold')
call s:h('@markup.quote',          s:bgreen,   'NONE', 'italic')
call s:h('@markup.math',           s:byellow,  'NONE', 'NONE')
call s:h('@markup.link',           s:bblue,    'NONE', 'underline')
call s:h('@markup.link.label',     s:bcyan,    'NONE', 'NONE')
call s:h('@markup.link.url',       s:blue,     'NONE', 'underline')
call s:h('@markup.raw',            s:green,    '{{ colors.surface_container_low.default.hex }}', 'NONE')
call s:h('@markup.raw.block',      s:green,    '{{ colors.surface_container_low.default.hex }}', 'NONE')
call s:h('@markup.list',           s:bmagenta, 'NONE', 'NONE')
call s:h('@markup.list.checked',   s:bgreen,   'NONE', 'NONE')
call s:h('@markup.list.unchecked', s:bred,     'NONE', 'NONE')

" Tags (HTML / JSX / XML)
call s:h('@tag',           s:bred,    'NONE', 'NONE')
call s:h('@tag.builtin',   s:bmagenta, 'NONE', 'NONE')
call s:h('@tag.attribute', s:byellow, 'NONE', 'italic')
call s:h('@tag.delimiter', s:cyan,    'NONE', 'NONE')

" Diff captures
call s:h('@diff.plus',  s:bgreen,  'NONE', 'NONE')
call s:h('@diff.minus', s:bred,    'NONE', 'NONE')
call s:h('@diff.delta', s:byellow, 'NONE', 'NONE')

" --------------------------------------------------------------------------
" Native Neovim LSP Semantic Tokens (@lsp.type.*)
" --------------------------------------------------------------------------
call s:h('@lsp.type.class',         s:cyan,     'NONE', 'NONE')
call s:h('@lsp.type.comment',       s:comment,  'NONE', 'italic')
call s:h('@lsp.type.decorator',     s:byellow,  'NONE', 'italic')
call s:h('@lsp.type.enum',          s:bcyan,    'NONE', 'NONE')
call s:h('@lsp.type.enumMember',    s:byellow,  'NONE', 'NONE')
call s:h('@lsp.type.function',      s:blue,     'NONE', 'bold')
call s:h('@lsp.type.interface',     s:bcyan,    'NONE', 'italic')
call s:h('@lsp.type.keyword',       s:magenta,  'NONE', 'bold')
call s:h('@lsp.type.lifetime',      s:bred,     'NONE', 'italic')
call s:h('@lsp.type.macro',         s:bred,     'NONE', 'bold')
call s:h('@lsp.type.method',        s:blue,     'NONE', 'bold')
call s:h('@lsp.type.namespace',     s:yellow,   'NONE', 'italic')
call s:h('@lsp.type.number',        s:bred,     'NONE', 'NONE')
call s:h('@lsp.type.operator',      s:bcyan,    'NONE', 'NONE')
call s:h('@lsp.type.parameter',     s:bred,     'NONE', 'italic')
call s:h('@lsp.type.property',      s:white,    'NONE', 'NONE')
call s:h('@lsp.type.string',        s:green,    'NONE', 'NONE')
call s:h('@lsp.type.struct',        s:cyan,     'NONE', 'NONE')
call s:h('@lsp.type.type',          s:cyan,     'NONE', 'NONE')
call s:h('@lsp.type.typeParameter', s:bgreen,   'NONE', 'italic')
call s:h('@lsp.type.variable',      s:white,    'NONE', 'NONE')

" Semantic token modifiers
call s:h('@lsp.typemod.function.defaultLibrary', s:bcyan,    'NONE', 'italic')
call s:h('@lsp.typemod.variable.defaultLibrary', s:bmagenta, 'NONE', 'italic')
call s:h('@lsp.typemod.variable.readonly',       s:byellow,  'NONE', 'NONE')
call s:h('@lsp.typemod.variable.constant',       s:byellow,  'NONE', 'NONE')
call s:h('@lsp.typemod.variable.static',         s:byellow,  'NONE', 'italic')
call s:h('@lsp.typemod.type.defaultLibrary',     s:bcyan,    'NONE', 'italic')
call s:h('@lsp.typemod.method.defaultLibrary',   s:bcyan,    'NONE', 'italic')
call s:h('@lsp.typemod.keyword.async',           s:bcyan,    'NONE', 'bold')

" --------------------------------------------------------------------------
" Plugin Support
" --------------------------------------------------------------------------

" GitSigns
call s:h('GitSignsAdd',    s:bgreen,  'NONE', 'NONE')
call s:h('GitSignsChange', s:byellow, 'NONE', 'NONE')
call s:h('GitSignsDelete', s:bred,    'NONE', 'NONE')

" Telescope / FZF-Lua / Snacks Picker
hi TelescopeNormal          guibg={{ colors.surface_container.default.hex }} guifg={{ colors.on_surface.default.hex }}
call s:h('TelescopeBorder', s:bmagenta, '{{ colors.surface_container.default.hex }}', 'NONE')
hi TelescopePromptNormal    guibg={{ colors.surface_container_high.default.hex }} guifg={{ colors.on_surface.default.hex }}
hi TelescopePromptBorder    guibg={{ colors.surface_container_high.default.hex }} guifg={{ colors.surface_container_high.default.hex }}
hi TelescopePromptTitle     guibg={{ colors.primary.default.hex }} guifg={{ colors.on_primary.default.hex }} gui=bold
hi TelescopeSelection       guibg={{ colors.surface_container_highest.default.hex }} guifg={{ colors.on_surface.default.hex }}
call s:h('TelescopeSelectionCaret', s:bmagenta, '{{ colors.surface_container_highest.default.hex }}', 'NONE')
call s:h('TelescopeMatching',       s:byellow,  'NONE', 'bold')
call s:h('TelescopeResultsTitle',   s:bcyan,    '{{ colors.surface_container.default.hex }}', 'bold')
call s:h('TelescopePreviewTitle',   s:bgreen,   '{{ colors.surface_container.default.hex }}', 'bold')

" Completion (nvim-cmp & blink.cmp)  -- one hue per item kind
call s:h('CmpItemAbbrDeprecated', s:comment,  'NONE', 'strikethrough')
call s:h('CmpItemAbbrMatch',      s:byellow,  'NONE', 'bold')
call s:h('CmpItemAbbrMatchFuzzy', s:byellow,  'NONE', 'bold')
call s:h('CmpItemKind',           s:cyan,     'NONE', 'NONE')
call s:h('CmpItemKindFunction',   s:bblue,    'NONE', 'NONE')
call s:h('CmpItemKindMethod',     s:bblue,    'NONE', 'NONE')
call s:h('CmpItemKindVariable',   s:white,    'NONE', 'NONE')
call s:h('CmpItemKindField',      s:white,    'NONE', 'NONE')
call s:h('CmpItemKindKeyword',    s:bmagenta, 'NONE', 'NONE')
call s:h('CmpItemKindSnippet',    s:bgreen,   'NONE', 'NONE')
call s:h('CmpItemKindClass',      s:cyan,     'NONE', 'NONE')
call s:h('CmpItemKindModule',     s:yellow,   'NONE', 'NONE')
call s:h('CmpItemKindConstant',   s:byellow,  'NONE', 'NONE')
call s:h('CmpItemKindText',       s:green,    'NONE', 'NONE')
call s:h('CmpItemMenu',           s:comment,  'NONE', 'NONE')

call s:h('BlinkCmpItemAbbrDeprecated', s:comment, 'NONE', 'strikethrough')
call s:h('BlinkCmpItemAbbrMatch',      s:byellow, 'NONE', 'bold')
call s:h('BlinkCmpItemKind',           s:cyan,    'NONE', 'NONE')
call s:h('BlinkCmpKindFunction',       s:bblue,   'NONE', 'NONE')
call s:h('BlinkCmpKindMethod',         s:bblue,   'NONE', 'NONE')
call s:h('BlinkCmpKindKeyword',        s:bmagenta, 'NONE', 'NONE')
call s:h('BlinkCmpKindSnippet',        s:bgreen,  'NONE', 'NONE')
call s:h('BlinkCmpKindConstant',       s:byellow, 'NONE', 'NONE')
call s:h('BlinkCmpKindText',           s:green,   'NONE', 'NONE')

" Rainbow delimiters
call s:h('RainbowDelimiterRed',    s:bred,     'NONE', 'NONE')
call s:h('RainbowDelimiterYellow', s:byellow,  'NONE', 'NONE')
call s:h('RainbowDelimiterBlue',   s:bblue,    'NONE', 'NONE')
call s:h('RainbowDelimiterOrange', s:yellow,   'NONE', 'NONE')
call s:h('RainbowDelimiterGreen',  s:bgreen,   'NONE', 'NONE')
call s:h('RainbowDelimiterViolet', s:bmagenta, 'NONE', 'NONE')
call s:h('RainbowDelimiterCyan',   s:bcyan,    'NONE', 'NONE')

" Indent Blankline (ibl)
hi IblIndent guifg={{ colors.surface_container_high.default.hex }} gui=nocombine
call s:h('IblScope', s:bmagenta, 'NONE', 'nocombine')

endif
