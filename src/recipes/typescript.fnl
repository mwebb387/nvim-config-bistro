(import-macros {: defrecipe
                : augroup
                : autocmd
                : defmap}
               :macros)

(fn plugins []
  [])

(fn configure-coc []
  (let [ftypes "javascript,typescript,typescriptreact"]
    (augroup :coc-tsserver-commands
      (autocmd :filetype ftypes "nnoremap <buffer> <leader>la <Plug>(coc-codeaction)"))))

(fn configure-lsp []
  (let [lspconfig (require :lspconfig)
        on-attach (require :recipes/lsp/attach)]
    (lspconfig.tsserver.setup {:on_attach on-attach})))

(fn configure [...]
  (let [args [...]]
    (match args
      [:coc] (configure-coc)
      [:lsp] (configure-lsp))))

{: configure
 : plugins
 :prepare (defrecipe
            (mode coc [] configure-coc)
            (mode lsp [] configure-lsp))}
