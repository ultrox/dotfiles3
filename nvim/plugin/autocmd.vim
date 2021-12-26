"ts = 'number of spaces that <Tab> in file uses'
"sts = 'number of spaces that <Tab> uses while editing'
"sw = 'number of spaces to use for (auto)indent step'
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab
autocmd Filetype php setlocal ts=4 sw=4 sts=4
autocmd Filetype twig setlocal ts=4 sw=4 sts=4
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype vue setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype yml setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype cs setlocal ts=2 sw=2 expandtab!
autocmd Filetype python setlocal ts=4 sw=4 sts=4 expandtab autoindent fileformat=unix

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup USER_DK
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
