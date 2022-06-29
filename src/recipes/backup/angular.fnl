(import-macros {: defrecipe} :macros)

(fn configure-lsp []
  (let [on-attach (require :recipes/lsp/attach)
        angular-lsp (require :lspconfig)]
    (angular-lsp.angularls.setup {})))

(defrecipe angular
  (default [] configure-lsp))
