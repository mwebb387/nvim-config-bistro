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
 (statusline :winbar)
 (themes) ; TODO: variable option/mode handler
 (terminal)
 (files :vifm)
 (git :signs :diffview)
 ; (fzf)
 (telescope)
 (treesitter)
 (lsp)
 (debugging :ui :csharp :typescript)
 (complete :mu)

 ; angular
 (csharp :omnisharp-ls)
 (fennel)
 (typescript :lsp :deno)
 )
