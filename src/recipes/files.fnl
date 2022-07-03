(import-macros {: defconfig} :recipe-macros)

(defconfig
  ; === Maps ===
  (map! [:n] :<leader>e ":NvimTreeToggle<CR>")
  ;(map! [:n] :- ":NvimTreeFindFile<CR>")
  ; (map! [:n] :- ":Vifm<CR>")
  (map! [:n] :- ":Explore<CR>")


  ; === Plugins ===
  (use! [:kyazdani42/nvim-tree.lua ])

  ; === Setup ===
  (setup!
    (fn [] ((. (require :nvim-tree) :setup) {:disable_netrw false}))))

(defconfig
  (as-mode! :vifm)

  (map! [:n] :<leader>v ":Vifm<CR>")

  (use! [[:vifm/vifm.vim {:on :Vifm}]]))
