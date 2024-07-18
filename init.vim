call plug#begin()
Plug 'folke/which-key.nvim'

Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

Plug 'neovim/nvim-lspconfig' 
Plug 'williamboman/mason.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'easymotion/vim-easymotion'
Plug 'jesseleite/vim-agriculture'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'svermeulen/vim-cutlass'
Plug 'yorickpeterse/nvim-window'

" theme
Plug 'sainnhe/gruvbox-material'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
call plug#end()

lua<<EOF
require'mason'.setup {}
require'which-key'.setup {}
require'nvim-autopairs'.setup {}

package.loaded['coc-init'] = nil
require'coc-init'

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    parsers = {
        enable = true,
    },
    fold = {
        enable = true,
    }
}

require'lualine'.setup { options = { theme = 'gruvbox-material' } }
require'nvim-web-devicons'
require'nvim-tree'.setup {}
require'nvim-window'.setup {
  normal_hl = 'BlackOnLightYellow',
  hint_hl = 'Bold',
  border = 'none'
}

require'telescope'.setup {
    pickers = {
    buffers = {
        mappings = {
            n = {
                ["dd"] = "delete_buffer",
            }
        }
    }
    }
}

EOF

" set auto folding for xml Files
let g:xml_syntax_folding=1
au FileType xml,json setlocal foldmethod=syntax
au FileType c,cpp setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()

" encoding to correctly display Chinese
set encoding=utf-8
set fileencodings=utf-8,gb2312,iso-8859-1,enc-cn

filetype plugin indent on
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set colorcolumn=120

" KeyMaps
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" nvim-tree
nmap <leader>ntt :NvimTreeFindFile!<cr>
" move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" copy file name
nnoremap <A-c> :let @+ = expand('%:t')<CR>
vnoremap <A-f> y:RgRaw -w <C-r>"<CR>
" nvim-window
map <silent> , :lua require('nvim-window').pick()<CR>
" telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>th <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>fg <cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>
vnoremap <leader>fv <cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<cr>

:command Config :e ~/.config/nvim/init.vim

" fugitive
au User FugitiveIndex nmap <buffer> dt :Gtabedit <Plug><cfile><Bar>Gdiffsplit<CR>
au User FugitiveIndex nmap <buffer> dt! :Gtabedit <Plug><cfile><Bar>Gvdiffsplit!<CR>
autocmd DirChanged * call FugitiveGitDir()

" cutlass
nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

nnoremap <g-t-c> :tabc<CR>

nnoremap g* :let @/ = '\<' . expand('<cword>') . '\>'<CR>

function! GetRelativePath()
    let current_file = expand('%:p')
    let current_dir = getcwd()
    let relative_path = substitute(current_file, current_dir . '/', '', '')
    let @+ = relative_path
endfunction

nnoremap <leader><A-c> :call GetRelativePath()<CR>

" Enable line numbers
set relativenumber
set number

set clipboard+=unnamedplus

" Theme
set termguicolors
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_dim_inactive_windows = 1
let g:gruvbox_material_disable_italic_comment = 1
set background=dark
colorscheme gruvbox-material

lua <<EOF
-- override nvim-treesitter captures' settings
vim.api.nvim_set_hl(0, "@keyword.cpp", { link = "RedItalic" })
vim.api.nvim_set_hl(0, "@keyword.type.cpp", { link = "RedItalic" })
vim.api.nvim_set_hl(0, "@keyword.modifier.cpp", { link = "RedItalic" })
vim.api.nvim_set_hl(0, "@keyword.conditional.cpp", { link = "RedItalic" })
vim.api.nvim_set_hl(0, "@module.cpp", { link = "Yellow" })
vim.api.nvim_set_hl(0, "@type.cpp", { link = "Yellow" })
vim.api.nvim_set_hl(0, "@type.builtin.cpp", { link = "Yellow" })

vim.api.nvim_set_hl(0, "@ColorColumn", { link = "Yellow" })
EOF

function! Collect(cmd)
    redir => cmd_output
    silent execute a:cmd
    redir END
    new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, split(cmd_output, '\n'))
    setlocal nomodifiable
endfunction
