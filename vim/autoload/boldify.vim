function! boldify#boldify()
    hi Type                     cterm=bold
    hi Conditional              cterm=bold
    hi Function                 cterm=bold
    hi Structure                cterm=bold
    hi Define                   cterm=bold
    hi Keyword                  cterm=bold
    hi pythonInclude            cterm=bold
    hi pythonStatement          cterm=bold
    hi pythonSelf               cterm=bold
    hi Exception                cterm=bold
    hi goLabel                  cterm=bold
    hi goStatement              cterm=bold 
    hi goPredefinedIdentifiers  cterm=bold
endfunction

function! boldify#italicize()
    hi Comment          cterm=italic
endfunction

function! boldify#fix_colors()
    let g:base16_enabled=1
    let base16colorspace=256

    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background

        hi CursorLineNr ctermbg=none cterm=bold
        hi CursorLine ctermbg=1 ctermfg=3
        hi Normal ctermbg=none ctermfg=15
        hi Visual ctermbg=1 ctermfg=0
        hi LineNr ctermbg=none
        hi Folded ctermbg=NONE ctermfg=7
        hi VertSplit ctermbg=NONE ctermfg=0
        " hi StatusLine ctermbg=NONE ctermfg=2 cterm=bold
        " hi StatusLine ctermbg=NONE
        hi StatusLineNC ctermbg=NONE
        hi StatusLine ctermbg=1 ctermfg=3
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
        hi Comment ctermfg=8
        hi SignColumn ctermbg=NONE ctermfg=1
        hi LineNr ctermfg=59
        hi DiffAdd ctermbg=2 ctermfg=0
        hi DiffDelete ctermbg=1 ctermfg=0
        hi MatchParen ctermbg=none ctermfg=3
        hi Conditional ctermfg=3
        hi Keyword ctermfg=3
        hi Special ctermfg=5

        hi goRepeat ctermfg=5
        hi goStatement ctermfg=3
        hi goRepeat ctermfg=3
        hi goDeclaration ctermfg=3
        hi GoDebugCurrent ctermfg=16 ctermbg=0
        hi GoDebugBreakpoint ctermfg=4 ctermbg=0

        hi pMenu ctermfg=0 ctermbg=1
    endif
endfunction

function! boldify#MyGoDebugBreakpoint()
    call GoDebugBreakpoint()
    sign define godebugbreakpoint text=
endfunction
