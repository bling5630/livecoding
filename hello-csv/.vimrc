map <leader>b :execute '!clear && stack build'<CR>
map <leader>c :execute '!clear && stack clean'<CR>
map <leader>i :execute '!clear && stack ghci'<CR>
map <leader>r :execute '!clear && stack build && clear && stack exec hello-csv-app'<CR>
map <leader>t :execute '!clear && stack test'<CR>
