(import-macros {: defconfig} :recipe-macros)

(defconfig
  (as-mode! :vim)

  ; === Globals ===
  (set-g! fzf_preview_window [])
  (set-g! fzf_commits_log_options  "--all --decorate --oneline --color=always")

  ; === Plugins ===
  (use! [:junegunn/fzf
         :junegunn/fzf.vim]))

(defconfig
  (as-mode! :nvim)

  ; === Plugins ===
  (use! [:vijaymarupudi/nvim-fzf
         :vijaymarupudi/nvim-fzf-commands]))

(defconfig
  (as-option! :lsp)

  (use! [:gfanto/fzf-lsp.nvim])
  
  (setup!
    (fn [] ((. (require :fzf_lsp) :setup)))))
