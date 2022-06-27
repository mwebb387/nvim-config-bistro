(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(import-macros {: defhighlight
                : defsign} :macros)

(defrecipe :test-typescript)

(defconfig
  (as-mode! :coc)

  (setup!
    (fn configure-coc []
      (let [ftypes "javascript,typescript,typescriptreact"]
        (augroup :coc-tsserver-commands
                 (autocmd :filetype ftypes "nnoremap <buffer> <leader>la <Plug>(coc-codeaction)"))))))

(defconfig
  (as-mode! :lsp)

  (setup!
    (fn configure-lsp []
      (let [lspconfig (require :lspconfig)
            {: on-attach} (require :lsp)]
        (lspconfig.tsserver.setup {:on_attach on-attach})))))
