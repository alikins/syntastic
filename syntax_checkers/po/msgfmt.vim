"============================================================================
"File:        msgfmt.vim
"Description: po file checker with msgfmt -c
"Maintainer:  Miller Medeiros <contact at millermedeiros dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"============================================================================

function! SyntaxCheckers_po_msgfmt_IsAvailable()
    return executable('msgfmt')
endfunction

function! SyntaxCheckers_po_msgfmt_GetLocList()
    let makeprg = syntastic#makeprg#build({
                \ 'exe': 'msgfmt',
                \ 'args': '-c',
                \ 'tail': '| grep -v ^msgfmt',
                \ 'subchecker': 'msgfmt' })
    " as.po:4: header field `Project-Id-Version' still has the initial default value
    " as.po:31: `msgid' and `msgstr' entries do not both end with '\n'
    let errorformat = '%f:%l:\ %m'
    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'po',
    \ 'name': 'msgfmt'})
