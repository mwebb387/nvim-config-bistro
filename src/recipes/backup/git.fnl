(import-macros {: defrecipe : defmap } :macros)

(fn configure []
  ; Key maps
  (defmap [:n] :<leader>G ":GV --all<CR>" {:noremap true :silent true})
  (defmap [:n] :<leader>gg ":LazyGit<CR>" {:noremap true :silent true})
  (defmap [:n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true}))


(fn configure-signs []
  ; Setup gitsigns
  (let [gitsigns (require :gitsigns)]
    (gitsigns.setup)))


(defrecipe git
  (default
    [:tpope/vim-fugitive
     :tommcdo/vim-fubitive
     [:junegunn/gv.vim {:on :GV}]
     [:kdheepak/lazygit.nvim {:on :LazyGit}]]
    configure)
  (option :signs [:lewis6991/gitsigns.nvim] configure-signs))

