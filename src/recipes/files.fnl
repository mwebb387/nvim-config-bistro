(import-macros {: defrecipe
                : defmap
                : let-g}
               :macros)

(fn configure []
  ; TODO: Silent
  (let [tree (require :nvim-tree)]
    (tree.setup {:disable_netrw false}))
  (defmap [n] :<leader>e ":NvimTreeToggle<CR>")
  ;(defmap [n] :- ":NvimTreeFindFile<CR>")
  (defmap [n] :- ":Vifm<CR>")
  (defmap [n] :<leader>v ":Vifm<CR>"))


(defrecipe files
  (default [:kyazdani42/nvim-tree.lua
            :vifm/vifm.vim]
    configure))
