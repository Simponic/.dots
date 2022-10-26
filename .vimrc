syntax on

set autoindent
set nowrap
set backspace=indent,eol,start

set tabstop=2
set shiftwidth=2
set expandtab

set cursorline
set number relativenumber

set laststatus=2
set statusline=
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c 

highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
highlight CursorLine ctermbg=255 ctermfg=NONE
highlight StatusLine ctermbg=255 
highlight StatusLineTerm ctermbg=238 ctermfg=255
highlight StatusLineTermNC ctermbg=232 ctermfg=238

set encoding=utf-8
