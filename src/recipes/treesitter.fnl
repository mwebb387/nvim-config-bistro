(import-macros {: defconfig} :recipe-macros)

(defconfig
  ; === Plugins ===
  (use! [:nvim-treesitter/nvim-treesitter])

  ; === Setup ===
  (setup!
    (fn configure []
      (let [ts (require :nvim-treesitter.configs)]
        (ts.setup {:ensure_installed [:c_sharp
                                      :fennel
                                      :javascript
                                      :typescript
                                      :svelte
                                      :css
                                      :scss
                                      ; :vue ; Errors
                                      :tsx
                                      ; :python ; Errors
                                      ]
                   :highlight {:enable true}
                   :incremental_selection {:enable true
                                           :keymaps {:init_selection :gnn
                                                     :node_incremental :grn
                                                     :scope_incremental :grc
                                                     :node_decremental :grm}}
                   :indent {:enable true}})))))

(defconfig
  (as-option! :folding)

  ; Testing TS folding
  (set! foldmethod :expr)
  (set! foldnestmax 3)
  (set! foldexpr "nvim_treesitter#foldexpr()"))
