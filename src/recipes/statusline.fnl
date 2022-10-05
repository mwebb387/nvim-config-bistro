(import-macros {: defconfig} :recipe-macros)

(defconfig
  (set! laststatus 3)

  (setup!
    (fn []
      (defun SLGitBranch []
        (if (and vim.b.gitsigns_head
                 (not (= vim.b.gitsigns_head "")))
            (.. " " vim.b.gitsigns_head)
            ""))
      (defun SLLSPServer []
        (let [clients (vim.lsp.buf_get_clients)]

          (if (and clients
                   (> (length clients) 0))
              (.. " " (. clients 1 :name))
              "")))

      (let [sl (require :statusline-util)]
        (set! statusline (.. (sl.highlight :String) (sl.truncate) "  " (sl.filename_tail) " "
                             (sl.highlight_group :Constant
                                                 (sl.filetype)
                                                 (sl.flag_preview)
                                                 (sl.flag_quickfix)
                                                 (sl.flag_modified)
                                                 (sl.flag_readonly))
                             (sl.separator)
                             (sl.highlight_group :Identifier (sl.eval_lua :SLGitBranch))
                             " "
                             (sl.highlight_group :Statement (sl.eval_lua :SLLSPServer))
                             (sl.separator)
                             ;"%#Type#%-14.(%l,%c%)"
                             (sl.highlight :Type)
                             "%-14.(" (sl.current_line) ":" (sl.current_column) "%)"
                             "%-4.(" (sl.visible_percent) "%)"
                             "  "))))))

(defconfig
  (as-option! :winbar)

  (setup!
    (fn []
      (let [sl (require :statusline-util)]
        (set! winbar (.. (sl.highlight_group :User2
                                             (sl.filename_relative)
                                             " ["
                                             (sl.buffer_number)
                                             "] ")))))))
