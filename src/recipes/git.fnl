(import-macros {: defrecipe : defmap } :macros)

(fn configure []
  (defmap [n] :<leader>G ":GV --all<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gg ":Git<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true}))

(defrecipe git
  (default
    [:tpope/vim-fugitive
     :tommcdo/vim-fubitive
     ; :airblade/vim-gitgutter
     :junegunn/gv.vim]
    configure))

