(import-macros {: configure-bistro
                : with-recipes }
               :macros)

(configure-bistro
  (with-recipes
    (default)
    (bistro)
    (files)
    (themes :nordfox)
    ; (statusline)
    (telescope)
    (treesitter)
    (lsp)
    (complete :vcm)

    ; Langs
    ;(angular)
    (csharp :omnisharp)
    (typescript :lsp)))
