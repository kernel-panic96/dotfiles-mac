" vim: foldmethod=indent

function! myconfigs#javascript_settings()
    if get(g:, 'currently_sourced_filetype', 'none') == 'javascript'
        return
    endif
    autocmd bufenter *.js call myconfigs#javascript_settings()
    let g:currently_sourced_filetype = 'javascript'

    autocmd FileType javascript set shiftwidth=2 tabstop=2
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
endfunction

function! myconfigs#vimscript_settings()
    autocmd FileType vim set foldmethod=indent
endfunction

function! myconfigs#yaml_settings()
    if get(g:, 'currently_sourced_filetype', 'none') == 'yaml'
        return
    endif
    let g:currently_sourced_filetype = 'yaml'
    autocmd bufenter *.yaml call myconfigs#yaml_settings()

    hi yamlOperator ctermfg=1
    hi yamlPlainScalar ctermfg=6
    set foldmethod=indent shiftwidth=2 tabstop=2
endfunction

function! myconfigs#python_settings()
    if get(g:, 'currently_sourced_filetype', 'none') == 'python'
        return
    endif
    let g:currently_sourced_filetype = 'python'
    autocmd bufenter *.py call myconfigs#python_settings()

    setlocal foldmethod=indent
    inoremap ;p import<space>pdb;pdb.set_trace()
    inoremap ;i import<space>ipdb;ipdb.set_trace()
    "autocmd filetype python let g:flake8_cmd="/usr/bin/flake8"
    "autocmd filetype python let g:jedi#completions_command = "<tab>"
    nnoremap <leader>e :! ipython %<cr>
    vnoremap e :w ! python<cr>
    nnoremap <f6> :! ipython %<cr>
    nnoremap <leader>p :pymodelint<cr>
    nnoremap <leader>;g :ropegotodefinition<cr>
    nnoremap <leader>;f :ropefindoccurrences<cr>
    nmap <silent> t<c-t> ?class<cr>wyiw<c-o>:nohlsearch<cr>:call vimuxruncommand("vim_test_runner_helper <c-r>%::<c-r>0")<cr>

    set sw=4 ts=4

    let g:pymode_lint = 1
    "let g:pymode_python = "python"
    let g:pymode_lint_on_write = 1
    let g:pymode_lint_message = 1
    let g:pymode_virtualenv = 1
    let g:pymode_lint_checkers = ['pylint', 'pep8']
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:pymode_lint_ignore = ["e501", "e221"]
    "let g:pymode_lint_options_pep8 =
    "    \ {'max_line_length': g:pymode_options_max_line_length}

    let g:pymode_rope_completion = 1
    " let g:pymode_rope_goto_definition_bind = '<leader>g'
    let g:pymode_rope_complete_on_dot = 1
    let g:pymode_rope_autoimport = 0
    let g:pymode_rope_autoimport_import_after_complete = 1

    let test#python#pytest#executable = 'vim_test_runner_helper'
endfunction

function! myconfigs#go_settings()
    if get(g:, 'currently_sourced_filetype', 'none') == 'go'
        return
    endif
    let g:currently_sourced_filetype = 'go'
    autocmd bufenter *.go call myconfigs#go_settings()

    nnoremap <leader>e :call VimuxRunCommand("go run " . expand('%:p'))<CR>
    nnoremap <leader>b :GoBuild<CR>
    nnoremap <leader>t :GoTest<CR>
    nnoremap <leader>;g :GoDef<CR>
    nnoremap <silent> <leader>p :ExtendedGoDebugBreakpoint<CR>

    setlocal foldmethod=syntax
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_operators = 1
    let g:go_fmt_command = "goimports"
    let g:go_metalinter_autosave = 1
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
    let g:go_metalinter_autosave_enabled = ['vet', 'golint']
    let g:go_metalinter_deadline = "5s"

    let g:delve_breakpoint_sign = ""
    let g:delve_enable_syntax_highlighting=1

    let g:go_highlight_debug=0

    " experimental, requires cron job type of deal to produce
    " /tmp/go-package-index
    command! -bang -nargs=? GoFzfImport
                \ call fzf#run(fzf#wrap({
                \ 'sink': 'GoImport',
                \ 'source': 'cat /tmp/go-package-index',
                \ 'prefix': 'src/$'
                \}))
                " \ GoImport (call fzf#vim#grep(printf("fd --type d %s/src ", $GOPATH), 1, <bang>0))

    let g:go_debug_windows = {
        \ 'stack': 'leftabove 20vnew',
        \ 'out':   'botright 10new',
        \ 'vars':  'leftabove 60vnew',
    \ }

    let g:go_debug_mappings = [
        \['nmap <nowait>',  'c', '<Plug>(go-debug-continue)'],
        \['nmap',           'q', ':ExtendedGoDebugStop<CR>'],
        \['nmap <nowait>',  'n', '<Plug>(go-debug-next)'],
        \['nmap',           's', '<Plug>(go-debug-step)'],
    \]

    let g:go_debug_breakpoint_symbol=''
    let g:go_debug_current_line_symbol=''
    let g:go_debug_autoupdate_quickfix_breakpoints=1

    function! DebugNearestVimGo(cmd)
        " example a:cmd : go test -run 'TestAdd' ./.
        " has to be remapped to: ExtendedGoDebugTest ./. -test.run TestAdd/2_...
        let translation_map = {
            \'-run': '-test.run',
            \'-v': '-test.v',
        \}

        let cmd = split(a:cmd)[2:]
        let pkg_name = cmd[len(cmd)-1]

        let arglist = [pkg_name]
        let cmd = cmd[:len(cmd)-2]

        let prev = ''
        for arg in cmd
            if prev == '-run'
                let target = arg
                let target = substitute(target, "'*$", '', 'g') " trim trailing single quotes
                let target = substitute(target, "^'*", '', 'g') " trim leading single quotes

                let arglist = add(arglist, target)
                continue
            endif

            let arglist = add(arglist, get(translation_map, arg, arg))
            let prev = arg
        endfor

        let is_testing = 1
        call call('go_debug_extender#DebugTest', arglist)
    endfunction

    let g:test#custom_strategies = {'vimgo': function('DebugNearestVimGo')}
    let g:test#go#gotest#options = '-v'
    let g:test#go#gotest#options = {
        \ 'all':   '-v',
    \}

    nmap <silent> t<C-d> :TestNearest -strategy=vimgo<CR>
endfunction

function! myconfigs#haskell_settings()
    if get(g:, 'currently_sourced_filetype', 'none') == 'haskell'
        return
    endif
    let g:currently_sourced_filetype = 'haskell'

    let hs_highlight_delimiters = 1
    let hs_highlight_boolean = 1
    let hs_highlight_types = 1
    let hs_highlight_more_types = 1
    set sw=2 ts=2
endfunction

function! myconfigs#airline_settings()
    if get(g:, 'airline_settings_sourced', 0)
        return
    endif
    let g:airline_settings_sourced=1

    if !exists('w:airline_disabled')
        let w:airline_disabled = 1
    endif

    let g:airline#extensions#tabline#enabled = 0
    " themes: sierra peaksea ravenpower alduin seagull raven kolor  base16_classic
    let g:airline_theme='peaksea'
    let g:airline_powerline_fonts = 1
    let g:airline_exclude_preview = 0
    " let g:airline_statusline_ontop = 1
    let g:airline_focuslost_inactive = 1

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
endfunction

function! myconfigs#nerd_tree_settings()
    if get(g:, 'nerd_tree_settings_sourced', 0)
        return
    endif
    let g:nerd_tree_settings_sourced = 1

    nmap <Leader>f :NERDTreeToggle<CR>

    " TODO: experiment with removing DirArrow entirely
    let g:NERDTreeDirArrowExpandable = ' '
    let g:NERDTreeDirArrowCollapsible = ' '
    let g:NERDTreeShowHidden = 1
    let NERDTreeIgnore=['__pycache__$']
    let g:NERDTreeMouseMode = 3
    let g:NERDTreeWinSize = 40
    let g:NERDTreeCascadeSingleChildDir = 0
    let NERDTreeCascadeOpenSingleChildDir=0
    let g:NERDTreeAutoDeleteBuffer = 1
    let NERDTreeQuitOnOpen = 1

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

    " If nerdtree is the only window, close vim
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endfunction

