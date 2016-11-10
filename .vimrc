"
" .vimrc
"
" vim:ft=vim
"

set nocp
if &term == "xterm"
	let &term = "xterm-256color"
endif

if &t_Co > 2 || has("gui_running")
	if !exists("syntax_on")
		syn on
	endif
	set hls
endif

set backspace=indent,eol,start
set nu

setglobal fileencoding=UTF-8
set fileencodings=UCS-BOM,UTF-8,KOI8-R
set termencoding=UTF-8
set encoding=UTF-8

if has("gui_running")
	if has("gui_gtk2")
		" Also Cygwin Vim, GTK+ UI
		" See http://vim.wikia.com/wiki/Using_the_Windows_clipboard_in_Cygwin_Vim
		set guifont=Courier\ New\ 12
	elseif has("x11")
		let os = substitute(system('uname -s'), "\n", "", "")
		if os == "Linux"
			set guifont=-monotype-courier\ new-semilight-r-normal--*-120-*-*-m-*-iso10646-1
		elseif os == "Darwin"
			set guifont=-ibm-courier-medium-r-normal--*-*-*-*-m-*-iso10646-1
		endif
	elseif has("gui_macvim")
		set guifont=Courier\ New:h18
		set noantialias
	elseif has("gui_win32")
		" Native MS-Windows Vim
		" See http://vim.wikia.com/wiki/VimTip21
		lang C

		" Do not use ~/vimfiles
		let &runtimepath='~/.vim'.','.&runtimepath

		set clipboard=unnamed
		set guioptions+=a

		set guifont=Courier_New:h12:cRUSSIAN
		setglobal fileencoding=CP1251
		set fileencodings=UCS-BOM,UTF-8,CP1251
		set termencoding=CP866
	endif

	set guioptions+=beFT
	if version >= 700
		set showtabline=2
		set guitablabel=%f
	endif
	set nomousehide
	let c_comment_strings=1

	colorscheme elflord
	set bg=dark

	hi Normal	guifg=cyan		guibg=darkblue
	hi Comment	guifg=darkgreen		guibg=darkblue
	hi LineNr	guifg=cyan
	hi Constant	guifg=magenta
	hi Identifier	guifg=yellow		guibg=darkblue
	hi Statement	guifg=white
	hi PreProc	guifg=darkred		guibg=darkblue
	hi Type		guifg=white
	hi Special	guifg=green
	if version >= 700
		hi Visual	guifg=darkblue		guibg=darkcyan
	else
		hi Visual	guifg=darkcyan		guibg=darkblue
	endif

	"" Custom highlighting -- CDE-like colours

	"hi Normal guibg=#fff7e9 guifg=Black
	"if version >= 700
	"        hi Visual guibg=Black guifg=#fff7e9
	"else
	"        hi Visual guibg=#fff7e9 guifg=Black
	"endif
	"hi NonText guibg=#9397a5
	"hi Menu guibg=#aeb2c3 guifg=Black

	"" Other highlighting

	"hi Cursor guibg=Green guifg=NONE
	"hi lCursor guibg=Cyan guifg=NONE

	"hi Constant gui=NONE guibg=grey95
	"hi Special gui=NONE guibg=grey95
else
	map <F10>	:q<CR>
	set mouse=a

	if &term == "linux"
			\ || &term == "screen.linux"
			\ || &term == "ansi"
			\ || &term == "xterm"
			\ || &term == "xterm-color"
			\ || &term == "xterm-256color"
			\ || &term == "screen"
			\ || &term == "dtterm"
			\ || &term == "kterm"
			\ || &term == "cygwin"
		" Linux console, screen, XTerm, DtTerm or Solaris RXVT

		map <ESC>0	:q<CR>

		set bg=dark

		hi Normal	ctermfg=cyan		ctermbg=darkblue
		hi Comment	ctermfg=darkgreen	ctermbg=darkblue
		hi LineNr	ctermfg=cyan
		hi Constant	ctermfg=magenta
		hi Identifier	ctermfg=yellow		ctermbg=darkblue
		hi Statement	ctermfg=white
		hi PreProc	ctermfg=darkred		ctermbg=darkblue
		hi Type		ctermfg=white
		hi Special	ctermfg=green
		if &term == "linux"
				\ || &term == "screen.linux"
				\ || &term == "ansi"
				\ || &term == "screen"
				\ || &term == "dtterm"
				\ || &term == "kterm"
				\ || &term == "cygwin"
			" Linux console, screen, DtTerm or Solaris RXVT
			hi Visual	ctermfg=darkcyan	ctermbg=darkblue
		else
			" XTerm
			hi Visual	ctermfg=darkblue	ctermbg=darkcyan
		endif

		if &term == "cygwin"
			setglobal fileencoding=CP1251
			set fileencodings=UCS-BOM,UTF-8,CP1251
			set termencoding=CP1251
		endif
	elseif &term == "sun-color"
		" SunOS console

		" Vim 6.x doesn't know of sun-cmd escape sequences
		unmap <F10>

		" Default highlighting: default background is white:
		""set bg=light
		" Custom highlighting: default background is darkblue:
		set bg=dark

		hi Normal	ctermfg=cyan		ctermbg=darkblue
		hi Comment	ctermfg=darkgreen	ctermbg=darkblue
		hi LineNr	ctermfg=cyan
		hi Constant	ctermfg=magenta
		hi Identifier	ctermfg=yellow		ctermbg=darkblue
		hi Statement	ctermfg=white
		hi PreProc	ctermfg=darkred		ctermbg=darkblue
		hi Type		ctermfg=white
		hi Special	ctermfg=green
		hi Visual	ctermfg=darkcyan	ctermbg=darkblue
	elseif has("win32") || has("win16")
		" Windows console
		lang C

		" Do not use ~/vimfiles
		let &runtimepath='~/.vim'.','.&runtimepath

		set clipboard=unnamed

		setglobal fileencoding=CP1251
		set fileencodings=UCS-BOM,UTF-8,CP1251
		set termencoding=CP866

		map <ESC>	:q<CR>

		set bg=dark

		hi Normal	ctermfg=cyan		ctermbg=darkblue
		hi Comment	ctermfg=darkgreen	ctermbg=darkblue
		hi LineNr	ctermfg=cyan
		hi Constant	ctermfg=magenta
		hi Identifier	ctermfg=yellow		ctermbg=darkblue
		hi Statement	ctermfg=white
		hi PreProc	ctermfg=darkred		ctermbg=darkblue
		hi Type		ctermfg=white
		hi Special	ctermfg=green
		hi Visual	ctermfg=darkblue	ctermbg=darkcyan
	else
		" All other terminals
		set bg=light
	endif
endif

set nowrap
set ts=8
set sw=8
set sta
set noet
set ai
set si
set confirm
set sc
set showcmd
set ru
set ruler
set incsearch
set eb
set vb
set laststatus=2
set history=1000

" Vundle
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()
filetype plugin indent on

" Syntastic BEGIN
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
" Syntastic END

" Fugitive BEGIN
set statusline+=%{fugitive#statusline()}
" Fugitive END

" Airline BEGIN
let g:airline#extensions#tabline#enabled = 1
" Airline END
