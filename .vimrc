set number
set relativenumber

function! DeleteAllBuffers()
  bufdo bd
endfunction

command! Bd call DeleteAllBuffers()

call plug#begin()

Plug 'preservim/NERDTree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'

call plug#end()

if executable('solargraph')
  augroup LspRuby
    au!
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
	\ 'whitelist': ['ruby'],
        \ })
  augroup END
endif
