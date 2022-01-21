call plug#begin(stdpath('data'))

" Tim Pope Plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-dispatch'

" Nvim LSP
Plug 'neovim/nvim-lsp'

" Nvim LSPConfig
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer', {'branch': 'main'}
Plug 'm-pilia/vim-ccls'

" Better Syntax Highlighting ( lsp-contextual )
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Fancy Start Screen
Plug 'mhinz/vim-startify'

" Lualine
" Plug 'vim-airline/vim-airline'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer',  {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/cmp-cmdline', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets', {'branch': 'main'}

" Theme
Plug 'laggardkernel/vim-one'
Plug 'qpkorr/vim-bufkill'

" Clang Formatter
Plug 'rhysd/vim-clang-format'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do' : ':TSUpdate'}

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end() 
