let g:polyglot_disabled = ['markdown']  " Necessary for vim-polyglot
call plug#begin('~/.config/nvim/plugins')
Plug 'neovim/nvim-lspconfig'        " Enable LSP in neovim
Plug 'hrsh7th/cmp-nvim-lsp'         " Enable LSP Completion
Plug 'hrsh7th/cmp-buffer'              " Needed for Completion
Plug 'hrsh7th/nvim-cmp'                " Needed for Completion
Plug 'hrsh7th/cmp-vsnip'               " Snippets for Completion
Plug 'hrsh7th/vim-vsnip'               " Snippets for Completion
Plug 'onsails/lspkind-nvim'         " Show symbols while completing stuff
Plug 'mhartington/oceanic-next'     " OceanicNext Theme for NeoVim
Plug 'hoob3rt/lualine.nvim'         " Beaufiful Status Line
Plug 'ryanoasis/vim-devicons'       " Beaufiful Status Icons
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Tree Sitter for better syntax highlight
Plug 'mattn/emmet-vim'              " Emmet for HTML/CSS
Plug 'sheerun/vim-polyglot'         " For better syntax highlight
call plug#end()

" Basic Settings
syntax on
set number
set showtabline=0
set expandtab
set tabstop=2
set nosmartindent
set noautoindent
set ruler
set shiftwidth=2
set colorcolumn=80 
set noshowmode
set nocompatible
" Keep block cursor on Insert mode
set guicursor=i:block

" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme gruvbox
    " Transparent background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" Enable LSP for Languages

lua << EOF
require'lspconfig'.tsserver.setup{}
require'lspconfig'.stylelint_lsp.setup{}
require'lspconfig'.cssls.setup{}
EOF

" Enable Completation and Linting

" Setup Completion

set completeopt=menu,menuone,noselect
set lazyredraw

lua << EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<S-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<S-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<S-f>'] = cmp.mapping.close(),
      ['<S-l>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    }
  })

    -- Setup lspconfig.
  require('lspconfig').tsserver.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }

	-- Setup Completion for CSS
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

	-- Setup Completion for HTML
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

	-- Setup Symbols*
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  }
}
    -- Setup lualine
    require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

" Enable nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Emmet Snippet for Responsiveness
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
