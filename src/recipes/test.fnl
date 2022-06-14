(import-macros {: defrecipe
                : defconfig
                : set!
                : map!
                : command!
                : use!} :recipe-macros)

(defrecipe :test)

(defconfig
  ; === Settings ===
  (set! hidden true)
  (set! number true)
  (set! showcmd false)
  (set! showmode false)

  ; Tab related settings
  (set! expandtab true)
  (set! autoindent true)
  (set! tabstop 2)
  (set! shiftwidth 2)

  ; Mouse
  (set! mouse :a)

  ; Path additions
  (set! path "C:/Users/mwebb/AppData/Local/nvim/lua" :append)

  ; Splits
  (set! splitbelow true)
  (set! splitright true)

  ; Searching
  (set! ignorecase true)
  (set! wildignore "obj/**,bin/**,node_modules/**")
  (set! grepprg "rg --vimgrep --no-heading --smart-case")
  (set! grepformat "%f:%l:%c:%m,%f:%l:%m")

  ; Better display for messages
  (set! cmdheight 2)

  (set! updatetime 300)

  ; Always show signcolumns
  (set! signcolumn "yes")

  (set! completeopt "menuone,preview,noinsert,noselect")
  (set! previewheight 5)


  ; === Maps ===
  (map! [:n] :H :^)
  (map! [:n] :L :$)
  (map! [:i] :jk :<esc>)
  (map! [:n] :<c-tab> ::b#<cr>)
  (map! [:n] :g<tab> ::b#<cr>)

  ; Window management
  (map! [:n :i] :<a-h> :<c-w>h)
  (map! [:n :i] :<a-j> :<c-w>j)
  (map! [:n :i] :<a-k> :<c-w>k)
  (map! [:n :i] :<a-l> :<c-w>l)
  (map! [:n :i] :<a-H> :<c-w>H)
  (map! [:n :i] :<a-J> :<c-w>J)
  (map! [:n :i] :<a-K> :<c-w>K)
  (map! [:n :i] :<a-L> :<c-w>L)
  (map! [:n :i] :<a-q> :<c-w>q)
  (map! [:t] :<a-h> :<c-\><c-n><c-w>h)
  (map! [:t] :<a-j> :<c-\><c-n><c-w>j)
  (map! [:t] :<a-k> :<c-\><c-n><c-w>k)
  (map! [:t] :<a-l> :<c-\><c-n><c-w>l)
  (map! [:t] :<a-q> :<c-\><c-n><c-w>q)
  (map! [:t] :<a-n> :<c-\><c-n>)

  ; General Insert mode
  (map! [:i] :<C-j> :<c-o>j)
  (map! [:i] :<C-k> :<c-o>k)
  (map! [:i] :<C-l> :<c-o>l)
  (map! [:i] :<C-h> :<c-o>h)


  ; === Commands ===
  (command! BrowseLua
            (fn []
              (let [root (vim.fn.stdpath :config)
                    lua-root (.. root "/lua")
                    cmd (.. "Explore " lua-root)]
                (vim.cmd cmd))))

  (command! EditConfig
            (fn []
              (let [root (vim.fn.stdpath :config)
                    file (.. root "/init.vim")
                    cmd (.."edit " file)]
                (vim.cmd cmd))))

  (command! Powershell
            (fn []
              (vim.cmd :enew)
              (vim.fn.termopen :powershell)))

  (command! PrettierCheck
            (fn []
              (vim.cmd "!npx prettier --check %")))

  (command! PrettierWrite
            (fn []
              (vim.cmd "!npx prettier --check --write %")))


  ; === Plugins ===
  (use! [:vim-scripts/utl.vim
         :jiangmiao/auto-pairs
         :tpope/vim-surround
         :tpope/vim-commentary
         :mattn/emmet-vim
         :junegunn/vim-slash
         :folke/which-key.nvim
         :kyazdani42/nvim-web-devicons]))

; (defconfig
;   {:type :default 
;    :name :default

;    :options {:hidden true
;              :number true
;              :showcmd false
;              :showmode false

;              ; Tab related settings
;              :expandtab true
;              :autoindent true
;              :tabstop 2
;              :shiftwidth 2

;              ; Mouse
;              :mouse :a

;              ; Path additions
;              :path ["C:/Users/mwebb/AppData/Local/nvim/lua" :append]

;              ; Splits
;              :splitbelow true
;              :splitright true

;              ; Searching
;              :ignorecase true
;              :wildignore "obj/**,bin/**,node_modules/**"
;              :grepprg "rg --vimgrep --no-heading --smart-case"
;              :grepformat "%f:%l:%c:%m,%f:%l:%m"

;              ; Better display for messages
;              :cmdheight 2

;              :updatetime 300

;              ; Always show signcolumns
;              :signcolumn "yes"

;              :completeopt "menuone,preview,noinsert,noselect"
;              :previewheight 5}

;    :keymaps [[[:n] :H :^]
;              [[:n] :L :$ ]
;              [[:i] :jk :<esc> ]
;              [[:n] :<c-tab> ::b#<cr> ]
;              [[:n] :g<tab> ::b#<cr> ]

;              ; Window management
;              [[:n :i] :<a-h> :<c-w>h ]
;              [[:n :i] :<a-j> :<c-w>j ]
;              [[:n :i] :<a-k> :<c-w>k ]
;              [[:n :i] :<a-l> :<c-w>l ]
;              [[:n :i] :<a-H> :<c-w>H ]
;              [[:n :i] :<a-J> :<c-w>J ]
;              [[:n :i] :<a-K> :<c-w>K ]
;              [[:n :i] :<a-L> :<c-w>L ]
;              [[:n :i] :<a-q> :<c-w>q ]
;              [[:t] :<a-h> :<c-\><c-n><c-w>h ]
;              [[:t] :<a-j> :<c-\><c-n><c-w>j ]
;              [[:t] :<a-k> :<c-\><c-n><c-w>k ]
;              [[:t] :<a-l> :<c-\><c-n><c-w>l ]
;              [[:t] :<a-q> :<c-\><c-n><c-w>q ]
;              [[:t] :<a-n> :<c-\><c-n> ]

;              ; General Insert mode
;              [[:i] :<C-j> :<c-o>j ]
;              [[:i] :<C-k> :<c-o>k ]
;              [[:i] :<C-l> :<c-o>l ]
;              [[:i] :<C-h> :<c-o>h ]]

;    :commands {:BrowseLua
;               (fn []
;                 (let [root (vim.fn.stdpath :config)
;                       lua-root (.. root "/lua")
;                       cmd (.. "Explore " lua-root)]
;                   (vim.cmd cmd)))

;               :EditConfig
;               (fn []
;                 (let [root (vim.fn.stdpath :config)
;                       file (.. root "/init.vim")
;                       cmd (.."edit " file)]
;                   (vim.cmd cmd)))

;               :Powershell
;               (fn []
;                 (vim.cmd :enew)
;                 (vim.fn.termopen :powershell))

;               :PrettierCheck
;               (fn []
;                 (vim.cmd "!npx prettier --check %"))

;               :PrettierWrite
;               (fn []
;                 (vim.cmd "!npx prettier --check --write %"))}

;    :plugins [:vim-scripts/utl.vim
;              :jiangmiao/auto-pairs
;              :tpope/vim-surround
;              :tpope/vim-commentary
;              :mattn/emmet-vim
;              :junegunn/vim-slash
;              :folke/which-key.nvim
;              :kyazdani42/nvim-web-devicons]})
