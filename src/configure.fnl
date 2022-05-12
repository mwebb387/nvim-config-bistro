(import-macros {: configure-bistro
                : with-recipes }
               :macros)

(configure-bistro
  (with-recipes
    (default)
    (bistro)
    (statusline)
    (themes :nightfox)
    (files)
    (git)
    (fzf)
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
