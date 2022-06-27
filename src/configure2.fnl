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
 (test-lsp)
 (test-debugging :ui :csharp :typescript)
 (test-complete :vcm)

 ; angular
 (test-csharp :omnisharp-ls)
 ; fennel
 ; typescript
 )
