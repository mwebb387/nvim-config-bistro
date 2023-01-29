(import-macros {: defconfig} :recipe-macros)

(defconfig

  (use! [:philt/vim-fsharp]))

(defconfig
  (as-mode! :lsp)
  
  (setup! (fn []
            (let [{: on-attach} (require :lsp)
                  lspconfig (require :lspconfig)]
              (lspconfig.fsautocomplete.setup {:on_attach on-attach})))))
