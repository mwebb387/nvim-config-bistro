(import-macros {: defmap
                : let-g}
               :macros)

(fn plugins []
  [:kyazdani42/nvim-tree.lua])

(fn configure []
  (let-g :nvim_tree_disable_netrw 0)
  (let-g :nvim_tree_hijack_netrw 1)

  (defmap [n] :- ":Explore<CR>")
  ; TODO: Silent
  (defmap [n] :<leader>f ":NvimTreeToggle<CR>"))

{: configure : plugins }
