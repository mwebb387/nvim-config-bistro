(import-macros {: configure-bistro
                : with-recipes }
               :macros)

(configure-bistro
  (with-recipes
    (default)
    (bistro)
    ; (statusline)
    (themes :nightfox)
    (files)
    (git)
    (telescope :dap)
    (treesitter)
    (lsp)
    (debugging :ui)
    (complete :coc)

    ; Langs
    ;(angular)
    (csharp :omnisharp)
    (typescript :coc)))
