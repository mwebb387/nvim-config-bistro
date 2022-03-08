(import-macros {: defrecipe} :macros)

(fn configure-lsp []
  (let [on-attach (require :recipes/lsp/attach)
        angular-lsp (require :lspconfig)]
    (angular-lsp.angularls.setup {})))

(fn plugins []
  [])

(fn configure []
  (configure-lsp))

{: configure
 : plugins
 :prepare (defrecipe
            (default [] configure-lsp))}
