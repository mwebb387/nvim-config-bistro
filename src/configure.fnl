(import-macros {: configure-bistro
                : with-recipes }
               :macros)

(configure-bistro
  (with-recipes
    (default)
    (bistro)
    (statusline)
    (themes :terafox)
    (files)
    (git :signs)
    (fzf :lsp)
    (telescope :dap)
    (treesitter)
    (lsp)
    (debugging :ui)
    (complete :coq)

    ; Langs
    ;(angular)
    (csharp :omnisharp-ls)
    (fennel)
    (typescript :lsp)))
