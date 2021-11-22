;; echo globpath(expand('%:p:h'), '**/*.fnl')

(import-macros {: configure-bistro
                : with-recipes }
               :macros)

(configure-bistro
   (with-recipes
     (default)
     (files)
     (themes :nordfox)
     (telescope)
     (treesitter)
     (lsp)
     ; Langs
     ;(angular)
     (csharp :omnisharp)))
