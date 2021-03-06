(import-macros {: defrecipe : defhighlight : defsign } :macros)

(fn configure []
  ; Setup Fidget
  (let [fidget (require :fidget)]
    (fidget.setup))

  ; LSP Error Highlight/sign
  (defhighlight :LspDiagnosticsDefaultError {:guifg :Red})
  (defhighlight :LspDiagnosticsUnderlineError {:cterm :underline
                                               :gui :underline
                                               :guifg :Red
                                               :guisp :Red})
  (defsign :LspDiagnosticsSignError {:text :
                                     :texthl :LspDiagnosticsSignError})

  ; LSP Warning Highlight/sign
  (defhighlight :LspDiagnosticsDefaultWarning {:guifg :Orange})
  (defhighlight :LspDiagnosticsUnderlineWarning {:cterm :underline
                                                 :gui :underline
                                                 :guifg :Orange
                                                 :guisp :Orange})
  (defsign :LspDiagnosticsSignWarning {:text :
                                       :texthl :LspDiagnosticsSignWarning})

  ; LSP Information Highlight/sign
  (defhighlight :LspDiagnosticsDefaultInfomation {:guifg :LightBlue})
  (defhighlight :LspDiagnosticsUnderlineInformation {:cterm :underline
                                                     :gui :underline
                                                     :guifg :LightBlue
                                                     :guisp :LightBlue})
  (defsign :LspDiagnosticsSignInformation {:text :
                                           :texthl :LspDiagnosticsSignInformation})

  ; LSP Hint Highlight/sign
  (defhighlight :LspDiagnosticsDefaultHint {:guifg :LightGrey})
  (defhighlight :LspDiagnosticsUnderlineHint {:cterm :underline
                                              :gui :underline
                                              :guifg :LightGrey
                                              :guisp :LightGrey})
  (defsign :LspDiagnosticsSignHint {:text :ﴕ
                                    :texthl :LspDiagnosticsSignHint}))

(defrecipe lsp
  (default [:neovim/nvim-lspconfig
            :j-hui/fidget.nvim] configure))

