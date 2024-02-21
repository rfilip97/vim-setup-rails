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

function! AgProject(searchTerm)
    let l:current_dir = getcwd()
    let l:project_root = system('git rev-parse --show-toplevel | tr -d "\n"')
    if isdirectory(l:project_root)
        cd l:project_root
        execute 'Ag' a:searchTerm
        cd l:current_dir
    else
        echo "Project root not found."
    endif
endfunction

command! -nargs=1 Agp call AgProject(<f-args>)

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
