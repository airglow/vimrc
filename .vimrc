set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"VUNDLE-----------------------------------------------------------------------
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
"Bundle 'Rip-Rip/clang_complete.git'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'altercation/vim-colors-solarized.git'
Bundle 'SirVer/ultisnips.git'
"Bundle 'msanders/snipmate.vim'
"Bundle 'Syntastic'

"Bundle 'exclipy/clang_complete.git'
" vim-scripts repos
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
"Bundle 'vimoutliner/vimoutliner.git'
"Bundle 'vimez/vim-showmarks.git'
Bundle 'sjl/gundo.vim.git'
Bundle 'a.vim'
Bundle 'scrooloose/syntastic'
Bundle 'nelstrom/vim-markdown-folding'
" ...

filetype plugin indent on     " required!
"----------------------------------------------------------------------------

"autocmd VimEnter * NERDTree
"Color Setting---------------------------------------------------------------
if has('gui_running')
	set background=light
else
	set background=dark
endif
colorscheme solarized
let g:solarized_termcolors=256
"----------------------------------------------------------------------------

" Configs--------------------------------------------------------------------
set incsearch
set number
set hlsearch
set ic
set scs
set noswapfile
set clipboard=unnamed
set foldmethod=syntax
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd VimEnter * wincmd p
filetype plugin indent on
set tabstop=4
set shiftwidth=4    " numbers of spaces to (auto)indent
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set winaltkeys=no " turns of the Alt key bindings to the gui menu

let g:Powerline_symbols = 'fancy'

"let g:syntastic_cpp_checkers=['gcc']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
"set smarttab
"set shiftwidth=2
"set autoindent
"set expandtab

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:snips_author = 'Raphael Memmesheimer'

"----------------------------------------------------------------------------

" remapping to function keys ------------------------------------------------
map <F2> :NERDTreeToggle <CR>
map <F3> :FufFile <CR>
map <F4> :FufBuffer <CR>
nnoremap <F5> :GundoToggle<CR>
map <F11> :make -j <CR>
"----------------------------------------------------------------------------

" remap arrow keys to nop ---------------------------------------------------
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
"----------------------------------------------------------------------------

" Move entire line/block up and down ----------------------------------------
nnoremap <C-S-DOWN> :m+<CR>==
nnoremap <C-S-UP> :m-2<CR>==
inoremap <C-S-DOWN> <Esc>:m+<CR>==gi
inoremap <C-S-UP> <Esc>:m-2<CR>==gi
vnoremap <C-S-DOWN> :m'>+<CR>gv=gv
vnoremap <C-S-UP> :m-2<CR>gv=gv
"----------------------------------------------------------------------------
"map <C-T> <Esc>:tabnew<CR>

" Invisible Characters ------------------------------------------------------
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
"----------------------------------------------------------------------------

"Underline function ---------------------------------------------------------
function! s:Underline(chars)
	let chars = empty(a:chars) ? '-' : a:chars
	let nr_columns = virtcol('$') - 1
	let uline = repeat(chars, (nr_columns / len(chars)) + 1)
	put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)
"----------------------------------------------------------------------------

"line after 80 columns ------------------------------------------------------
if exists('+colorcolumn')
	set colorcolumn=80
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
"----------------------------------------------------------------------------


cmap w!! %!sudo tee > /dev/null %

"http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! NeatFoldText() "{{{2
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = '·'
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let length = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g'))
  return foldtextstart . repeat(foldchar, winwidth(0)-length) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2


