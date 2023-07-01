call plug#begin()
Plug 'folke/which-key.nvim'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig' 
Plug 'williamboman/mason.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
" in order to install coc.nvim, you should install yarn and node.js fisrt
" but ubuntu source list could be outdated, so install with following
" instructions to get latest version of these supports
" curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
" sudo apt-get install -y nodejs
" above installs 19.x version node.js
"
" sudo apt remove cmdtest
" sudo apt remove yarn
" curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
" echo `deb https://dl.yarnpkg.com/debian/ stable main` | sudo tee /etc/apt/sources.list.d/yarn.list
" sudo apt-get update
" sudo apt-get install yarn -y
" above installs latest yarn
" then run yarn install in $(find ~ -type d coc.nvim)

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
call plug#end()

lua<<EOF

require'nvim-tree'.setup {}
require'lspconfig'.ccls.setup{}
require'mason'.setup{}
require'which-key'.setup{}
require'lualine'.setup{}
require'coc'
EOF

" Enable line numbers
set relativenumber

set clipboard+=unnamedplus

" encoding to display Chinese
set encoding=utf-8
set fileencodings=utf-8,gb2312

filetype plugin indent on

set shiftwidth=4
set expandtab
set colorcolumn=120

" autofold
let g:xml_syntax_folding=1
autocmd Filetype xml,json setlocal foldmethod=syntax

" Theme
autocmd vimenter * ++nested colorscheme gruvbox

" test
" command! Scratch lua require'tools'.makeScratch()

" NvimTree
nnoremap <leader>ntf :NvimTreeFindFile<CR>

" fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" Ripgrep in fzf
nnoremap <leader><leader>r :RgRaw 

" fugitive
autocmd User FugitiveIndex nmap <buffer>dt :Gtabedit <Plug><cfile><Bar>Gdiffsplit<CR>
autocmd DirChanged * call FugitiveGitDir()

" General
nnoremap <C-J> :bprev<CR>
nnoremap <C-K> :bnext<CR>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <A-c> :let @+ = expand('%')<CR>

:command NvimConfig :e ~/.config/nvim/init.vim
