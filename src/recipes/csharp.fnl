(import-macros {: defrecipe
                : augroup
                : autocmd
                : append!
                : set!
                : let-g}
               :macros)

(fn configure-cs []
  (augroup :csharp-folding
    (autocmd :filetype "cs" "set foldmethod=syntax")
    (autocmd :filetype "cs" "set foldnestmax=3")
    (autocmd :filetype "cs" "set foldlevel=2")
    (autocmd :filetype "cs" "syntax region myFold start='{' end='}' transparent fold")
    (autocmd :filetype "cs" "syntax sync fromstart")))

(fn configure-omnisharp []
  (let-g :OmniSharp_server_stdio 1)
  (let-g :OmniSharp_timeout 50)
  (let-g :OmniSharp_highlight_types 2)
  (let-g :OmniSharp_highlight_groups {:ParameterName "csNewType"
                                      :LocalName "csNewType"})
  (let-g :OmniSharp_popup_mappings {:sigNext :<C-n>
                                    :sigPrev :<C-p>
                                    :pageDown [:<C-f> :<PageDown>]
                                    :pageUp [:<C-b> :<PageUp>] })
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
    (autocmd :filetype "cs" "nnoremap <leader>losp :OmniSharpStopServer<cr>")))

(fn configure-lsp []
  (let [on-attach (require :recipes/lsp/attach)
        pid (vim.fn.getpid)
        home (vim.fn.expand "~")
        ; cs-handlers (require :recipes/lsp/csharpHandler)
        cs-handlers (require :recipes/lsp/handlers)
        omnisharp-bin (.. home :\scoop\apps\omnisharp\current\OmniSharp.exe)
        omnisharp-lsp (require :lspconfig)]
    (omnisharp-lsp.omnisharp.setup {:cmd [omnisharp-bin "--languageserver" "--hostPID" (tostring pid)]
                                    :on_attach on-attach
                                    :handlers cs-handlers})))

(fn configure-csharp-ls []
  (let [on-attach (require :recipes/lsp/attach)
        lspconfig (require :lspconfig)]
    (lspconfig.csharp_ls.setup {:on_attach on-attach})))

(defrecipe csharp
  ; (default [] configure-cs)
  (mode omnisharp [:w0rp/ale
                   :omnisharp/omnisharp-vim]
        configure-omnisharp)
  (mode omnisharp-ls [] configure-lsp)
  (mode csharp-ls [] configure-csharp-ls))
