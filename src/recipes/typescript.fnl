(import-macros {: defconfig} :recipe-macros)

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

(defconfig
  (as-option! :deno)

  (setup!
    (fn configure-deno []
      (let [lspconfig (require :lspconfig)
            {: on-attach} (require :lsp)]
        (lspconfig.denols.setup {:on_attach on-attach
                                 :root_dir (lspconfig.util.root_pattern [:deno.json :deno.jsonp])
                                 :autostart false})))))
