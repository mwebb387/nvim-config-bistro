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
  (set! wildignore "obj/**,bin/**,node_modules/**,CMS/**")
  (set! grepprg "rg --vimgrep --no-heading --smart-case --")
  (set! grepformat "%f:%l:%c:%m,%f:%l:%m")

  ; Better display for messages
  (set! cmdheight 2)

  (set! updatetime 300)

  ; Always show signcolumns
  (set! signcolumn "yes")

  (set! completeopt "menuone,noinsert,noselect")
  (set! previewheight 5)

  ; Default Omnifunc
  (set! omnifunc :syntaxcomplete#Complete)

  ;Emmet settings (move to other recipe later...)
  (set-g! user_emmet_leader_key :<A-y>)
  ; (set-g! user_emmet_complete_tag 1)

  ; === Maps ===
  (map! [:n] :H :^)
  (map! [:n] :L :$)
  (map! [:i] :jk :<esc>)
  (map! [:n] :<c-tab> ::b#<cr>)
  (map! [:n] :g<tab> ::b#<cr>)

  ; Window management
  (map! [:t] :<a-n> :<c-\><c-n>)

  ; Next/Previous maps
  (map! [:n] "]b" ":bnext<CR>")
  (map! [:n] "[b" ":bprevious<CR>")
  (map! [:n] "]t" ":tabnext<CR>")
  (map! [:n] "[t" ":tabprevious<CR>")
  (map! [:n] "]q" ":cnext<CR>")
  (map! [:n] "[q" ":cprevious<CR>")
  (map! [:n] "]l" ":lnext<CR>")
  (map! [:n] "[l" ":lprevious<CR>")
  (map! [:n] "]w" :<c-w>w)
  (map! [:n] "[w" :<c-w>W)

  ; Toggles
  (map! [:n] :<leader>s (fn []
                      (set vim.o.spell (not vim.o.spell))
                      (if vim.o.spell
                        (print "Spell ON")
                        (print "Spell OFF"))))

  (map! [:n] :<leader>r (fn [] (set vim.o.relativenumber (not vim.o.relativenumber))))

  ; Buffers and file finding
  (map! [:n] :<leader>b ":buffer ")
  (map! [:n] :<leader>p ":Fd ")
  (map! [:n] :<leader>q ":copen<CR>")
  (map! [:n] :<c-p> ":FdList ")
  (map! [:n] :<c-h> ":HopChar1MW<CR>")
  (map! [:n] :<leader>/ ":Rg ")

  ; General Insert mode
  (map! [:i] :<C-j> :<c-o>j)
  (map! [:i] :<C-k> :<c-o>k)
  (map! [:i] :<C-l> :<c-o>l)
  (map! [:i] :<C-h> :<c-o>h)

  ; Template mappings
  (map! [:n] :<a-t>l ":TemplateLoad ")
  (map! [:n] :<a-t>e ":TemplateExpand ")

  (map! [:n] :<leader>aa ":argadd | argdedupe<CR>" {:silent true})
  (map! [:n] :<leader>ad ":argd<CR>" {:silent true})
  (map! [:n] :<leader>aD ":%argd<CR>" {:silent true})
  (map! [:n] :<leader>al ":arglocal<CR>" {:silent true})
  (map! [:n] :<leader>ag ":argglobal" {:silent true})
  (map! [:n] :<leader>A
        (fn [] (let [get-args (fn []
                                (let [args []]
                                  (for [i 0 (vim.fn.argc)]
                                    (table.insert args (vim.fn.argv i)))
                                  args))
                     fzfOpts {:sink (fn [item] (vim.cmd (.. "argedit " item " | argdedupe")))
                              :source (get-args)
                              :options [:--preview
                                        vim.g.fzf_bat_options
                                        :--bind
                                        "ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"]}]
                          (vim.fn.fzf#run (vim.fn.fzf#wrap fzfOpts)))))

  (map! [:n] :<leader>1 ":argument 1<CR>")
  (map! [:n] :<leader>2 ":argument 2<CR>")
  (map! [:n] :<leader>3 ":argument 3<CR>")
  (map! [:n] :<leader>4 ":argument 4<CR>")
  (map! [:n] :<leader>5 ":argument 5<CR>")
  (map! [:n] :<leader>6 ":argument 6<CR>")
  (map! [:n] :<leader>7 ":argument 7<CR>")
  (map! [:n] :<leader>8 ":argument 8<CR>")
  (map! [:n] :<leader>9 ":argument 9<CR>")
  (map! [:n] :<leader>0 ":argument 10<CR>")

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

  (command! PrettierCheck
            (fn []
              (vim.cmd "!npx prettier --check %")))

  (command! PrettierWrite
            (fn []
              (vim.cmd "!npx prettier --check --write %")))

  (command! FdList
            (fn [input]
              (let [{: args} input
                    {: map} (require :util)
                    cmd (.. "fd " args)]
                (-> cmd
                    (vim.fn.systemlist)
                    (map (fn [path] {:filename path
                                     :lnum 0}))
                    (vim.fn.setqflist))
                (vim.cmd :copen)))
            {:nargs 1})

  (command! Fd
            (fn [input]
              (let [{: args} input
                    {: map} (require :util)
                    cmd (.. "edit " args)]
                (vim.cmd cmd)))
            {:complete (fn [A L P]
                         (let [cmd (.. "fd " A)]
                           (vim.fn.systemlist cmd)))
             :nargs 1})

  (command! Mk 
            (fn [input]
              (let [{: args} input
                    cmd (.. "cexpr system('"
                            vim.o.makeprg
                            " "
                            args
                            "')")]
                (vim.cmd cmd)
                (vim.cmd "cwindow")))
            {:nargs "?"})

  (command! Rg
            (fn [input]
              (let [{: args} input
                    cmd (.. "cexpr system('"
                            vim.o.grepprg
                            " "
                            args
                            "')")]
                (vim.cmd cmd)
                (vim.cmd "cwindow")))
            {:nargs 1})

  (command! TemplateLoad
            (fn [input]
              (let [{: args} input
                    home (vim.fn.expand "~")
                    templateRoot "/.nvim-templates/"
                    template (.. home templateRoot args)]
                (vim.cmd (.. "r " template))))
            {:complete (fn [A L P]
                         (let [{: map} (require :util)
                               home (vim.fn.expand "~")
                               templateRootGlob "/.nvim-templates/*"
                               filesStr (vim.fn.glob (.. home templateRootGlob))
                               fileLst (vim.fn.split filesStr "\n")
                               fileNameLst (map fileLst (fn [path] (vim.fn.fnamemodify path ":t")))]
                           fileNameLst))
             :nargs 1})

  (command! TemplateExpand
            (fn [input]
              (let [findMaxRep (fn []
                                 (let [lines (vim.api.nvim_buf_get_lines 0 0 -1 true)
                                       contents (vim.fn.join lines)]
                                   (var max 1)
                                   (while (string.find contents (.. "$" max))
                                     (set max (+ 1 max)))
                                   (- max 1)))
                    doReps (fn [maxReps]
                             (for [i 1 maxReps]
                               (let [replace (vim.fn.input (.. :$ i "-> "))]
                                 (when (> (length replace) 0)
                                   (vim.cmd (.. "%s/$" i "/" replace))))))]
                ; (print (.. "Max reps: " (findMaxRep)))
                (doReps (findMaxRep)))))




  ; === Plugins ===
  (use! [:vim-scripts/utl.vim
         :nvim-lua/popup.nvim
         :nvim-lua/plenary.nvim
         :jiangmiao/auto-pairs
         :mbbill/undotree
         :kylechui/nvim-surround
         :tpope/vim-commentary
         :mattn/emmet-vim
         :junegunn/vim-slash
         :folke/which-key.nvim
         :stevearc/dressing.nvim
         :kyazdani42/nvim-web-devicons
         :kevinhwang91/nvim-bqf
         :phaazon/hop.nvim]) ; Testing - Move to separate file once tested
  
  (setup! (fn [] (let [wk (require :which-key)
                       hop (require :hop)
                       surround (require :nvim-surround)]
                   (wk.setup)
                   (hop.setup)
                   (surround.setup)))))

