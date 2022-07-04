(import-macros {: defconfig} :recipe-macros)

(defconfig
  ; === Maps ===
  (map! [:n] :- ":Explore<CR>"))

(defconfig
  (as-mode! :nvimtree)

  (map! [:n] :<leader>e ":NvimTreeToggle<CR>")

  ; === Plugins ===
  (use! [:kyazdani42/nvim-tree.lua ])

  (setup!
    (fn [] ((. (require :nvim-tree) :setup) {:disable_netrw false}))))

(defconfig
  (as-mode! :dirvish)

  (map! [:n] :<leader>d ":Dirvish<CR>")
  (map! [:n] :- ":Dirvish %<CR>")

  (use! [:justinmk/vim-dirvish]))

(defconfig
  (as-mode! :vifm)

  (map! [:n] :<leader>v ":Vifm<CR>")

  (use! [[:vifm/vifm.vim {:on :Vifm}]]))
