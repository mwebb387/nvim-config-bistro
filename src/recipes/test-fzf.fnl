(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defrecipe :test-fzf)

(defconfig
  ; === Globals ===
  (set-g! fzf_preview_window [])
  (set-g! fzf_commits_log_options  "--all --decorate --oneline --color=always")


  ; === Plugins ===
  (use! [:junegunn/fzf
         :junegunn/fzf.vim]))

(defconfig
  (as-option! :lsp)
  
  (setup!
    (fn [] ((. (require :fzf_lsp) setup)))))
