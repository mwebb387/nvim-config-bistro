(import-macros {: defmap } :macros)

(fn plugins [...]
  (match [...]
    [:coc] [:neoclide/coc.nvim] ;', {'branch': 'release'}
    [:vcm] [:ackyshake/VimCompletesMe
            :ncm2/float-preview.nvim]))

; TODO: Mappings for coc
(fn configure-coc [])

(fn configure-vcm []
  ; inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  (defmap [i] :<CR> "pumvisible() ? \"\\<C-y>\" : \"\\<C-g>u\\<CR>\"" {:noremap true :expr true})); TODO: Better mapping for expressions...

(fn configure [...]
  (match [...]
    [:vmc] (configure-vcm)
    [:coc] (configure-coc)))

{: configure : plugins }

