(import-macros {: defrecipe : defmap } :macros)

(fn plugins []
 [:tpope/vim-fugitive
  :tommcdo/vim-fubitive
  ; :airblade/vim-gitgutter
  :junegunn/gv.vim])

(fn configure []
  (defmap [n] :<leader>G ":GV --all<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gg ":Git<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true}))

{: configure
 : plugins
 :prepare (defrecipe
            (default
              [:tpope/vim-fugitive
               :tommcdo/vim-fubitive
               ; :airblade/vim-gitgutter
               :junegunn/gv.vim]
              configure))}

