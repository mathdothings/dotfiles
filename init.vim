" nnoremap gl g;
call plug#begin()
"""""""""""""""""""" Themes
Plug 'morhetz/gruvbox'
let g:gruvbox_sign_column='dark0'
" let g:gruvbox_transparent_bg=1
Plug 'joshdick/onedark.vim'

"""""""""""""""""""" Lualine and dev-icons
Plug 'nvim-lualine/lualine.nvim'          " Lualine - Beautiful modeline with icons
Plug 'kyazdani42/nvim-web-devicons'       " Beautiful dev icons in modeline bar

"""""""""""""""""""" LSP Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

"""""""""""""""""""" For vsnip users - snippet Plugins
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

"""""""""""""""""""" Treesitter for better syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"""""""""""""""""""" Utilities plugins
Plug 'alvan/vim-closetag'                 " HTML Autotag - write both inicial and closing tag
Plug 'mattn/emmet-vim'                    " Emmet for fast write HTML-like code

"""""""""""""""""""" Prettier for smart code syntax highlight
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'git@github.com:Yggdroot/indentLine.git'
Plug 'git@github.com:tpope/vim-commentary.git'
Plug 'git@github.com:tpope/vim-surround.git'
Plug 'git@github.com:windwp/nvim-autopairs.git'
Plug 'git@github.com:xiyaowong/nvim-transparent.git'
Plug 'sheerun/vim-polyglot'
Plug 'p00f/nvim-ts-rainbow'
Plug 'lewis6991/gitsigns.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()

" Trim all whitespaces
autocmd FileType js,html,css,vim autocmd BufWritePre <buffer> %s/\s\+$//e
""""""""""""""""""""" Ident/Space Settings
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set indentexpr=
set nocindent
set smartindent     " on

""""""""""""""""""""" Search Settings
set incsearch               " Incrementally highlight characters as you type
set ignorecase              " Ignore capital letters during search
set smartcase               " Allow you to search for specify capital letters if needed"
set showmatch               " Show matching words during a search
set nohlsearch              " Uses highlight when performing a search

""""""""""""""""""""" Wrap Settings
set wrap
set linebreak
set textwidth=0
set wrapmargin=0

""""""""""""""""""""" Basic Settings
filetype plugin on          " Enable plugins for specific filetype
syntax on                   " Enable syntax highlight
syntax enable               " Enable syntax highlight for some plugings
set cursorline              " Enable highlight for current line
set cursorlineopt=both  " Enable highlight just for current line number
set number                  " Show line numbers left side
set relativenumber          " Show the relative line number
" set virtualedit +=onemore " To go to end of line properly
set showtabline=0           " Hide top 'filename' bar
set noruler                 " Hide line/column number in the bottom panel
set noshowmode              " Hide mode bar display in the bottom panel
set guicursor=i:block       " Keep block cursor on insert mode
" set showmatch matchtime=3   " Jumps to mactching bracket
" set scrolloff=15            " Minimum number of lines to keep above and below the cursor
" set colorcolumn=80        " Draws a line at the given line to keep aware of the line size
set signcolumn=yes          " Add a column on the left. Useful for linting
set cmdheight=1             " Give more space for displaying messages
set updatetime=1000         " Time in miliseconds to consider the changes
set encoding=utf-8          " The encoding should be utf-8 to activate the font icons
set nobackup                " No backup files
set noswapfile              " Disable creating swapfile
set nowritebackup           " No backup files
set splitright              " Create the vertical splits to the right
set splitbelow              " Create the horizontal splits below
set formatoptions-=cro      " No commets on new line

""""""""""""""""""""" Mappings
" inoremap jj <Esc>
" nnoremap j jzz
" nnoremap k kzz
" nnoremap G Gzz
nnoremap <space> <Esc>:
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
noremap <C-up> <C-w>+
noremap <C-down> <C-w>-
noremap <C-left> <C-w>>
noremap <C-right> <C-w><
nnoremap <M-j> <Esc>:m+1<CR>
nnoremap <M-k> <Esc>:m-2<CR>
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
let mapleader = "\\"        " <leader> key for commands
let maplocalleader = "\\"   " <localleader>

""""""""""""""""""""" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif

set background=dark
colorscheme gruvbox

" Transparent background
" highlight Normal guibg=NONE ctermbg=NONE
" highlight LineNr guibg=NONE ctermbg=NONE
" highlight SignColumn guibg=NONE ctermbg=NONE
" highlight EndOfBuffer guibg=NONE ctermbg=NONE
" highlight CursorLineNR guibg=NONE ctermbg=NONE

" Transparent Completation
" hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" hi PmenuSbar ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" hi PmenuSel ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" hi PmenuThumb ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

""""""""""""""""""""" Prettier Settings
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#quickfix_enabled = 0
let g:prettier#quickfix_auto_focus = 0
let g:prettier#config#print_width = 80

""""""""""""""""""""" LSP Settings
lua << EOF
require('lspconfig').tsserver.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.marksman.setup{}
require("nvim-lsp-installer").setup{}
require('lualine').setup{}
require'lspconfig'.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      -- see available options in stylelint-lsp documentation
      autoFixOnSave = true,
      autoFixOnFormat = true,
      validateOnSave = true
    }
  }
}
EOF
lua require'colorizer'.setup()

lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF
"""""""""""""""""""" Change LSP warning/hint/error symbols in signcolumn
lua << EOF
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '⦸ ', -- Could be '●', '▎', 'x'
  }
})
EOF

"""""""""""""""""""" Setup Completation with nvim-cmp
set completeopt=menu,menuone,noselect

lua << EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

-- Maping <CR> for autocomplete --------------
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
----------------------------------------------

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<M-b>'] = cmp.mapping.scroll_docs(-4),
      ['<M-n>'] = cmp.mapping.scroll_docs(4),
      ['<M-q>'] = cmp.mapping.complete(),
      ['<M-f>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<M-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<M-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })
  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local cmp = require('cmp')
cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind]) -- This concatonates the icons
      return vim_item
    end
  },
}
EOF

"""""""""""""""""""" Treesitter Settings
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

""""""""" Setup Completation for CSS
lua << EOF
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
EOF

"""""""""" Setup Completion for HTML
lua << EOF
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}
EOF

"""""""""" Setup HTML Autotag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

"""""""""""""" Setup Colorizer
lua << EOF
require 'colorizer'.setup {
  '*';
}
EOF

"""""""""""""""" Setup Emmet snippet for responsiveness
let g:user_emmet_settings = {
\  'variables': {'lang': 'en'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}

" Keep cursor always centered
:autocmd CursorMoved,CursorMovedI * call CentreCursor()
function! CentreCursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction

" Identguide lines
let g:indentLine_char = '▏'

" Autopairs with treesitter and nvim-autopairs
lua << EOF
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')

-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})
EOF


lua << EOF
require("transparent").setup({
  enable = false,
  extra_groups = {
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
    "Pmenu",
    "PmenuSbar",
    "PmenuThumb",
    "Normal",
    "LineNr",
    "SignColumn",
    "EndOfBuffer",
    "CursorLineNR",
  },
  exclude = {},
})
EOF

lua << EOF
require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = false,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
EOF

lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'solid',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
EOF

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'light'
