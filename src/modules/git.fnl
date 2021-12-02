(import-macros {: defmap } :macros)

(fn plugins []
 [:tpope/vim-fugitive
  :tommcdo/vim-fubitive
  :junegunn/gv.vim])

(fn configure []
  (defmap [n] :<leader>G ":GV --all<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gg ":Git<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gP ":Git push<CR>" {:noremap true :silent true}))

{: configure : plugins}
