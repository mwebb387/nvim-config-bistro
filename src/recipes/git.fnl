(import-macros {: defconfig} :recipe-macros)

(defconfig
  ; === Maps ===
  (map! [:n] :<leader>G ":GV --all<CR>" {:noremap true :silent true})
  (map! [:n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true})

  ; === Plugins ===
  (use! [:tpope/vim-fugitive
         :tommcdo/vim-fubitive
         [:junegunn/gv.vim {:on :GV}]]))

(defconfig
  (as-option! :neogit)

  (use! [:TimUntersberger/neogit])
  
  (setup!
    (fn [] ((. (require :neogit) :setup)))))

(defconfig
  (as-option! :lazygit)

  (use! [[:kdheepak/lazygit.nvim {:on :LazyGit}]])

  (map! [:n] :<leader>gg ":LazyGit<CR>" {:noremap true :silent true}))

(defconfig
  (as-option! :signs)

  (use! [:lewis6991/gitsigns.nvim])

  (setup!
    (fn [] ((. (require :gitsigns) :setup)))))

(defconfig
  (as-option! :diffview)

  (use! [:sindrets/diffview.nvim]))
