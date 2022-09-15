(import-macros {: defconfig} :recipe-macros)

(defconfig
  (set! :termguicolors true)

  (use! [:RRethy/nvim-base16])

  (setup! (fn [] (vim.cmd (.. "colorscheme " :base16-dracula)))))
