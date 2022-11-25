(import-macros {: defconfig} :recipe-macros)

(defconfig
  (set! laststatus 3)

  (setup!
    (fn []
      (defun SLGitBranch []
        (if (and vim.b.gitsigns_head
                 (not (= vim.b.gitsigns_head "")))
            (.. "  " vim.b.gitsigns_head " ")
            ""))
      (defun SLLSPServer []
        (let [clients (vim.lsp.buf_get_clients)]

          (if (and clients
                   (> (length clients) 0))
            (..
              (accumulate [disp "  "
                           k c (pairs clients)]
                          (.. disp c.name))
              " ")
            "")))
      (defun SLSetColors []
        (let [sl (require :statusline-util)]
          (sl.def_hi_rev :Keyword)
          (sl.def_hi_rev :Type)
          (sl.def_hi_fg_bg :Type :Keyword_Reverse)))

      (augroup :statusline-colors
        (autocmd :ColorScheme :* "call v:lua.SLSetColors()"))

      (let [sl (require :statusline-util)]
        (sl.def_hi_rev :Keyword)
        (sl.def_hi_rev :Type)
        (sl.def_hi_fg_bg :Type :Keyword_Reverse)

        (set! statusline (..
                           ; (sl.highlight :String) (sl.truncate) "  " (sl.filename_tail) "  "

                             (sl.highlight_group :String
                                                 "  "
                                                 (sl.filetype)
                                                 (sl.flag_preview)
                                                 (sl.flag_quickfix)
                                                 (sl.flag_modified)
                                                 (sl.flag_readonly)
                                                 "  ")

                             (sl.highlight_group :Constant
                                                 "  buffer " (sl.buffer_number))

                             (sl.separator)
                             (sl.highlight_group :Type
                                                 "  "
                                                 (sl.current_line) ":" (sl.current_column)
                                                 " | "
                                                 (sl.visible_percent))
                             (sl.separator)
                             (sl.highlight_group :Keyword "")
                             (sl.highlight_group :Keyword_Reverse (sl.eval_lua :SLGitBranch))
                             (sl.highlight_group :Type_Keyword_Reverse "")
                             (sl.highlight_group :Type_Reverse (sl.eval_lua :SLLSPServer))
                             ; (sl.separator)
                             ;"%#Type#%-14.(%l,%c%)"
                             ; (sl.highlight :Type)
                             ; "%-14.(" (sl.current_line) ":" (sl.current_column) "%)"
                             ; "%-4.(" (sl.visible_percent) "%)"
                             ))))))

(defconfig
  (as-option! :winbar)

  (setup!
    (fn []
      (defun FileIcon []
        (let [icons (require :nvim-web-devicons)]
          (or (icons.get_icon (vim.fn.expand "%:t") (vim.fn.expand "%:e"))
              "")))

      (let [sl (require :statusline-util) ]
        (set! winbar (.. (sl.highlight_group :User2
                                             " "
                                             (sl.eval_lua :FileIcon)
                                             " "
                                             (sl.filename_relative))))))))
