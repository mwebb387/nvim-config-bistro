(import-macros {: configure-bistro
                : with-recipes
                : append!
                : defcommand
                : defmap
                : set!
                : let-g}
               :macros)

; (include :recipes.test)

; (import-macros {: load-recipes
;                : load-and-print-recipe} :recipe-macros)

; (load-and-print-recipe :test)
; (load-recipes
;   (test :test-mode2 :test-option2))
; (load-recipes
;  (test))

(configure-bistro
  (with-recipes
    (default)
    (bistro)
    ; (statusline)
    (themes :material)
    (files)
    (git :signs)
    (fzf :lsp)
    (telescope :dap)
    (treesitter)
    (lsp)
    (debugging :ui)
    ; (complete :coq)

    ; Langs
    ;(angular)
    (csharp :omnisharp-ls)
    (fennel)
    (typescript :lsp)))
