(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defrecipe :test-fzf)

(defconfig
  ; === Globals ===

  ;; TODO: Finish and add globals...


  ; === Plugins ===
  (use! [:junegunn/fzf
         :junegunn/fzf.vim]))

(defconfig
  (as-option! :lsp)
  
  (setup!
    (fn [] ((. (require :fzf_lsp) setup)))))
