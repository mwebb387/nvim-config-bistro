(import-macros {: augroup
                : autocmd
                : append!
                : set!
                : map!
                : let-g}
               :macros)

(fn configure-cs []
   ;; 
   ;; :syn sync fromstart
   ;; :set foldmethod=syntax

  ;(vim.cmd ":syn region myFold start='{' end='}' transparent fold")
  ;(vim.cmd ":syn region myFold start='{' end='}' transparent fold")
  ;(augroup :csharp-commands
   ; (autocmd :filetype "cs" "setlocal shiftwidth=4 softtabstop=4 expandtab")
  )

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
  (augroup :omnisharp-module-commands
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

    (autocmd :filetype "cs" "nnoremap <leader>le :OmniSharpRename<cr>")
    (autocmd :filetype "cs" "nnoremap <f2> :OmniSharpRename<cr>")

    (autocmd :filetype "cs" "nnoremap <leader>l= :OmniSharpCodeFormat<cr>")

    (autocmd :filetype "cs" "nnoremap <leader>loss :OmniSharpStartServer<cr>")
    (autocmd :filetype "cs" "nnoremap <leader>losr :OmniSharpRestartServer<cr>")
    (autocmd :filetype "cs" "nnoremap <leader>losp :OmniSharpStopServer<cr>")))

(fn configure-lsp []
  (let [on-attach (require :modules/lsp/attach)
        pid (vim.fn.getpid)
        home (vim.fn.expand "~")
        omnisharp-bin (.. home :\scoop\apps\omnisharp\current\OmniSharp.exe)
        omnisharp-lsp (require :lspconfig)]
    (omnisharp-lsp.omnisharp.setup {:cmd [omnisharp-bin "--languageserver" "--hostPID" (tostring pid)]
                                    :on_attach on-attach})))

(fn plugins [...]
  (let [plugs [] args [...]]
    (match args
      [:omnisharp] (table.insert plugs :omnisharp/omnisharp-vim))
    plugs))

(fn configure [...]
  (let [args [...]]
    (match args
      [:omnisharp] (configure-omnisharp)
      [:lsp] (configure-lsp))))

{: configure : plugins}
