(import-macros {: defconfig} :recipe-macros)

(defconfig
  (as-option! :lsp)
  
  (setup! (fn []
            (let [{: on-attach} (require :lsp)
                  cmp (require :cmp_nvim_lsp)
                  runtime (vim.api.nvim_get_runtime_file "" true)
                  lsp-config (require :lspconfig)]
              (lsp-config.sumneko_lua.setup {:capabilities (cmp.default_capabilities)
                                             :on_attach on-attach
                                             :settings {:Lua {:runtime :LuaJIT
                                                              :diagnostics {:globals [:vim]}
                                                              :workspace {:library runtime}
                                                              :telemetry {:enable false}}}})))))
