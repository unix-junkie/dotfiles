"
" ~/.config/nvim/ginit.vim
"

if exists('g:GuiLoaded')
	" https://github.com/equalsraf/neovim-qt
	GuiFont Courier\ New:h12
	GuiTabline 0
	GuiPopupmenu 0
	GuiScrollBar 0

	" Right Click Context Menu (Copy-Cut-Paste)
	nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
	inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
	xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
	snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

	nnoremap <A-CR> :call GuiWindowFullScreen(!g:GuiWindowFullScreen)<CR>
endif
