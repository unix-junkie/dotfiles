--
-- ~/.config/nvim/init.lua
--

-- Windows-specific defaults
vim.cmd([[
	if (has("win32") || has("win16"))
		if has("gui_running")
			" Maximize the window on Windows
			autocmd GUIEnter * simalt ~x
		endif
	endif
]])

vim.opt.compatible=false

vim.cmd([[
	if &t_Co > 2 || has("gui_running")
		if !exists("syntax_on")
			syntax on
		endif
		set hlsearch
	endif

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
]])

-- Menu BEGIN
vim.opt.wildmenu=true
vim.opt.wildmode='full'
vim.opt.wildoptions='pum'

-- Add the default menu entries (File, Edit,..)
vim.opt.langmenu='en_US'
vim.cmd([[
	source $VIMRUNTIME/menu.vim
]])

-- Make menu accessible via F10.
--
-- See <https://unix.stackexchange.com/a/57911/94327>.
-- <C-Z> is the same as <Tab>, except that it doesn't break
-- the ":emenu Syntax.Highlight\ Test" command.
--
-- This problem appears to be already fixed in Vim 9.
vim.cmd([[
	set wildcharm=<C-Z>
	map <F10> :emenu <C-Z>
	imap <F10> <Esc>:emenu <C-Z>
]])
-- Menu END

-- Indent BEGIN
vim.opt.autoindent=true
vim.opt.expandtab=false
vim.opt.shiftwidth=8
vim.opt.smartindent=true
vim.opt.smarttab=true
vim.opt.tabstop=8
-- Indent END

vim.opt.backspace='indent,eol,start'
vim.opt.confirm=true
vim.opt.errorbells=true
vim.opt.history=1000
vim.opt.incsearch=true
vim.opt.laststatus=2
vim.opt.modeline=true
vim.opt.modelines=10
vim.opt.number=true
vim.opt.ruler=true
vim.opt.showcmd=true
vim.opt.undodir='~/.local/share/nvim/undo'
vim.opt.visualbell=true
vim.opt.wrap=false

-- Vundle BEGIN
vim.cmd([[
	filetype off                  " required
	set runtimepath+=~/.config/nvim/bundle/Vundle.vim
	call vundle#begin('~/.config/nvim/bundle')

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

	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'lifepillar/vim-solarized8'

	call vundle#end()            " required
	filetype plugin indent on    " required
	" To ignore plugin indent changes, instead use:
	"filetype plugin on
]])

-- Brief help
-- :PluginList       - lists configured plugins
-- :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
-- :PluginSearch foo - searches for foo; append `!` to refresh local cache
-- :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

-- see :h vundle for more details or wiki for FAQ
-- Put your non-Plugin stuff after this line
-- Vundle END

-- Fugitive BEGIN
vim.cmd([[
	set statusline+=%{fugitive#statusline()}
]])
-- Fugitive END

-- Airline BEGIN
if vim.fn.has('gui_running') == 0 then
	-- Enable the tabline emulation,
	-- but only in the console mode.
	vim.cmd([[
		let g:airline#extensions#tabline#enabled = 1
	]])
end
-- Airline END

-- preservim/vim-markdown BEGIN
vim.cmd([[
	let g:vim_markdown_folding_disabled = 1
]])
-- preservim/vim-markdown END

if vim.fn.has('gui_running') == 0 then
	vim.opt.termguicolors=true
end

vim.cmd([[
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
				\ || &term == "nvim"
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
]])
