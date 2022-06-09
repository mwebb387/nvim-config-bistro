{:type :default 
 :name :default

 :options [hidden
           number
           noshowcmd
           noshowmode

           ; Tab related settings
           expandtab
           autoindent
           [tabstop 2]
           [shiftwidth 2]

           ; Mouse
           [mouse :a]

           ; Path additions
           [path "C:/Users/mwebb/AppData/Local/nvim/lua" :append]

           ; Splits
           splitbelow
           splitright

           ; Searching
           ignorecase
           [wildignore "obj/**,bin/**,node_modules/**"]
           [grepprg "rg --vimgrep --no-heading --smart-case"]
           [grepformat "%f:%l:%c:%m,%f:%l:%m"]

           ; Better display for messages
           [cmdheight 2]

           [updatetime 300]

           ; Always show signcolumns
           [signcolumn "yes"]

           [completeopt "menuone,preview,noinsert,noselect"]
           [previewheight 5]]

 :keymaps [[[n] :H :^]
           [[n] :L :$ ]
           [[i] :jk :<esc> ]
           [[n] :<c-tab> ::b#<cr> ]
           [[n] :g<tab> ::b#<cr> ]

           ; Window management
           [[n i] :<a-h> :<c-w>h ]
           [[n i] :<a-j> :<c-w>j ]
           [[n i] :<a-k> :<c-w>k ]
           [[n i] :<a-l> :<c-w>l ]
           [[n i] :<a-H> :<c-w>H ]
           [[n i] :<a-J> :<c-w>J ]
           [[n i] :<a-K> :<c-w>K ]
           [[n i] :<a-L> :<c-w>L ]
           [[n i] :<a-q> :<c-w>q ]
           [[t] :<a-h> :<c-\><c-n><c-w>h ]
           [[t] :<a-j> :<c-\><c-n><c-w>j ]
           [[t] :<a-k> :<c-\><c-n><c-w>k ]
           [[t] :<a-l> :<c-\><c-n><c-w>l ]
           [[t] :<a-q> :<c-\><c-n><c-w>q ]
           [[t] :<a-n> :<c-\><c-n> ]

           ; General Insert mode
           [[i] :<C-j> :<c-o>j ]
           [[i] :<C-k> :<c-o>k ]
           [[i] :<C-l> :<c-o>l ]
           [[i] :<C-h> :<c-o>h ]]

 :commands [[:BrowseLua
             (fn []
               (let [root (vim.fn.stdpath :config)
                     lua-root (.. root "/lua")
                     cmd (.. "Explore " lua-root)]
                 (vim.cmd cmd))) ]

            [:EditConfig
             (fn []
               (let [root (vim.fn.stdpath :config)
                     file (.. root "/init.vim")
                     cmd (.."edit " file)]
                 (vim.cmd cmd))) ]

            [:Powershell
             (fn []
               (vim.cmd :enew)
               (vim.fn.termopen :powershell)) ]

            [:PrettierCheck
             (fn []
               (vim.cmd "!npx prettier --check %")) ]

            [:PrettierWrite
             (fn []
               (vim.cmd "!npx prettier --check --write %"))]]

 :plugins [:vim-scripts/utl.vim
           :jiangmiao/auto-pairs
           :tpope/vim-surround
           :tpope/vim-commentary
           :mattn/emmet-vim
           :junegunn/vim-slash
           :folke/which-key.nvim
           :kyazdani42/nvim-web-devicons]}
