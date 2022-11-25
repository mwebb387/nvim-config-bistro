(fn highlight [hl] (.. :%# hl :#))

;; Buffer
(fn buffer_number [] :%n)
(fn buffer_lines [] :%L)

;; File methods
(fn filename_relative [] :%f)
(fn filename_full [] :%F)
(fn filename_tail [] :%t)
(fn filetype [] :%Y)

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

; highlight helper methods
(fn get_hi_attr [hi attr]
  (-> (vim.fn.hlID hi)
      (vim.fn.synIDattr attr)))

(fn def_hi_rev [hi]
  (let [hi-rev (.. hi :_Reverse)
        fg (get_hi_attr hi :fg)
        ; bg (get-hi-attr :NonText :fg)
        bg :black]
    (vim.api.nvim_set_hl 0
                         hi-rev
                         {:fg bg
                          :bg fg})))
(fn def_hi_fg_bg [hi_fg hi_bg]
  (let [hi_rev (.. hi_fg :_ hi_bg)
        fg (get_hi_attr hi_fg :fg)
        bg (get_hi_attr hi_bg :bg)]
    (vim.api.nvim_set_hl 0
                         hi_rev
                         {:fg fg
                          :bg bg})))

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
 : highlight_group
 : def_hi_rev
 : def_hi_fg_bg}
