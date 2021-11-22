(import-macros {: defmap
                : let-g}
               :macros)

(fn plugins []
  [:kyazdani42/nvim-tree.lua])

(fn configure []
  ; TODO: Silent
  (let [tree (require :nvim-tree)]
    (tree.setup))
  (defmap [n] :<leader>f ":NvimTreeToggle<CR>")
  (defmap [n] :- ":NvimTreeFindFile<CR>"))

{: configure : plugins }
