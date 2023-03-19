call plug#begin()
Plug 'folke/which-key.nvim'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig' 
Plug 'williamboman/mason.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

lua<<EOF

require'nvim-tree'.setup {}
require'lspconfig'.ccls.setup{}
require'mason'.setup{}
require'which-key'.setup{}

EOF

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Enable line numbers
set number

" Move between buffers
nnoremap <C-J> :bprev<CR>
nnoremap <C-K> :bnext<CR>

set clipboard+=unnamedplus
