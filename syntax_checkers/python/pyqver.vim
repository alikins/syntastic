"============================================================================
"File:        pyqver.vim
"Description: Syntax checking plugin for syntastic.vim
"Authors:     Martin Grenfell <martin.grenfell@gmail.com>
"             kstep <me@kstep.me>
"             Parantapa Bhattacharya <parantapa@gmail.com>
"
"============================================================================
function! SyntaxCheckers_python_pyqver_IsAvailable()
    return executable('pyqver2')
endfunction


function! SyntaxCheckers_python_pyqver_GetLocList()
    let makeprg = syntastic#makeprg#build({
                \ 'exe': 'pyqver2',
                \ 'args': '-l --min-version 2.2',
                \ 'subchecker': 'pyqver' })
    "managercli.py:496: 2.4 function decorator
    let errorformat = "%f:%l:\ %m"
    "let errorformat = '%E%f:%l: could not compile,%-Z%p^,%E%f:%l:%c: %m,%E%f:%l: %m,%-G%.%#'

    return SyntasticMake({ 'makeprg': makeprg,
                         \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'python',
    \ 'name': 'pyqver'})
