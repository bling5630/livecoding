"" build - build project
map <leader>b :exe '!clear && stack build'<CR>
"" clean - clean build artifacts
map <leader>c :exe '!clear && stack clean'<CR>
"" find - lookup where a symbol is defined
map <leader>f "zyiw:exe '!clear && ghc-mod info '.@%.' '.@z<CR>
"" hoogle - search for contents of register 0 (can't include end of line)
map <leader>h :exe '!clear && hoogle "'.@0.'"'<CR>
"" interactive - load modules in repl
map <leader>i :exe '!clear && stack ghci'<CR>
"" lint - lint current file
map <leader>l "zyiw:exe '!clear && hlint -c=auto -s '.@%<CR>
"" run - run program
map <leader>r :exe '!clear && stack build && clear && stack exec hello-my-list-app'<CR>
"" spec - run specs
map <leader>s :exe '!clear && stack test'<CR>
"" tags - jump to tag
map <leader>t "zyiw:exe 'tag '.@z<CR>
"" tags - generate tags
map <leader>T :exe '!clear && hasktags --ctags ./src'<CR>
"" undo - return from tag
map <leader>z :exe 'pop'<CR>
