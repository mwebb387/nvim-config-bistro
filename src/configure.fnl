(import-macros {: load-recipes} :recipe-macros)
(import-macros {: augroup
                : autocmd
                : defhighlight
                : defsign
                : defun
                : set!} :macros)

(load-recipes
 (base)
 (bistro)
 (themes) ; TODO: variable option/mode handler
 (statusline :winbar)
 (terminal)
 (files :netrw :images)
 (git :signs :diffview)
 (fzf)
 ; (telescope)
 (treesitter)
 (lsp :aerial)
 ; (debugging :ui :csharp :typescript)
 (complete :cmp)

 ; (angular)
 (csharp :omnisharp-ls)
 (fennel)
 (typescript :lsp :deno)
 ; (null-ls)
 )
