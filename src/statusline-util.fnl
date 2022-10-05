(fn highlight [hl] (.. :%# hl :#))

;; Buffer
(fn buffer_number [] :%n)
(fn buffer_lines [] :%L)

;; File methods
(fn filename_relative [] :%f)
(fn filename_full [] :%F)
(fn filename_tail [] :%t)
(fn filetype [] :%y)

(fn eval [str] (.. "%{" str "}"))
(fn eval_lua [str] (.. "%{v:lua." str "()}"))
(fn format [str] (.. "%{%" str "%}"))

;; Flags
(fn flag_preview [] :%w)
(fn flag_modified [] :%M)
(fn flag_quickfix [] :%q)
(fn flag_readonly [] :%R)

;; Lines, values, etc
(fn current_column [] :%c)
(fn current_line [] :%l)
(fn current_percent [] :%p)
(fn visible_percent [] :%P)

;; Separator and truncation
(fn separator [] :%=)
(fn truncate [] :%<)

(fn highlight_group [hl ...]
  (let [grp (accumulate [result ""
                         _ v (ipairs [...])]
                        (.. result v))]
    (.. (highlight hl) "%(" grp "%)")))

{: highlight
 : buffer_number
 : buffer_lines
 : filename_relative
 : filename_full
 : filename_tail
 : filetype
 : eval
 : eval_lua
 : format
 : flag_preview
 : flag_modified
 : flag_quickfix
 : flag_readonly
 : current_column
 : current_line
 : current_percent
 : visible_percent
 : separator
 : truncate
 : highlight_group}
