"
" .vimrc
"
" vim:ft=vim
"

" Windows-specific defaults
if (has("win32") || has("win16")) && filereadable(expand("$VIM/_vimrc"))
	source $VIM/_vimrc
endif

set nocompatible

if &t_Co > 2 || has("gui_running")
	if !exists("syntax_on")
		syntax on
	endif
	set hlsearch
endif

setglobal fileencoding=UTF-8
set fileencodings=UCS-BOM,UTF-8,KOI8-R
set termencoding=UTF-8
set encoding=UTF-8

if has("gui_running")
	if has("gui_gtk2") || has("gui_gtk3")
		" Also Cygwin Vim, GTK+ UI
		" See http://vim.wikia.com/wiki/Using_the_Windows_clipboard_in_Cygwin_Vim
		set guifont=Courier\ New\ 12
	elseif has("x11")
		let os = substitute(system('uname -s'), "\n", "", "")
		if os == "Linux"
			set guifont=-monotype-courier\ new-medium-r-normal--*-120-162-162-m-*-iso10646-1
		elseif os == "Darwin"
			set guifont=-ibm-courier-medium-r-normal--*-*-*-*-m-*-iso10646-1
		endif
		set guioptions+=F
	elseif has("gui_macvim")
		set guifont=Courier\ New:h18
		set noantialias
	elseif has("gui_win32")
		" Native MS-Windows Vim
		" See http://vim.wikia.com/wiki/VimTip21
		lang C

		" Do not use ~/vimfiles
		set runtimepath+=~/.vim
		set packpath+=~/.vim

		set clipboard=unnamedplus
		set guioptions+=!
		set guioptions+=a

		set guifont=Courier_New:h12:cRUSSIAN:qNONANTIALIASED
		setglobal fileencoding=CP1251
		set fileencodings=UCS-BOM,UTF-8,CP1251
		set termencoding=CP866
	endif

	set guioptions-=b
	set guioptions-=e
	set guioptions-=m
	set guioptions-=r
	set guioptions-=T
	if version >= 700
		set guitablabel=%f
		if stridx(&guioptions, "e") >= 0
			" Always show (even if just a single tab),
			" but only if GUI tabs are used.
			set showtabline=2
		endif
	endif
	set nomousehide
	let c_comment_strings=1
else " gui_running
	set mouse=a

	if &term == "linux"
			\ || &term == "screen.linux"
			\ || &term == "ansi"
			\ || &term == "xterm"
			\ || &term == "xterm-color"
			\ || &term == "xterm-256color"
			\ || &term == "screen"
			\ || &term == "screen-256color"
			\ || &term == "screen.xterm-256color"
			\ || &term == "rxvt-unicode-256color"
			\ || &term == "dtterm"
			\ || &term == "kterm"
			\ || &term == "cygwin"
		" Linux console, screen, XTerm, DtTerm, Solaris RXVT, Cygwin or MSys
		if &term == "cygwin"
			" Modern cmd.exe versions can display 256 colors
			set t_Co=256
			let g:solarized_termcolors=256
			set termguicolors

			setglobal fileencoding=CP1251
			set fileencodings=UCS-BOM,UTF-8,CP1251
			set termencoding=CP1251
		elseif &term == "xterm-256color"
				\ || &term == "screen-256color"
				\ || &term == "rxvt-unicode-256color"
			" XTerm, Rxvt, or Tmux
			let g:solarized_termcolors=256
			set termguicolors
		elseif &term == "screen.xterm-256color"
			" Screen
			let g:solarized_termcolors=256
			set notermguicolors
		endif
	elseif &term == "sun-color"
		" SunOS console
	elseif has("win32") || has("win16") || &term == "win32"
		" Windows console
		lang C

		" Do not use ~/vimfiles
		set runtimepath+=~/.vim
		set packpath+=~/.vim

		" `unnamedplus` breaks the console (`vim.exe`) version,
		" resulting in text being only partially copied to the
		" clipboard.
		set clipboard=unnamed

		setglobal fileencoding=CP1251
		set fileencodings=UCS-BOM,UTF-8,CP1251
		set termencoding=CP866

		" Modern cmd.exe versions can display 256 colors
		set t_Co=256
		let g:solarized_termcolors=256
		set termguicolors
	else
		" All other terminals
	endif
endif " gui_running

" Menu BEGIN
set wildmenu
set wildmode=full
if version >= 900
	set wildoptions=pum
endif
" No GUI running, or menu disabled
if !has("gui_running") || stridx(&guioptions, "m") == -1
	" Add the default menu entries (File, Edit,..)
	set langmenu=en_US
	source $VIMRUNTIME/menu.vim
	" Make menu accessible via F10.
	"
	" See <https://unix.stackexchange.com/a/57911/94327>.
	" <C-Z> is the same as <Tab>, except that it doesn't break
	" the ":emenu Syntax.Highlight\ Test" command.
	"
	" This problem appears to be already fixed in Vim 9.
	set wildcharm=<C-Z>
	map <F10> :emenu <C-Z>
	imap <F10> <Esc>:emenu <C-Z>
endif
" Menu END

" Indent BEGIN
set autoindent
set noexpandtab
set shiftwidth=8
set smartindent
set smarttab
set tabstop=8
" Indent END

set backspace=indent,eol,start
set confirm
set errorbells
set history=1000
set incsearch
set laststatus=2
set modeline
set modelines=10
set nowrap
set number
set ruler
set showcmd
set undodir=~/.local/share/vim/undo
set visualbell

" Vundle BEGIN
filetype off                  " required
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

Plugin 'preservim/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'udalov/kotlin-vim'

Plugin 'editorconfig/editorconfig-vim'

Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'timcharper/textile.vim'
Plugin 'gu-fan/riv.vim'
Plugin 'tpope/vim-speeddating'
Plugin 'jceb/vim-orgmode'
Plugin 'habamax/vim-asciidoctor'

Plugin 'lifepillar/vim-solarized8'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Vundle END

" Fugitive BEGIN
set statusline+=%{fugitive#statusline()}
" Fugitive END

" preservim/vim-markdown BEGIN
let g:vim_markdown_folding_disabled = 1
" preservim/vim-markdown END

if has("gui_running")
	colorscheme solarized8
	set background=dark
elseif &t_Co > 16
	if has("win32") || has("win16") || &term == "win32" || &term == "cygwin"
		" Windows console
		colorscheme solarized8
		set background=dark
	elseif &term == "xterm-256color"
			\ || &term == "screen-256color"
			\ || &term == "rxvt-unicode-256color"
		" XTerm or any other TrueColor-capable terminal (PuTTY, MinTTY, WezTerm, etc.).
		colorscheme solarized8
		set background=dark
	elseif &term == "screen.xterm-256color"
		" Screen
		let g:solarized_termtrans=1
		colorscheme solarized8
		set background=light
	endif
endif

if has("python3") && filereadable(expand("~/.vimrc.py"))
	py3file ~/.vimrc.py
endif

if has("lua") && filereadable(expand("~/.vimrc.lua"))
	luafile ~/.vimrc.lua
endif
