(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defrecipe :test-files)

(defconfig
  ; === Maps ===
  (map! [:n] :<leader>e ":NvimTreeToggle<CR>")
  ;(map! [:n] :- ":NvimTreeFindFile<CR>")
  (map! [:n] :- ":Vifm<CR>")
  (map! [:n] :<leader>v ":Vifm<CR>")


  ; === Plugins ===
  (use! [:kyazdani42/nvim-tree.lua
         [:vifm/vifm.vim {:on :Vifm}]])

  ; === Setup ===
  (setup!
    (fn [] ((. (require :nvim-tree) setup) {:disable_netrw false}))))
