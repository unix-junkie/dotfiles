"
" ~/.config/nvim/init.vim
"
" vim:ft=vim
"

set nocompatible

if &t_Co > 2 || has("gui_running")
	if !exists("syntax_on")
		syntax on
	endif
	set hlsearch
endif

set nu
set nowrap

if has('gui_running')
	if exists('g:fvim_loaded')
		if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
			set guifont=Courier\ New:h16
		else
			set guifont=Courier\ New:h32
		endif

		nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
		nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
		nnoremap <A-CR> :FVimToggleFullScreen<CR>

		set clipboard=unnamedplus
	elseif exists('g:gui_dotnvim')
		" https://github.com/dontpanic92/dotnvim 
		set guifont=Courier\ New:h12
	elseif exists('g:neoray')
		set guifont=Courier\ New:h12
		NeoraySet CursorAnimTime 0.08
		NeoraySet Transparency   0.95
		NeoraySet TargetTPS      120
		NeoraySet ContextMenu    TRUE
		NeoraySet BoxDrawing     TRUE
		NeoraySet ImageViewer    TRUE
		NeoraySet WindowSize     100x40
		NeoraySet WindowState    centered
		NeoraySet KeyFullscreen  <M-CR>
		NeoraySet KeyZoomIn      <C-ScrollWheelUp>
		NeoraySet KeyZoomOut     <C-ScrollWheelDown>
	elseif exists('g:neovide')
		set guifont=Courier\ New:h12:#e-alias
	elseif exists('g:nvui')
		set guifont=Courier\ New:h12
		nnoremap <A-CR> :NvuiToggleFullscreen<CR>
	elseif exists('g:nvy')
		set guifont=Courier\ New:h12
	endif
endif

filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'

"Plugin 'tpope/vim-fugitive'
"Plugin 'airblade/vim-gitgutter'

"Plugin 'vim-syntastic/syntastic'
"Plugin 'preservim/nerdtree'
"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'uguu-org/vim-matrix-screensaver'

Plugin 'udalov/kotlin-vim'

"Plugin 'editorconfig/editorconfig-vim'

"Plugin 'godlygeek/tabular'
"Plugin 'preservim/vim-markdown'
"Plugin 'timcharper/textile.vim'
"Plugin 'gu-fan/riv.vim'
"Plugin 'tpope/vim-speeddating'
"Plugin 'jceb/vim-orgmode'
"Plugin 'habamax/vim-asciidoctor'

"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'lifepillar/vim-solarized8'

Plugin 'neovim/nvim-lspconfig'

call vundle#end()
filetype plugin indent on

if !has('gui_running')
	set termguicolors
endif

colorscheme solarized8
