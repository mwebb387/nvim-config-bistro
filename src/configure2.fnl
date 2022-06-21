(import-macros {: load-recipes} :recipe-macros)

(load-recipes
 (test)
 (test-bistro)
 ; statusline
 ; themes
 (test-files)
 (test-git :signs)
 (test-fzf :lsp)
 (test-telescope :dap)
 (test-treesitter)
 ; lsp
 ; debugging
 ; complete

 ; angular
 ; csharp
 ; fennel
 ; typescript
 )
