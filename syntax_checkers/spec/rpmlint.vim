"============================================================================
"File:        rpmlint.vim
"Description: rpmspec file checking with rpm lint
"Maintainer:  Miller Medeiros <contact at millermedeiros dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"============================================================================

" rpmlint is a tool for checking for common errors in rpm spec files.
"   upstream versions can be found at:
"       http://sourceforge.net/p/rpmlint/wiki/Home/
"
"  Most rpm based distro's have rpmlint packages

function! SyntaxCheckers_spec_rpmlint_IsAvailable()
    return executable('rpmlint')
endfunction

function! SyntaxCheckers_spec_rpmlint_GetLocList()
    let makeprg = syntastic#makeprg#build({
                \ 'exe': 'rpmlint',
                \ 'subchecker': 'rpmlint' })

    " sample output
    "/home/adrian/src/subscription-manager/subscription-manager.spec:191: E:
    "hardcoded-library-path in %{_prefix}/lib/yum-plugins/product-id.py*
    "subscription-manager.spec: W: invalid-url Source0: subscription-manager-1.8.2.tar.gz

    let errorformat = '%f:%l:\ %t:\ %m,%f:\ %t:\ %m'
    "let errorformat = '%E%f:%l: could not compile,%-Z%p^,%E%f:%l:%c: %m,%E%f:%l: %m,%-G%.%#'
    "let errorformat = '%ELine %l:%c,%Z\\s%#Reason: %m,%C%.%#,%f: line %l\, col %c\, %m,%-G%.%#'
    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'spec',
    \ 'name': 'rpmlint'})
