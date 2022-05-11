(import-macros {: defrecipe : defmap } :macros)

(fn configure []
  ; Setup gitsigns
  (let [gitsigns (require :gitsigns)]
    (gitsigns.setup))

  ; Key maps
  (defmap [n] :<leader>G ":GV --all<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gg ":LazyGit<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true}))

(defrecipe git
  (default
    [:tpope/vim-fugitive
     :tommcdo/vim-fubitive
     :junegunn/gv.vim
     :lewis6991/gitsigns.nvim
     :kdheepak/lazygit.nvim]
    configure))

