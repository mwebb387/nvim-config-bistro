(import-macros {: defhighlight : defsign } :macros)

(fn plugins [] [:neovim/nvim-lspconfig])

(fn configure []
  (defhighlight :LspDiagnosticsDefaultError :guifg :Red)
  (defhighlight :LspDiagnosticsUnderlineError :cterm :underline :gui :underline :guifg :Red :guisp :Red)
  (defsign :LspDiagnosticsSignError :text : :texthl :LspDiagnosticsSignError)

  (defhighlight :LspDiagnosticsDefaultWarning :guifg :Orange)
  (defhighlight :LspDiagnosticsUnderlineWarning :cterm :underline :gui :underline :guifg :Orange :guisp :Orange)
  (defsign :LspDiagnosticsSignWarning :text : :texthl :LspDiagnosticsSignWarning)

  (defhighlight :LspDiagnosticsDefaultInfomation :guifg :LightBlue)
  (defhighlight :LspDiagnosticsUnderlineInformation :cterm :underline :gui :underline :guifg :LightBlue :guisp :LightBlue)
  (defsign :LspDiagnosticsSignInformation :text : :texthl :LspDiagnosticsSignInformation)

  (defhighlight :LspDiagnosticsDefaultHint :guifg :LightGrey)
  (defhighlight :LspDiagnosticsUnderlineHint :cterm :underline :gui :underline :guifg :LightGrey :guisp :LightGrey)
  (defsign :LspDiagnosticsSignHint :text :ﴕ :texthl :LspDiagnosticsSignHint))

{: configure : plugins }
