(import-macros {: defrecipe } :macros)

(fn configure [])

(defrecipe fzf
  (default [:junegunn/fzf
            :junegunn/fzf.vim]
    configure))
