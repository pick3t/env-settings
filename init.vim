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

Plug 'MunifTanjim/nui.nvim'
Plug 'kawre/leetcode.nvim'
call plug#end()

lua<<EOF
require'mason'.setup {}
require'which-key'.setup {}
require'nvim-autopairs'.setup {}

package.loaded['coc-example-config'] = nil
require'coc-example-config'

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

local custom_folds = [[
     [
         (function_definition)
       ] @fold
   ]]
vim.treesitter.query.set("cpp", "folds", custom_folds)

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

require'leetcode'.setup {
    ---@type string
    arg = "leetcode.nvim",

    ---@type lc.lang
    lang = "cpp",

    cn = { -- leetcode.cn
        enabled = true, ---@type boolean
        translator = true, ---@type boolean
        translate_problems = true, ---@type boolean
    },

    ---@type lc.storage
    storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
    },

    ---@type table<string, boolean>
    plugins = {
        non_standalone = false,
    },

    ---@type boolean
    logging = true,

    injector = {}, ---@type table<lc.lang, lc.inject>

    cache = {
        update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
    },

    console = {
        open_on_runcode = true, ---@type boolean

        dir = "row", ---@type lc.direction

        size = { ---@type lc.size
            width = "90%",
            height = "75%",
        },

        result = {
            size = "60%", ---@type lc.size
        },

        testcase = {
            virt_text = true, ---@type boolean

            size = "40%", ---@type lc.size
        },
    },

    description = {
        position = "left", ---@type lc.position

        width = "40%", ---@type lc.size

        show_stats = true, ---@type boolean
    },

    ---@type lc.picker
    picker = { provider = nil },

    hooks = {
        ---@type fun()[]
        ["enter"] = {},

        ---@type fun(question: lc.ui.Question)[]
        ["question_enter"] = {},

        ---@type fun()[]
        ["leave"] = {},
    },

    keys = {
        toggle = { "q" }, ---@type string|string[]
        confirm = { "<CR>" }, ---@type string|string[]

        reset_testcases = "r", ---@type string
        use_testcase = "U", ---@type string
        focus_testcases = "H", ---@type string
        focus_result = "L", ---@type string
    },

    ---@type lc.highlights
    theme = {},

    ---@type boolean
    image_support = false,
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

" make cursorline underline
" hi clear CursorLine
" hi CursorLine gui=underline cterm=underline
set cursorline

lua <<EOF
-- override nvim-treesitter captures' settings
vim.api.nvim_set_hl(0, "@keyword.cpp", { link = "RedItalic" })
vim.api.nvim_set_hl(0, "@keyword.type.cpp", { link = "RedItalic" })
vim.api.nvim_set_hl(0, "@keyword.modifier.cpp", { link = "RedItalic" })
vim.api.nvim_set_hl(0, "@keyword.conditional.cpp", { link = "RedItalic" })
vim.api.nvim_set_hl(0, "@module.cpp", { link = "Yellow" })
vim.api.nvim_set_hl(0, "@type.cpp", { link = "Yellow" })
vim.api.nvim_set_hl(0, "@type.builtin.cpp", { link = "Yellow" })
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

" Copy matches of the last search to a register (default is the clipboard).
" Accepts a range (default is whole file).
" 'CopyMatches'   copy matches to clipboard (each match has \n added).
" 'CopyMatches x' copy matches to register x (clears register first).
" 'CopyMatches X' append matches to register x.
" We skip empty hits to ensure patterns using '\ze' don't loop forever.
command! -range=% -register CopyMatches call s:CopyMatches(<line1>, <line2>, '<reg>')
function! s:CopyMatches(line1, line2, reg)
  let hits = []
  for line in range(a:line1, a:line2)
    let txt = getline(line)
    let idx = match(txt, @/)
    while idx >= 0
      let end = matchend(txt, @/, idx)
      if end > idx
	call add(hits, strpart(txt, idx, end-idx))
      else
	let end += 1
      endif
      if @/[0] == '^'
        break  " to avoid false hits
      endif
      let idx = match(txt, @/, end)
    endwhile
  endfor
  if len(hits) > 0
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
  else
    echo 'No hits'
  endif
endfunction
