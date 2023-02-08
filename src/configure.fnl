(import-macros {: load-recipes} :recipe-macros)
(import-macros {: augroup
                : autocmd
                : defhighlight
                : defsign
                : defun
                : set!} :macros)

; (include :statusline-util)

(load-recipes
 (base)
 (bistro)
 (themes) ; TODO: variable option/mode handler
 (statusline :winbar)
 ; (dashboard)
 (terminal)
 (files :netrw :images)
 (git :signs :diffview)
 (fzf)
 ; (telescope)
 (treesitter)
 (lsp :aerial)
 ; (debugging :ui :csharp :typescript)
 (complete :cmp)

 (neorg)

 ; (angular)
 (csharp :omnisharp-ls)
 (fennel)
 (fsharp :lsp)
 (lua-lang :lsp)
 (typescript :lsp :deno)
 ; (null-ls)
 )
