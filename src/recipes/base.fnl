(import-macros {: defconfig} :recipe-macros)

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

  ; Default Omnifunc
  (set! omnifunc :syntaxcomplete#Complete)

  ;Emmet settings (move to other recipe later...)
  (set-g! user_emmet_leader_key :<A-y>)
  (set-g! user_emmet_complete_tag 1)

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
  (map! [:n :i] :<a-w> :<c-w>w)
  (map! [:t] :<a-h> :<c-\><c-n><c-w>h)
  (map! [:t] :<a-j> :<c-\><c-n><c-w>j)
  (map! [:t] :<a-k> :<c-\><c-n><c-w>k)
  (map! [:t] :<a-l> :<c-\><c-n><c-w>l)
  (map! [:t] :<a-q> :<c-\><c-n><c-w>q)
  (map! [:t] :<a-w> :<c-\><c-n><c-w>w)
  (map! [:t] :<a-n> :<c-\><c-n>)

  ; Next/Previous maps
  (map! [:n] "]b" ":bnext")
  (map! [:n] "[b" ":bprevious")
  (map! [:n] "]t" ":tabnext")
  (map! [:n] "[t" ":tabprevious")
  (map! [:n] "]w" :<c-w>w)
  (map! [:n] "[w" :<c-w>W)
  (map! [:n] "]q" ":cnext")
  (map! [:n] "[q" ":cprevious")
  (map! [:n] "]l" ":lnext")
  (map! [:n] "[l" ":lprevious")

  ; General Insert mode
  (map! [:i] :<C-j> :<c-o>j)
  (map! [:i] :<C-k> :<c-o>k)
  (map! [:i] :<C-l> :<c-o>l)
  (map! [:i] :<C-h> :<c-o>h)

  ; Other fancy things
  (map! [:n] "<M-`>" ":NextTerminal<CR>")
  (map! [:t] "<M-`>" :<c-\><c-n><c-w><c-q>)


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

  (command! NextTerminal
            (fn []
              (vim.cmd :20new)
              (let [{: filter} (require :util)
                    term-bufs (-> (vim.api.nvim_list_bufs)
                                  (filter (fn [v]
                                            (string.find
                                              (vim.api.nvim_buf_get_name v)
                                              "term://"))))
                    terms (> (length term-bufs) 0)]
                (if terms
                  (vim.api.nvim_win_set_buf 0 (. term-bufs 1))
                  (vim.fn.termopen :powershell)))))

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

