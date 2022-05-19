(import-macros {: defrecipe : defmap } :macros)

(fn configure []
  ; Key maps
  (defmap [n] :<leader>G ":GV --all<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gg ":LazyGit<CR>" {:noremap true :silent true})
  (defmap [n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true}))


(fn configure-signs []
  ; Setup gitsigns
  (let [gitsigns (require :gitsigns)]
    (gitsigns.setup)))


(defrecipe git
  (default [:tpope/vim-fugitive
            :tommcdo/vim-fubitive
            :junegunn/gv.vim
            :kdheepak/lazygit.nvim]
    configure)
  (option :signs [{1 :lewis6991/gitsigns.nvim :config configure-signs}]))

