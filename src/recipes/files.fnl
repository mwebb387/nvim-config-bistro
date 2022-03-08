(import-macros {: defrecipe
                : defmap
                : let-g}
               :macros)

(fn plugins []
  [:kyazdani42/nvim-tree.lua])

(fn configure []
  ; TODO: Silent
  (let [tree (require :nvim-tree)]
    (tree.setup {:disable_netrw false}))
  (defmap [n] :<F1> ":NvimTreeToggle<CR>")
  (defmap [n] :- ":NvimTreeFindFile<CR>"))

{: configure
 : plugins
 :prepare (defrecipe
            (default [:kyazdani42/nvim-tree.lua] configure))}
