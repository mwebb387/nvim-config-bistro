(import-macros {: defconfig} :recipe-macros)

(defconfig
  (set! :termguicolors true)

  (use! [:RRethy/nvim-base16
         :EdenEast/nightfox.nvim
         :talha-akram/noctis.nvim])

  (setup! (fn [] (vim.cmd (.. "colorscheme " :nightfox)))))
