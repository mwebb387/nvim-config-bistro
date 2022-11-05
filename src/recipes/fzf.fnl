(import-macros {: defconfig} :recipe-macros)

(defconfig

  (set-g! fzf_bat_options "bat --color always --style changes --theme Coldark-Dark -m *.fnl:Lisp {}")

  (map! [:n] :<c-p>
        (fn [] (let [fzfOpts {:sink :e
                              :options [:--preview
                                        vim.g.fzf_bat_options
                                        :--bind
                                        "ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"]}]
                  (vim.fn.fzf#run (vim.fn.fzf#wrap fzfOpts)))))

  ; === Plugins ===
  (use! [:junegunn/fzf]))

(defconfig
  (as-mode! :vim)

  ; === Globals ===
  (set-g! fzf_preview_window [])
  (set-g! fzf_commits_log_options  "--all --decorate --oneline --color=always")

  ; === Plugins ===
  (use! [:junegunn/fzf.vim]))


(defconfig
  (as-option! :nvim)

  ; === Plugins ===
  (use! [:vijaymarupudi/nvim-fzf
         :vijaymarupudi/nvim-fzf-commands]))

(defconfig
  (as-option! :lsp)

  (use! [:gfanto/fzf-lsp.nvim])
  
  (setup!
    (fn [] ((. (require :fzf_lsp) :setup)))))
