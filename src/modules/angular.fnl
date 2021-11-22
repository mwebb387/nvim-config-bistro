(fn configure-lsp []
  (let [on-attach (require :modules/lsp/attach)
        angular-lsp (require :lspconfig)]
    (angular-lsp.angularls.setup {})))

(fn plugins []
  [])

(fn configure []
  (configure-lsp))

{: configure : plugins}
