(fn plugins []
  [:nvim-treesitter/nvim-treesitter
   :nvim-treesitter/nvim-treesitter-textobjects])

; ensure_installed = one of "all", "maintained" (parsers with maintainers), or a list of languages

(fn configure []
  (let [ts (require :nvim-treesitter.configs)]
    (ts.setup {:ensure_installed [:javascript
                                  :typescript
                                  :svelte
                                  :css
                                  :scss
                                  :vue
                                  :c_sharp
                                  :tsx
                                  :python
                                  :fennel]
               :highlight {:enable true}
               :incremental_selection {:enable true
                                       :keymaps {:init_selection :gnn
                                                 :node_incremental :grn
                                                 :scope_incremental :grc
                                                 :node_decremental :grm}}
               :indent {:enable true}
               :textobjects {:select {:enable true
                                      :lookahead true ; Automatically jump forward to textobj, similar to targets.vim
                                      ; You can use the capture groups defined in textobjects.scm
                                      :keymaps {:af "@function.outer"
                                                :if "@function.inner"
                                                :ac "@class.outer"
                                                :ic "@class.inner"}}
                             :move {:enable true
                                    :set_jumps true
                                    :goto_next_start {"]m" "@function.outer"
                                                      "]]" "@class.outer"}
                                    :goto_next_end {"]M" "@function.outer"
                                                    "][" "@class.outer"}
                                    :goto_previous_start {"[m" "@function.outer"
                                                          "[[" "@class.outer"}
                                    :goto_previous_end {"[M" "@function.outer"
                                                        "[]" "@class.outer"}}}})))

{: configure : plugins }
