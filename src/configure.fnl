(import-macros {: configure-bistro
                : with-recipes }
               :macros)

(configure-bistro
   (with-recipes
     (default)
     (files)
     (themes :nordfox)
     ; (statusline)
     (telescope)
     (treesitter)
     (lsp)

     ; Langs
     ;(angular)
     (csharp :omnisharp)
     (typescript :coc))
   (: :register))
