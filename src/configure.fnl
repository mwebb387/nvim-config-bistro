(import-macros {: configure-bistro
                : with-recipes }
               :macros)

(configure-bistro
  (with-recipes
    (default)
    (bistro)
    (files)
    (themes :material)
    ; (statusline)
    (telescope)
    (treesitter)
    (lsp)
    (complete :vcm)

    ; Langs
    ;(angular)
    (csharp :omnisharp)
    (typescript :lsp)))
