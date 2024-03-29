(import-macros {: defconfig} :recipe-macros)

; (defconfig
;   (autocmd! :FileType [:cs :razor] "compiler msbuild")
;   (autocmd! :FileType :cs "setlocal shiftwidth=4 softtabstop=4 expandtab"))

(defconfig
  (as-mode! :omnisharp)

  (set-g! OmniSharp_server_use_net6 1)
  (set-g! OmniSharp_server_stdio 1)
  (set-g! OmniSharp_timeout 50)
  (set-g! OmniSharp_highlight_types 2)
  (set-g! OmniSharp_highlight_groups {:ParameterName "csNewType"
                                      :LocalName "csNewType"})
  (set-g! OmniSharp_popup_mappings {:sigNext :<C-n>
                                    :sigPrev :<C-p>
                                    :pageDown [:<C-f> :<PageDown>]
                                    :pageUp [:<C-b> :<PageUp>] })

  (use! [:w0rp/ale
         :omnisharp/omnisharp-vim])

  (setup!
    (fn []
      (augroup :omnisharp-recipe-commands
               (autocmd :filetype "cs" "setlocal shiftwidth=4 softtabstop=4 expandtab")
               (autocmd :filetype "cs,cshtml" "nnoremap <buffer> gd :OmniSharpGotoDefinition<cr>")
               (autocmd :filetype "cs,cshtml" "nnoremap <buffer> gi :OmniSharpFindImplementations<cr>")
               (autocmd :filetype "cs,cshtml" "nnoremap <buffer> gs :OmniSharpFindSymbol<cr>")
               (autocmd :filetype "cs,cshtml" "nnoremap <buffer> gr :OmniSharpFindUsages<cr>")
               (autocmd :filetype "cs,cshtml" "nnoremap <buffer> K :OmniSharpDocumentation<cr>")

               (autocmd :filetype "cs,cshtml" "nnoremap <buffer> <leader>lh :OmniSharpHighlightEcho<cr>")
               (autocmd :filetype "cs" "nnoremap <buffer> <leader>lx :OmniSharpFixUsings<cr>")
               (autocmd :filetype "cs" "nnoremap <buffer> <leader>lt :OmniSharpTypeLookup<cr>")
               (autocmd :filetype "cs" "nnoremap <buffer> <leader>k :OmniSharpSignatureHelp<cr>")
               (autocmd :filetype "cs" "inoremap <buffer> <c-k> <c-o>:OmniSharpSignatureHelp<cr>")

               (autocmd :filetype "cs" "nnoremap <buffer> <leader>lc :OmniSharpGlobalCodeCheck<cr>")
               (autocmd :filetype "cs" "nnoremap <leader>la :OmniSharpGetCodeActions<cr>")
               (autocmd :filetype "cs" "nnoremap <leader>. :OmniSharpGetCodeActions<cr>")

               (autocmd :filetype "cs" "nnoremap <leader>le :OmniSharpRename<cr>")
               (autocmd :filetype "cs" "nnoremap <f2> :OmniSharpRename<cr>")

               (autocmd :filetype "cs" "nnoremap <leader>l= :OmniSharpCodeFormat<cr>")

               (autocmd :filetype "cs" "nnoremap <leader>loss :OmniSharpStartServer<cr>")
               (autocmd :filetype "cs" "nnoremap <leader>losr :OmniSharpRestartServer<cr>")
               (autocmd :filetype "cs" "nnoremap <leader>losp :OmniSharpStopServer<cr>")))))

(defconfig
  (as-mode! :omnisharp-ls)

  (use! [:jlcrochet/vim-razor
         :Hoffs/omnisharp-extended-lsp.nvim])

  (setup! (fn []
            (let [{: on-attach} (require :lsp)
                  pid (vim.fn.getpid)
                  home (vim.fn.expand "~")
                  cs-handlers {:textDocument/publishDiagnostics
                               (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics { :virtual_text false })
                               :textDocument/definition
                               (. (require :omnisharp_extended) :handler)}
                  omnisharp-bin :omnisharp.exe
                  omnisharp-lsp (require :lspconfig)
                  cmp (require :cmp_nvim_lsp)
                  omnisharp-cmd [omnisharp-bin]]
              (omnisharp-lsp.omnisharp.setup {:cmd [omnisharp-bin]
                                              :capabilities (cmp.default_capabilities)
                                              :enable_roslyn_analyzers true
                                              :on_attach on-attach
                                              :handlers cs-handlers})))))

(defconfig
  (as-mode! :csharp-ls)

  (setup! (fn []
            (let [{: on-attach} (require :lsp)
                  lspconfig (require :lspconfig)]
              (lspconfig.csharp_ls.setup {:on_attach on-attach})))))
