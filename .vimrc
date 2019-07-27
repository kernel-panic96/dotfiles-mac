" vim: foldmethod=indent foldlevel=0
set nocompatible
filetype off
filetype plugin on
filetype plugin indent on    " required
syntax on
set encoding=UTF-8

set shm+=A

set rtp+=$HOME/.vim/bundle/Vundle.vim
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/my_stuff

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'               " Plugin manager

    Plugin 'scrooloose/nerdtree'                " File explorer
    Plugin 'Xuyuanp/nerdtree-git-plugin'        " Git integration for nerdtree
    Plugin 'tpope/vim-fugitive'                 " Git integration
    Plugin 'chriskempson/base16-vim'            " base16_shell vim integration
    Plugin 'tpope/vim-surround'                 " surrounding text objects with symbols
    Plugin 'junegunn/fzf.vim'                   " fzf integration
    Plugin 'vim-airline/vim-airline'            " fancy statusbar
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'NLKNguyen/papercolor-theme'
    Plugin 'junegunn/goyo.vim'                  " Zen-mode (distraction free)
    Plugin 'Valloric/YouCompleteMe'             " Auto-completion engine
    " Plugin 'alx741/vinfo'                       " See info files inside vim
    Plugin 'blueyed/vim-diminactive'
    Plugin 'ryanoasis/vim-devicons'
    Plugin 'christoomey/vim-tmux-navigator'     " Seemless navigation between vim and tmux

    "Plugin 'davidhalter/jedi-vim'               " Python go to definition, completions, etc.
    Plugin 'nvie/vim-flake8'                     " Python linter
    " Plugin 'janko-m/vim-test'                    " Run tests easily inside of vim

    Plugin 'pangloss/vim-javascript'             " JS Snippets
    Plugin 'mxw/vim-jsx'                         " React JSX highlighting
    Plugin 'prettier/vim-prettier'               " JavaScript code formatter

    Plugin 'SirVer/ultisnips'
    " Plugin 'letientai299/vim-react-snippets'
    Plugin 'honza/vim-snippets'
    Plugin 'suan/vim-instant-markdown'

    " Plugin 'LucHermitte/lh-vim-lib'             " 'local_vimrc' dependency
    " Plugin 'LucHermitte/local_vimrc'
    Plugin 'wincent/terminus'
    Plugin 'tmux-plugins/vim-tmux-focus-events'
    Plugin 'python-mode/python-mode'
    Plugin 'python-rope/ropevim'
    Plugin 'neovimhaskell/haskell-vim'

    Plugin 'fatih/vim-go'
    Plugin 'sebdah/vim-delve'
    " Plugin 'file:///~/play/go_dbg_extender.vim'
    Plugin 'kernel-panic96/vim-go-extensions'
    Plugin 'file:///Users/yrl/play/vim-test'

    Plugin 'jiangmiao/auto-pairs'                 " smarter brackets,parens insertion

    Plugin 'unblevable/quick-scope'               " highlight unique characters in words for quick 'f' jumping
    Plugin 'tpope/vim-repeat'                     " `.` repeat command for plugins
    Plugin 'tpope/vim-commentary'                 " comment/uncomment code

    Plugin 'benmills/vimux'
    Plugin 'solarnz/thrift.vim'                   " highlighting for thrift definitions
    Plugin 'terryma/vim-expand-region'            " visually select increasingly larger regions of text
    Plugin 'junegunn/limelight.vim'
call vundle#end()

" --------- General settings
    filetype plugin indent on
    filetype plugin on
    syntax on

    " reload vimrc everytime it changes
    autocmd! bufwritepost .vimrc source %

    set shell=bash\ -i
    set hlsearch
    set mouse=a
    set ignorecase
    set smartcase
    set nowrap
    set number
    set relativenumber
    set ruler
    " set exrc " Enable project specific .vimrc's
    set ruler
    colorscheme default

    set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%) " Display time and date in the ruler bar
    set tabstop=4 shiftwidth=4 expandtab
    set backspace=indent,eol,start
    set formatoptions+=j                        " smart joining of comments when using shift
    set formatoptions-=o
    set formatoptions-=t                        " don't auto-wrap
    set nojoinspaces                            " don't autoinsert space after '.', '!', '?'
    set scrolloff=3                             " start scrolling 3 lines before edge of viewport

    set path+=**
    set wildmenu
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
    "the default is: set fillchars=vert:\|,fold=-
    set fillchars=vert:┃ " 𐄠
    " set fillchars=vert:
    set shell=bash\ -i
    let mapleader = " "

    " Remove relative numbers when window focus is lost, and restore it
    " conditionally when it is gained
    autocmd FocusGained * if &number =~ "1" | set relativenumber | endif
    autocmd FocusLost * if &relativenumber =~ "1" | set number norelativenumber | endif

" --------- Bindings
    nnoremap <CR> :nohlsearch<CR><CR>

    " go to the next error in the errorlist
    nnoremap <Down> :cnext<Enter> 
    " go to the prev error in the errorlist
    nnoremap <Up> :cprev<Enter>

    " ---- Tab bindings
        nmap <Leader>l :tabnext<CR>
        nmap <Leader>h :tabprevious<CR>
        nnoremap <Leader>n :tabnew<CR>
        nnoremap tl :tabnext<CR>
        nnoremap th :tabprevious<CR>
        nnoremap tn :tabnew<CR>
        nnoremap td :tabclose<CR>

    " ---- Convinience bindings
        nmap <Leader>q :q<CR>
        nmap <Leader>w :w<CR>
        nmap O O<Esc>
        nmap 0 ^
        nnoremap ; :
        " Terminal mode exit
        tnoremap <Esc> <C-\><C-n>
        " fold toggle
        noremap <leader><CR> za

    " ---- Window bindings
        " -- movement
        nmap <C-j> <C-W>j
        nmap <C-k> <C-W>k
        nmap <C-l> <C-W>l
        nmap <C-h> <C-W>h

        " -- splits and focus
        nmap <C-n>h :vsp 
        nmap <C-n>v :sp 
        nmap <C-f> :Goyo<CR>
        " Open the file under the cursor in a vertical split (like <Ctrl-W> f)
        map gv :vertical wincmd f<CR>
        " sam, but in a horizontal
        map gs <C-W>f

" -------- Language and plugin settings
    " ---- Settings per language
        " see autoload/myconfigs.vim
        autocmd FileType go         call myconfigs#go_settings()
        autocmd FileType haskell    call myconfigs#haskell_settings()
        autocmd FileType python     call myconfigs#python_settings()
        autocmd FileType javascript call myconfigs#javascript_settings()
        autocmd FileType yaml       call myconfigs#yaml_settings()

        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " ---- Plugin settings
        call myconfigs#airline_settings()
        call myconfigs#nerd_tree_settings()

        " -- vim-test settings
            let test#strategy = "vimux"
            nmap <silent> t<C-n> :TestNearest<CR>
            nmap <silent> t<C-f> :TestFile<CR>
            nmap <silent> t<C-s> :TestSuite<CR>
            nmap <silent> t<C-l> :TestLast<CR>
            nmap <silent> t<C-g> :TestVisit<CR>
        " -- vim-diminactive settings 
            let g:diminactive_use_colorcolumn = 1
            let g:diminactive_use_syntax = 1
            let g:diminactive = 0                       " disable it by default
        " -- goyo settings
            function! s:goyo_enter()
                set norelativenumber
                set nonumber
                set cursorline

                call boldify#fix_colors()
                let w:airline_disabled = 1
                hi StatusLine ctermbg=0
                " Limelight
            endfunction

            function! s:goyo_leave()
                set nocursorline
                let w:airline_disabled = 0
                call boldify#fix_colors()
                " Limelight!
            endfunction

            autocmd! User GoyoEnter nested call <SID>goyo_enter()
            autocmd! User GoyoLeave nested call <SID>goyo_leave()
        " -- vim-tmux-navigator settings
            " icons I like(may not be visible to you):             ✕✓✔✚✖
            let g:tmux_navigator_disable_when_zoomed = 1
        " -- web-icons settings
            let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
        " -- ultisnips settings
            let g:UltiSnipsExpandTrigger="<c-e>"
            let g:UltiSnipsJumpForwardTrigger="<CR>"
            let g:UltiSnipsJumpBackwardTrigger="<c-r>"
        " -- fzf settings
            let g:fzf_action = {
              \ 'ctrl-t': 'tab split',
              \ 'ctrl-s': 'split',
              \ 'ctrl-v': 'vsplit' }

            " use fzf as file searcher
            nnoremap <C-p> :Files<CR>

            " Make fzf#vim#grep use ripgrep instead of ag:
            command! -bang -nargs=* Rg
              \ call fzf#vim#grep(
              \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
              \   <bang>0 ? fzf#vim#with_preview('up:60%')
              \           : fzf#vim#with_preview('right:50%:hidden', '?'),
              \   <bang>0)

            " Files command with preview window
            command! -bang -nargs=? -complete=dir Files
              \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
        " -- misc settings
            map <Leader>vq :VimuxCloseRunner<CR>

            vmap v <Plug>(expand_region_expand)
            vmap <C-v> <Plug>(expand_region_shrink)

            " -- color correction
            " see autoload/boldify
            call boldify#fix_colors()
            call boldify#italicize()
            call boldify#boldify()

" -------- Experiments
    command! CopyBuffer let @+ = expand('%:p')
    " let g:base16_theme = $BASE16_THEME

    " nnoremap <leader>t ^f]hrx$:call Now('')<CR>j^
    function! Now(format)
        let format = empty(a:format) ? '+%H:%M' : a:format
        let cmd = '/bin/date ' . shellescape(format)
        let result = substitute(system(cmd), '[\]\|[[:cntrl:]]', '', 'g')
        " Append space + result to current line without moving cursor.
        call setline(line('.'), getline('.') . ' ' . result)
    endfunction 

    let g:local_vimrc = ['.config', '.local.vimrc']

    set secure

    " show the highlight group of the element under the cursor
    nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

    let g:limelight_conceal_ctermfg=1
    " let g:limelight_bop = '^\s'
    " let g:limelight_eop = '\ze\n^\s'
    " let g:limelight_bop = '\(\n\n^\/\/ .*\n\|^\w.*\(:\|{\|)\)\n\)'
    " let g:limelight_eop = '\(\n\n\/\/\|^\p\n\n\)'
