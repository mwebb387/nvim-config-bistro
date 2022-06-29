(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defconfig
  (set-g! material_style "deep ocean")
  (set-g! material_italic_comments true)
  (set-g! material_borders true)

  (set! :termguicolors true)

  (use! [:tomasiser/vim-code-dark
         :theniceboy/nvim-deus
         :whatyouhide/vim-gotham
         :ntk148v/vim-horizon
         :nightsense/cosmic_latte
         :Nequo/vim-allomancer
         :folke/tokyonight.nvim
         :marko-cerovac/material.nvim
         :nanotech/jellybeans.vim
         :crater2150/vim-theme-chroma
         :EdenEast/nightfox.nvim
         :wojciechkepka/bogster
         :bluz71/vim-nightfly-guicolors
         :akai54/2077.nvim])

  (setup! (fn [] (vim.cmd (.. "colorscheme " :material)))))
