set number
set relativenumber
set updatetime=30000
set foldmethod=syntax
set foldlevelstart=10
set foldnestmax=10

autocmd InsertLeave * write

command! Bd call DeleteAllBuffers()
command! FFS call ToggleNERDTreeAndSyncDir()
command! F call FindFile()

function! DeleteAllBuffers()
    bufdo bd
endfunction

function! ToggleNERDTreeAndSyncDir()
    lcd %:p:h
    NERDTreeToggle
endfunction

function! FindFile()
    let project_root = system('git rev-parse --show-toplevel')
    let project_root = substitute(project_root, '\n$', '', '')

    if isdirectory(project_root)
        let l:current_dir = expand('%:p:h')

        execute 'cd' project_root

        Files

        execute 'lcd' l:current_dir
    else
        echo "Project root not found."
    endif
endfunction

call plug#begin()

Plug 'yegappan/mru', { 'on': 'MRU' }
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
