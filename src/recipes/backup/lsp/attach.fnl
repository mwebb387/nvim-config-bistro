(import-macros {: augroup : autocmd : defhighlight} :macros)

(fn on-attach [client bufnr]
  (let [buf-keymap (lambda [...] (vim.api.nvim_buf_set_keymap bufnr ...))
        buf-option (lambda [...] (vim.api.nvim_buf_set_option bufnr ...))]
    (buf-option :omnifunc :v:lua.vim.lsp.omnifunc)

    ; Mappings
    (let [opts {:noremap true :silent true}]

      (buf-keymap :n :gD "<Cmd>lua vim.lsp.buf.declaration()<CR>" opts)
      (buf-keymap :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" opts)
      (buf-keymap :n :K "<Cmd>lua vim.lsp.buf.hover()<CR>" opts)
      (buf-keymap :n :gi "<cmd>lua vim.lsp.buf.implementation()<CR>" opts)
      (buf-keymap :n :<C-k> "<cmd>lua vim.lsp.buf.signature_help()<CR>" opts)
      (buf-keymap :i :<C-k> "<cmd>lua vim.lsp.buf.signature_help()<CR>" opts)
      (buf-keymap :n :<leader>ls "<cmd>lua vim.lsp.buf.workspace_sumbol()<CR>" opts)
      (buf-keymap :n :<leader>lwa "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>" opts)
      (buf-keymap :n :<leader>lwr "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>" opts)
      (buf-keymap :n :<leader>lwl "<cmd>lua vim.pretty_print(vim.lsp.buf.list_workspace_folders())<CR>" opts)
      (buf-keymap :n :<leader>lD "<cmd>lua vim.lsp.buf.type_definition()<CR>" opts)
      (buf-keymap :n :<leader>le "<cmd>lua vim.lsp.buf.rename()<CR>" opts)
      (buf-keymap :n :<F2> "<cmd>lua vim.lsp.buf.rename()<CR>" opts)
      (buf-keymap :n :<leader>la "<cmd>lua vim.lsp.buf.code_action()<CR>" opts)
      (buf-keymap :n :<leader>. "<cmd>lua vim.lsp.buf.code_action()<CR>" opts)
      (buf-keymap :n :gr "<cmd>lua vim.lsp.buf.references()<CR>" opts)
      (buf-keymap :n :<leader>ld "<cmd>lua vim.diagnostic.open_float()<CR>" opts)
      (buf-keymap :n "[d" "<cmd>lua vim.diagnostic.goto_prev()<CR>" opts)
      (buf-keymap :n "]d" "<cmd>lua vim.diagnostic.goto_next()<CR>" opts)
      (buf-keymap :n :<leader>ll "<cmd>lua vim.diagnostic.set_loclist()<CR>" opts)
      (buf-keymap :n :<leader>lq "<cmd>lua vim.diagnostic.set_qflist()<CR>" opts)

      ;Set some keybinds conditional on server capabilities
      (when client.resolved_capabilities.goto_definition
        (buf-option :tagfunc "v:lua.vim.lsp.tagfunc"))

      (when client.resolved_capabilities.document_formatting
        (buf-keymap :n :<leader>lf "<cmd>lua vim.lsp.buf.formatting()<CR>" opts)
        (buf-option :formatexpr "v:lua.vim.lsp.formatexpr()"))

      (when client.resolved_capabilities.document_range_formatting
        (buf-keymap :v :<leader>lf "<cmd>lua vim.lsp.buf.range_formatting()<CR>" opts)))

    ; Set autocommands conditional on server_capabilities
    (when client.resolved_capabilities.document_highlight
        (defhighlight :LspReferenceRead {:cterm :bold
                                         :ctermbg :red
                                         :guibg :LightYellow})
        (defhighlight :LspReferenceText {:cterm :bold
                                         :ctermbg :red
                                         :guibg :LightYellow})
        (defhighlight :LspReferenceWrite {:cterm :bold
                                          :ctermbg :red
                                          :guibg :LightYellow})
        ;   vim.api.nvim_exec([[
        ;     hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        ;     hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        ;     hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        ;     augroup lsp_document_highlight
        ;       autocmd! * <buffer>
        ;       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        ;       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        ;     augroup END
        ;   ]], false)

        ;; TODO: Make sure this works like "autocmd! * <buffer>"
        (augroup :lsp_document_highlight
          (autocmd :CursorHold :<buffer> "lua vim.lsp.buf.document_highlight()")
          (autocmd :CursorMoved :<buffer> "lua vim.lsp.buf.clear_references()")))))

on-attach
