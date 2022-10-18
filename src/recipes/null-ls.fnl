(import-macros {: defconfig} :recipe-macros)

(defconfig
  (use! [:jose-elias-alvarez/null-ls.nvim])
  
  (setup!
    (fn [] (let [nullls (require :null-ls)]
             (nullls.setup {:sources [nullls.builtins.diagnostics.stylelint
                                      nullls.builtins.formatting.prettier]})))))
