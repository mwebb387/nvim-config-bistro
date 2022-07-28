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
 (files :vifm)
 (git :signs)
 (fzf :vim :lsp)
 (telescope)
 (treesitter)
 (lsp)
 (debugging :ui :csharp :typescript)
 (complete :vcm)

 ; angular
 (csharp :omnisharp-ls)
 (fennel)
 (typescript :lsp :deno)
 )
