" Specify a directory for plugins
call plug#begin('$vim/vimfiles/plugged')
	" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
	"Plug 'junegunn/vim-easy-align'

	Plug 'tpope/vim-vinegar'

	" file navigation
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin'
	" for finding defitinitionshammer_and_pick and references/usages
	" Plug 'pechorin/any-jump.vim'

	Plug 'vim-airline/vim-airline'

	" fuzzy file finder
	Plug 'kien/ctrlp.vim'

	Plug 'joshukraine/yankmatches'

	Plug 'atweiden/vim-dragvisuals'

	Plug 'gavocanov/foldsearches.vim'

	" coc.nvim
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" git tool
	Plug 'tpope/vim-fugitive'

	" Visual content can move
	Plug 'atweiden/vim-dragvisuals'

	" Vim global plugin for persistent Visual seletions
	Plug 'galli-a/persistentvisuals'

	" syntax check/linter
	Plug 'vim-syntastic/syntastic'

	" surround
	Plug 'tpope/vim-surround'

	" vim-commentary
	Plug 'tpope/vim-commentary'

	" emmet
	Plug 'mattn/emmet-vim'

	" easymotion
	Plug 'easymotion/vim-easymotion'

	" code debug
	Plug 'puremourning/vimspector'

" Initialize plugin system
call plug#end()

"========================  Custom Mappings ==========================="

" ########################## START ###########################
" #               coc.nvim config more plugins               #
" ############################################################
let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-gitignore',
	\ 'coc-prettier',
	\ 'coc-snippets',
	\ 'coc-syntax',
	\ 'coc-lists',
	\ 'coc-css',
	\ 'coc-vimlsp',
	\ 'coc-explorer',
	\ 'coc-translator',
	\ 'coc-yank',
	\ 'coc-html']
" delays and poor user experience.
set updatetime=100
" Don't pass message to |ins-completion-menu|.
set shortmess+=c
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <leader>c to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <leader>c coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K[ey] to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" coc-explorer config
nmap <space>e :CocCommand explorer<CR>
" nmap <leader>tt :CocComand explorer<CR>

" coc-vimslp config
let g:markdown_fenced_languages=[
	\ 'vim',
	\ 'help'
	\]

" ######################## END ###############################
" #               coc.nvim config more plugins               #
" ############################################################

" dragVisual config
vmap  <expr>  <S-LEFT>   DVB_Drag('left')
vmap  <expr>  <S-RIGHT>  DVB_Drag('right')
vmap  <expr>  <S-DOWN>   DVB_Drag('down')
vmap  <expr>  <S-UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Persistence visual selection
vmap <expr> > ShiftAndKeepVisualSelection(">", "V")
vmap <expr> < ShiftAndKeepVisualSelection("<", "V")

function! ShiftAndKeepVisualSelection(cmd, mode)
	set nosmartindent
	if mode() =~ '[Vv]'
		return a:cmd . ":set smartindent\<CR>gv"
	else
		return a:cmd . ":set smartindent\<CR>"
	endif
endfunction

" Toggle on and off...
nmap <silent> <expr>  zz  FS_ToggleFoldAroundSearch({'context':1})



" open file where you leave the file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let mapleader="\<space>"

nnoremap <leader>n :NERDTreeToggle<CR>
"let g:NERDTreeIndicatorMapCustom = {
"    \ "Modified"  : "✹",
"    \ "Staged"    : "✚",
"    \ "Untracked" : "✭",
"    \ "Renamed"   : "➜",
"    \ "Unmerged"  : "═",
"    \ "Deleted"   : "✖",
"    \ "Dirty"     : "✗",
"    \ "Clean"     : "✔︎",
"    \ "Unknown"   : "?"
"    \ }

" yankmatches config
nmap <silent> dm  :     call ForAllMatches('delete', {})<CR>
nmap <silent> DM  :     call ForAllMatches('delete', {'inverse':1})<CR>
nmap <silent> YM  :     call ForAllMatches('yank',   {})<CR>
nmap <silent> YI  :     call ForAllMatches('yank',   {'inverse':1})<CR>
vmap <silent> dm  :<C-U>call ForAllMatches('delete', {'visual':1})<CR>
vmap <silent> DM  :<C-U>call ForAllMatches('delete', {'visual':1, 'inverse':1})<CR>
vmap <silent> YM  :<C-U>call ForAllMatches('yank',   {'visual':1})<CR>
vmap <silent> YI  :<C-U>call ForAllMatches('yank',   {'visual':1, 'inverse':1})<CR>

" Dragging Visual
vmap <expr> <LEFT>	DVB_Drag('left')
vmap <expr> <RIGHT>	DVB_Drag('right')
vmap <expr> <DOWN>	DVB_Drag('down')
vmap <expr> <UP>	DVB_Drag('up')
vmap <expr> D		DVB_Duplicate()


" ===================== START MAP Config ====================
" =                     switch window                       =
" ===========================================================
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" ====================== split config =======================
nmap s <nop>
nmap sl :set splitright<CR>:vsplit<CR>
nmap sh :set nosplitright<CR>:vsplit<CR>
nmap sj :set splitbelow<CR>:split<CR>
nmap sk :set nosplitbelow<CR>:split<CR>

"======================Split Management=====================
set splitbelow
set splitright

" ====================== exchange tab ======================
nmap sV <C-W>t<C-w>H
nmap sH <C-W>t<C-w>K
nmap <UP> :resize -5<CR>
nmap <DOWN> :resize +5<CR>
nmap <LEFT> :vertical resize +5<CR>
nmap <RIGHT> :vertical resize -5<CR>

" ===============get rid of postsearch's highlight ==========
nmap <silent> <BS> :nohlsearch<CR>

" ==============Command line mode cursor movement ===========
cnoremap <C-P> <UP>
cnoremap <C-N> <DOWN>
cnoremap <C-H> <LEFT>
cnoremap <C-L> <RIGHT>

nnoremap / /\v
nnoremap S :w<CR>
map Y y$

" Convert to Unicode defaults
set encoding=utf-8
setglobal termencoding=utf-8
set fileencoding=utf-8
scriptencoding=utf-8

set nocompatible

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
" some version color incorrect
"let &t_ut=''
set foldmethod=indent
set foldlevel=99
set autochdir

autocmd BufNewFile,BufRead * try
autocmd BufNewFile,BufRead *	set encoding=utf-8
autocmd BufNewFile,BufRead * endtry


" set the menu & the message to English
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set lines=45 columns=82
winpos 920 0

"Toggle Menu and Toolbar
set guioptions-=T
set guioptions-=m
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>


" Keep 1000 items in the history.
set history=1000

" always show tab page:2, only >1 files:1, never show:0
set showtabline=1

" show the cursor position.
set ruler

" show the possible matches just the above command line.
set wildmenu

"----------------Search------------------"
" highlight search.
set hlsearch
set incsearch

set ignorecase
set smartcase

set linebreak

set autoindent
set smartindent

"----------------Visuals------------------"
" load color scheme {name}
" colorscheme koehler
colorscheme atom-dark

let &t_CO=256
" set cursor sharp
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set laststatus=2

" Cancel scroll h & v
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" set font
" set guifont=Courier\ New:h16
set guifont=Consolas:h16:cANSI:qDRAFT
syntax enable

" minimal number of screen to keep above and below the cursor.
set scrolloff=5

set cursorline
" set cursorcolumn

set number
set relativenumber

" show tab and tail
set list
set listchars=tab:▸\ ,trail:▫



"----------------tab------------------"
set tabstop=4
set shiftwidth=4
set softtabstop=4

set backspace=indent,eol,start

" set clipboard shared with window and vim
set clipboard=unnamed

" add matchpairs
set matchpairs+=<:>,«:»



if has('persistent_undo')
	set undofile
endif

set noswapfile

set undodir=~/_VIM_UNDO_FILES.txt

set undolevels=5000

set wildmode=list:longest,full

" auto source ~/_vimrc
augroup autosourcing
	autocmd!
	autocmd BufWritePost _vimrc source %
augroup END

" delete last trailinDTreeToggle
autocmd BufWritePre * :%s/\s\+$//e
