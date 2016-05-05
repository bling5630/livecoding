"" build project with profiling
map <leader>p :exe '!clear && stack build --executable-profiling --library-profiling --ghc-options="-rtsopts"'<CR>
map <leader>P :exe '!clear && stack exec program-structure-app -- +RTS -sstderr'<CR>
"" build for threadscope with eventlog
map <leader>e :exe '!clear && stack build --ghc-options="-eventlog -rtsopts"'<CR>
map <leader>E :exe '!clear && stack exec program-structure-app -- +RTS -N2 -l'<CR>
"" build - build project
map <leader>b :exe '!clear && stack build'<CR>
"" clean - clean build artifacts
map <leader>c :exe '!clear && stack clean'<CR>
"" interactive - load modules in repl
map <leader>i :exe '!clear && stack ghci'<CR>
"" run - run program
map <leader>r :exe '!clear && stack build && clear && stack exec program-structure-app'<CR>
"" spec - run specs
map <leader>s :exe '!clear && stack test'<CR>
"" spec - run specs


" HASKTAGS
"   - jump to tag
noremap <leader>t "zyiw:exe 'tag '.@z<CR>
"   - generate tags
noremap <leader>T :exe '!clear && hasktags --ctags ./src ./app'<CR>
"   - return from tag
noremap <leader>z :exe 'pop'<CR>


"
" HDEVTOOLS
"   - show type under cursor
noremap <F5> :HdevtoolsType<CR>
"   - clear type info


" HOOGLE
"   - search hoogle 
noremap <F6> :Hoogle<CR>
"   - clear search 
noremap <S-F6> :HoogleClose<CR>


"
" HLINT
"   - lint current file
map <F7> "zyiw:exe '!clear && stack exec hlint -- -c=auto -s '.@%<CR>
