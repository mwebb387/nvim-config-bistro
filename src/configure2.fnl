(import-macros {: load-recipes} :recipe-macros)
(import-macros {: augroup
                : autocmd
                : defhighlight
                : defsign
                : defun} :macros)

(load-recipes
 (base)
 (bistro)
 ; statusline
 (themes) ; TODO: variable option/mode handler
 (files)
 (git :signs)
 (fzf :lsp)
 (telescope)
 (treesitter)
 (lsp)
 (debugging :ui :csharp :typescript)
 (complete :vcm)

 ; angular
 (csharp :omnisharp-ls)
 (fennel)
 (typescript :lsp)
 )
