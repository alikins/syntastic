"============================================================================
"File:        pyqver.vim
"Description: Syntax checking plugin for syntastic.vim
"Authors:     Martin Grenfell <martin.grenfell@gmail.com>
"             kstep <me@kstep.me>
"             Parantapa Bhattacharya <parantapa@gmail.com>
"
"============================================================================
function! SyntaxCheckers_kickstart_ksvalidator_IsAvailable()
    return executable('ksvalidator')
endfunction


function! SyntaxCheckers_kickstart_ksvalidator_GetLocList()
    let makeprg = syntastic#makeprg#build({
                \ 'exe': 'ksvalidator',
                \ 'args': '-v RHEL3',
                \ 'subchecker': 'ksvalidator' })
    "managercli.py:496: 2.4 function decorator
    "let errorformat = "%f:%l:\ %m"
    "let errorformat = '%E%f:%l: could not compile,%-Z%p^,%E%f:%l:%c: %m,%E%f:%l: %m,%-G%.%#'
    "The following problem occurred on line 7 of the kickstart file:
    "
    "no such option: --noipv6
    "
    "The following problem occurred on line 10 of the kickstart file:
    "
    "Unknown command: selinux
    "
    "The following problem occurred on line 12 of the kickstart file:
    "
    "no such option: --service
    "
    "The following problem occurred on line 17 of the kickstart file:
    "
    "no such option: --this-isn-an
    let errorformat = "%EThe\ following\ problem\ occurred\ on\ line\ %l\ of\ the\ kickstart\ file:,%C,%C%m"

    return SyntasticMake({ 'makeprg': makeprg,
                         \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'kickstart',
    \ 'name': 'ksvalidator'})
