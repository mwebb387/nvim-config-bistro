(import-macros {: defconfig} :recipe-macros)

(defconfig
  ; === Maps ===
  (map! [:n] :<leader>G ":GV --all<CR>" {:noremap true :silent true})
  (map! [:n] :<leader>gg ":LazyGit<CR>" {:noremap true :silent true})
  (map! [:n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true})


  ; === Plugins ===
  (use! [:tpope/vim-fugitive
         :tommcdo/vim-fubitive
         [:junegunn/gv.vim {:on :GV}]
         [:kdheepak/lazygit.nvim {:on :LazyGit}]]))

(defconfig
  (as-option! :signs)

  (use! [:lewis6991/gitsigns.nvim])

  (setup!
    (fn [] ((. (require :gitsigns) :setup)))))
