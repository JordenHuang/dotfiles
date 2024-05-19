" Options
set nu
set relativenumber

set expandtab
set tabstop=4
set smarttab
set softtabstop=4
set shiftwidth=4
set autoindent

set cursorline
set listchars=tab:>\ ,trail:·,nbsp:+
set list

set nowrap
set scrolloff=3

set mouse=a

set splitbelow
set splitright

set encoding=utf-8
set clipboard=unnamedplus

set virtualedit=block

set completeopt=menu,menuone,noselect

set ignorecase

set termguicolors

set guicursor=n-v-c-i-sm:block,i-ci-ve:blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20

set hlsearch
set incsearch

set wildmenu

syntax on

colorscheme desert

" Keybindings
let mapleader = ","

:imap kj <Esc>

:nmap <leader>nh :noh<CR>
:nmap <C-j> <C-w>j
:nmap <C-k> <C-w>k
:nmap <C-h> <C-w>h
:nmap <C-l> <C-w>l

:nmap <C-s> :w<CR>


" -- Move text up and down (<A> means Alt key) vim.keymap.set("n", "<A-j>", ":m +1<CR>==", opts("Move text up"))
" vim.keymap.set("n", "<A-k>", ":m -2<CR>==", opts("Move text down"))
" 
" -- Shift visual selected lines up and down
" vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
" vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")




" Exit Insert Mode in terminal
:tnoremap <Esc> <C-\><C-n>
:tnoremap kj <C-\><C-n>

