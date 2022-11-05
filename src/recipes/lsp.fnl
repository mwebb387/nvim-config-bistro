(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defconfig
  (use! [:neovim/nvim-lspconfig])

  (setup!
    (fn []
      ; ; Setup Fidget
      ; (let [fidget (require :fidget)]
      ;   (fidget.setup))

      ; LSP Error Highlight/sign
      (defhighlight :DiagnosticsError {:guifg :Red})
      (defhighlight :DiagnosticUnderlineError {:cterm :underline
                                               :gui :underline
                                               :guifg :Red
                                               :guisp :Red})
      (defsign :DiagnosticSignError {:text :
                                     :texthl :DiagnosticSignError})

      ; LSP Warning Highlight/sign
      (defhighlight :DiagnosticWarning {:guifg :Orange})
      (defhighlight :DiagnosticUnderlineWarning {:cterm :underline
                                                 :gui :underline
                                                 :guifg :Orange
                                                 :guisp :Orange})
      (defsign :DiagnosticSignWarn {:text :
                                    :texthl :DiagnosticSignWarn})

      ; LSP Information Highlight/sign
      (defhighlight :DiagnosticInfomation {:guifg :LightBlue})
      (defhighlight :DiagnosticUnderlineInformation {:cterm :underline
                                                     :gui :underline
                                                     :guifg :LightBlue
                                                     :guisp :LightBlue})
      (defsign :DiagnosticSignInfo {:text :
                                    :texthl :LspDiagnosticSignInfo})

      ; LSP Hint Highlight/sign
      (defhighlight :DiagnosticHint {:guifg :LightGrey})
      (defhighlight :DiagnosticUnderlineHint {:cterm :underline
                                              :gui :underline
                                              :guifg :LightGrey
                                              :guisp :LightGrey})
      (defsign :DiagnosticSignHint {:text :ﴕ
                                    :texthl :DiagnosticSignHint}))))

(defconfig
  (as-option! :aerial)

  (use! [:stevearc/aerial.nvim])
  
  (setup! (fn [] ((. (require :aerial) :setup)))))
