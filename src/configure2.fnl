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
 (test-debugging :ui :csharp :typescript)
 (test-complete :vcm)

 ; angular
 ; csharp
 ; fennel
 ; typescript
 )
