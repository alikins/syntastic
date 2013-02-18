"============================================================================
"File:        pyqver.vim
"Description: python version check (pyqver) plugin for syntastic.vim
"Authors:     Adrian Likins <adrian@likins.com>
"
"============================================================================

" pyqver has a 'pyqver2' and a 'pyqver3'. If you only
" have python2.x, use pyqver2. pyqver3 should work for
" python2 and python3 code, but needs a python3 runtime
if !exists("g:syntastic_python_pyqver_version")
    let g:syntastic_python_pyqver_version = 'pyqver2'
endif

"
" min-version of python the code being checked supports.
" Note this is the version number of the first version
" of python that you can use, not
" the last version of the python that should raise errors
"
" Note this sets what version of python requirement to
" consider acceptable for  the code being checked, while
" 'g:syntastic_python_pyqver_version' determines which
" version of the tool itself to use.
"
"  ie, the default uses pyqver2 (using python2 runtime)
"  to check the code being edited. If the
"  g:syntastic_python_pyqver_min_version is 2.5, then
"  adding a 'with' statement for example, will cause
"  the line to be considered a syntax error
if !exists("g:syntastic_python_pyqver_min_version")
    let g:syntastic_python_pyqver_min_version = '2.5'
endif

function! SyntaxCheckers_python_pyqver_IsAvailable()
    return executable(g:syntastic_python_pyqver_version)
endfunction


function! SyntaxCheckers_python_pyqver_GetLocList()
    let makeprg = syntastic#makeprg#build({
                \ 'exe': g:syntastic_python_pyqver_version,
                \ 'args': '-l --min-version ' . g:syntastic_python_pyqver_min_version,
                \ 'subchecker': 'pyqver' })


    " sample error line from pyqver
    " managercli.py:496:2.4:  function decorator
    let errorformat = "%f:%l:%m"

    return SyntasticMake({ 'makeprg': makeprg,
                         \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'python',
    \ 'name': 'pyqver'})
