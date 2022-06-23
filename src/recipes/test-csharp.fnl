(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defrecipe :test-csharp)

;; TODO: Regular omnisharp...

(defconfig
  (as-mode! :omnisharp-ls)
  
  (use! [:Hoffs/omnisharp-extended-lsp.nvim])
  
  (setup! (fn []
            (let [{: on-attach} (require :lsp)
                  pid (vim.fn.getpid)
                  home (vim.fn.expand "~")
                  cs-handlers {:textDocument/publishDiagnostics
                               (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics { :virtual_text false })
                               :textDocument/definition
                               (. (require :omnisharp_extended) handler)}
                  ; cs-handlers (require :recipes/lsp/handlers)
                  omnisharp-bin (.. home :\scoop\apps\omnisharp\current\OmniSharp.exe)
                  omnisharp-lsp (require :lspconfig)]
              (omnisharp-lsp.omnisharp.setup {:cmd [omnisharp-bin "--languageserver" "--hostPID" (tostring pid)]
                                              :on_attach on-attach
                                              :handlers cs-handlers})))))

(defconfig
  (as-mode! :csharp-ls)
  
  (setup! (fn []
            (let [{: on-attach} (require :lsp)
                  lspconfig (require :lspconfig)]
              (lspconfig.csharp_ls.setup {:on_attach on-attach})))))
