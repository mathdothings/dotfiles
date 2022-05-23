call plug#begin()
"""""""""""""""""""" Themes
Plug 'Mofiqul/dracula.nvim'               " dracula
Plug 'ayu-theme/ayu-vim'                  " ayu 
Plug 'morhetz/gruvbox'                    " gruvbox 
Plug 'navarasu/onedark.nvim'              " onedark 
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
Plug 'alvan/vim-closetag'                 " HTML Autotag - write both inicial and closing tag
Plug 'jiangmiao/auto-pairs'               " Auto pairs for brackets
Plug 'mattn/emmet-vim'                    " Emmet for fast write HTML-like code

"""""""""""""""""""" Prettier for smart code syntax highlight
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'gko/vim-coloresque'                 " Coloresque for colors preview
Plug 'matze/vim-move'                     " vim-move to move lines/blocks easily
call plug#end()

""""""""""""""""""""  Basic Settings
syntax on                   " Enable syntax highlight
syntax enable               " Enable syntax highlight for some plugings
"set cursorline cursorcolumn " Highlight current line/column
                            " Show line numbers left side
set number
set virtualedit +=onemore   " To go to end of line properly
set showtabline=0           " Hide top 'filename' bar

"""""""""""""""""""" Ident/Space Settings
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set indentexpr=
set nocindent
set nosmartindent
set noruler                 " Hide line/column number in the bottom panel
set noshowmode              " Hide mode bar display in the bottom panel
set guicursor=i:block       " Keep block cursor on insert mode
set showmatch matchtime=3   " Jumps to mactching bracket
set scrolloff=10            " Minimum number of lines to keep above and below the cursor     
set colorcolumn=80          " Draws a line at the given line to keep aware of the line size
set signcolumn=yes          " Add a column on the left. Useful for linting
set cmdheight=1             " Give more space for displaying messages
set updatetime=100          " Time in miliseconds to consider the changes
set encoding=utf-8          " The encoding should be utf-8 to activate the font icons
set nobackup                " No backup files
set noswapfile              " Disable creating swapfile
set nowritebackup           " No backup files
set splitright              " Create the vertical splits to the right
set splitbelow              " Create the horizontal splits below

"""""""""""""""""""" Mappings
let mapleader = "\\"        " <leader> key for commands
let maplocalleader = "\\"   " <localleader>
" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif
" let ayucolor="dark"   " for dark version of theme
let g:onedark_config = {
    \ 'style': 'cool',
\}
colorscheme onedark
" Transparent background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
"""""" Prettier settings
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#quickfix_enabled = 0
let g:prettier#quickfix_auto_focus = 0
"""""""""""""""""""" LSP Settings
lua << EOF
require('lspconfig').tsserver.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.html.setup{}
require("nvim-lsp-installer").setup{}
require('lualine').setup{}
EOF

""""""""" Setup Completation with nvim-cmp
set completeopt=menu,menuone,noselect

lua << EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

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
      ['<M-l>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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

"""""""""" Setup Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

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
