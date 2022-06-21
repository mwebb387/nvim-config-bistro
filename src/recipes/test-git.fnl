(import-macros {: defrecipe
                : defconfig
                : as-mode!
                : command!
                : map!
                : set!
                : setup!
                : use!} :recipe-macros)

(defrecipe :test-git)

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
  (as-mode! :signs)
  (setup!
    (fn [] ((. (require :gitsigns) setup)))))
