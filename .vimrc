set nocompatible
filetype off
set encoding=UTF-8
set rtp+=$HOME/.vim/bundle/Vundle.vim
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'               " Plugin manager

Plugin 'scrooloose/nerdtree'                " File explorer
Plugin 'Xuyuanp/nerdtree-git-plugin'        " Git integration for nerdtree
Plugin 'tpope/vim-fugitive'                 " Git integration
Plugin 'ctrlpvim/ctrlp.vim'                 " Fuzzy file searching 
Plugin 'chriskempson/base16-vim'            " base16_shell vim integration
Plugin 'tpope/vim-surround'                 
Plugin 'vim-airline/vim-airline'            " Fancy statusbar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/goyo.vim'                  " Zen-mode (distraction free)
Plugin 'Valloric/YouCompleteMe'             " Auto-completion engine
"Plugin 'alx741/vinfo'                       " See info files inside vim
"Plugin 'ervandew/supertab'                 " Tab completion
"Plugin 'blueyed/vim-diminactive'
Plugin 'ryanoasis/vim-devicons'
Plugin 'christoomey/vim-tmux-navigator'     " Seemless navigation between vim and tmux

"Plugin 'davidhalter/jedi-vim'               " Python go to definition, completions, etc.
Plugin 'nvie/vim-flake8'                     " Python linter
Plugin 'janko-m/vim-test'                    " Run tests easily inside of vim

" Plugin 'pangloss/vim-javascript'             " JS Snippets
" Plugin 'mxw/vim-jsx'                         " React JSX highlighting
" Plugin 'prettier/vim-prettier'               " JavaScript code formatter

Plugin 'SirVer/ultisnips'
" Plugin 'letientai299/vim-react-snippets'
Plugin 'honza/vim-snippets'
Plugin 'suan/vim-instant-markdown'

" Plugin 'LucHermitte/lh-vim-lib'             " 'local_vimrc' dependency
" Plugin 'LucHermitte/local_vimrc'
Plugin 'wincent/terminus'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'python-mode/python-mode'
" Plugin 'neovimhaskell/haskell-vim'

Plugin 'fatih/vim-go'
Plugin 'sebdah/vim-delve'

call vundle#end()
filetype plugin indent on
filetype plugin on

syntax on

colorscheme default

autocmd! bufwritepost .vimrc source %

set hlsearch
set mouse=a
set ignorecase
set smartcase
set nowrap
"set foldmethod=indent
" default is: set fillchars=vert:\|,fold=-
set number
set relativenumber
set ruler
set exrc " Enable project specific .vimrc's
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set tabstop=4 shiftwidth=4 expandtab
set backspace=indent,eol,start
set formatoptions+=j                        " smart joining of comments when using shift
set formatoptions-=t                        " don't auto-wrap
set nojoinspaces                            " don't autoinsert space after '.', '!', '?'
set scrolloff=3                             " start scrolling 3 lines before edge of viewport

set path+=**
set wildmenu
set fillchars=vert:┃
set shell=bash\ -i
" set fillchars=vert:𐄠
syntax on

"Cursor shape based on mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

let mapleader = " "
nnoremap <CR> :nohlsearch<CR><CR>
filetype plugin indent on    " required

inoremap <Down> <ESC>ddpi
inoremap <Up> <ESC>ddkkpi
nnoremap <Down> :cnext<Enter>
nnoremap <Up> :cprev<Enter>

"Open the file under the cursor in a vertical split (like <Ctrl-W> f)
map gv :vertical wincmd f<CR>
map gs <C-W>f

nmap <F1> ^i//<Esc>
nmap <F2> ^xx


""Tabs bindings
nmap <Leader>l :tabnext<CR>
nmap <Leader>h :tabprevious<CR>
nmap <Leader>n :tabnew<CR>

nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>f :NERDTreeToggle<CR>

""Window bindings
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
nmap <C-h> <C-W>h
nmap <C-n>h :vsp 
nmap <C-n>v :sp 
nmap <C-f> :Goyo<CR>

nmap O O<Esc>
nmap 0 ^

nnoremap tl :tabnext<CR>
nnoremap th :tabprevious<CR>
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>

"Display time and date in the ruler bar
set ruler
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

nnoremap ; :
"set laststatus=2
"set statusline=%f "tail of the filename


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:base16_theme = $BASE16_THEME

function! Base16Enable()
    let g:base16_enabled=1
    let base16colorspace=256

    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background

        hi CursorLineNr ctermbg=none cterm=bold
        hi CursorLine ctermbg=0
        hi Normal ctermbg=none
        hi Visual ctermbg=8
        hi LineNr ctermbg=none
        hi Folded ctermbg=NONE ctermfg=11
        hi VertSplit ctermbg=NONE ctermfg=3
        " hi StatusLine ctermbg=NONE ctermfg=2 cterm=bold
        " hi StatusLine ctermbg=NONE
        hi StatusLineNC ctermbg=NONE
        hi TabLine ctermbg=NONE
        hi TabLineFill ctermbg=NONE
        hi TabLineSel ctermbg=0 ctermfg=2
        hi ColorColumn ctermbg=NONE ctermfg=8
        hi Search ctermfg=0 ctermbg=5
        hi Todo ctermfg=0 ctermbg=5
        hi DiffChange ctermfg=0 ctermbg=5
        hi Pmenu ctermbg=8
        hi PmenuSel ctermfg=0
        hi QuickFixLine ctermbg=NONE ctermfg=2
        hi NERDTreeFlags ctermfg=7
        hi Comment ctermfg=12
        hi SignColumn ctermbg=NONE ctermfg=1
        hi LineNr ctermfg=59
    endif
endfunction

"call Base16Enable()

" nnoremap <leader>t ^f]hrx$:call Now('')<CR>j^

function! Now(format)
  let format = empty(a:format) ? '+%H:%M' : a:format
  let cmd = '/bin/date ' . shellescape(format)
  let result = substitute(system(cmd), '[\]\|[[:cntrl:]]', '', 'g')
  " Append space + result to current line without moving cursor.
  call setline(line('.'), getline('.') . ' ' . result)
endfunction 

if empty(g:base16_theme) == 0
    call Base16Enable()
endif

augroup BgHighlight
    autocmd!
augroup END

autocmd FocusGained * if &number =~ "1" | set relativenumber | endif
autocmd FocusLost * set norelativenumber

autocmd FileType python setlocal foldmethod=indent
autocmd FileType python inoremap ;p import<Space>pdb;pdb.set_trace()
autocmd FileType python inoremap ;i import<Space>ipdb;ipdb.set_trace()
autocmd FileType python let g:flake8_cmd="/usr/bin/flake8"
"autocmd FileType python let g:jedi#completions_command = "<Tab>"
autocmd FileType python nnoremap <leader>e :! ipython %<CR>
autocmd FileType python vnoremap e :w ! python<CR>
autocmd FileType python nnoremap <F6> :! ipython %<CR>
autocmd FileType python nnoremap <leader>p :call Flake8()<CR>
autocmd FileType python set shiftwidth=4 tabstop=4
let g:pymode_lint = 0

autocmd FileType haskell :let hs_highlight_delimiters = 1
autocmd FileType haskell :let hs_highlight_boolean = 1
autocmd FileType haskell :let hs_highlight_types = 1
autocmd FileType haskell :let hs_highlight_more_types = 1
autocmd FileType haskell :set shiftwidth=2 tabstop=2

autocmd FileType go nnoremap <leader>e :Shell go run %<CR>
autocmd FileType go nnoremap <leader>b :GoBuild<CR>
autocmd FileType go nnoremap <leader>t :GoTest<CR>
autocmd Filetype go nnoremap <leader>p :GoDebugBreakpoint<CR>
autocmd FileType go set foldmethod=syntax

" set colorcolumn=80
let g:airline#extensions#tabline#enabled = 1
"cool themes: sierra peaksea ravenpower alduin seagull
let g:airline_theme='alduin'
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 0
"let g:airline_statusline_ontop = 1
"let g:airline_focuslost_inactive = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

function! s:goyo_enter()
    set norelativenumber
    set nonumber

    call Base16Enable()
endfunction

function! s:goyo_leave()
    call Base16Enable()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

hi ColorColumn ctermbg=NONE ctermfg=8
hi Folded ctermbg=NONE
let g:diminactive_use_colorcolumn = 1
let g:diminactive_use_syntax = 0
let g:diminactive = 0                       " disable it by default

nnoremap <C-p> :CtrlP<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_show_hidden = 1
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

"let g:SuperTabDefaultCompletionType = "<c-n>"
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<CR>"
let g:UltiSnipsJumpBackwardTrigger="<c-r>"
let g:local_vimrc = ['.config', '.local.vimrc']

autocmd FileType javascript set shiftwidth=2 tabstop=2
set secure

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number ft=none
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "",
    \ "Staged"    : "",
    \ "Untracked" : "",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✕",
    \ "Clean"     : "",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" 
" ✕✓✔✚✖

let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
let g:NERDTreeShowHidden = 1
let NERDTreeIgnore=['__pycache__$']
let g:NERDTreeMouseMode = 3
let g:NERDTreeWinSize = 40
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeAutoDeleteBuffer = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd bufenter * if (exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:tmux_navigator_disable_when_zoomed = 1

let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_operators = 1

let g:delve_breakpoint_sign = ""
let g:delve_enable_syntax_highlighting=1
