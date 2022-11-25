(import-macros {: defconfig} :recipe-macros)

(defconfig
  (set! :termguicolors true)

  (use! [:RRethy/nvim-base16
         :EdenEast/nightfox.nvim])

  (setup! (fn [] (vim.cmd (.. "colorscheme " :base16-catppuccin)))))
