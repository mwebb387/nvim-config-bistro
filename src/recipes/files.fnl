(import-macros {: defrecipe
                : defmap
                : let-g}
               :macros)

(fn configure []
  ; TODO: Silent
  (let [tree (require :nvim-tree)]
    (tree.setup {:disable_netrw false}))
  (defmap [n] :<F1> ":NvimTreeToggle<CR>")
  (defmap [n] :- ":NvimTreeFindFile<CR>"))


(defrecipe
  (default [:kyazdani42/nvim-tree.lua] configure))
