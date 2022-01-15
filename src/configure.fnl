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
    (complete :vcm)

    ; Langs
    ;(angular)
    (csharp :omnisharp)
    (typescript :lsp)))
