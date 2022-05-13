(import-macros {: defrecipe : let-g } :macros)

(fn configure []
  (let-g :fzf_preview_window [])
  (let-g :fzf_commits_log_options "--all --decorate --oneline --color=always"))

(fn configure-lsp []
  (let [fzf-lsp (require :fzf_lsp)]
    (fzf-lsp.setup)))

(defrecipe fzf
  (default [:junegunn/fzf
            :junegunn/fzf.vim]
    configure)
  (option :lsp [:gfanto/fzf-lsp.nvim] (fn [])))
