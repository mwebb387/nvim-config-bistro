(import-macros {: defrecipe : augroup : autocmd : defcommand : set!} :macros)

; (local leftCaps ["" "" "" "" ""])
; (local rightCaps ["" "" "" "" ""])

(fn get-bg []
  (-> (vim.fn.hlID :CursorLine)
      (vim.fn.synIDattr :bg)))

(fn section-end-left [] "   ")

(fn section-end-right [] "   ")

(fn status-left [colors condition]
  (let [fi (require :galaxyline.providers.fileinfo)]
    [{:SectionCapLeft {:provider section-end-left
                       :highlight [colors.bg]}}

     {:FileIcon {:provider "FileIcon"
                 :condition condition.buffer_not_empty
                 :highlight [fi.get_file_icon_color colors.bg]}}

     {:FileName {:provider "FileName"
                 :condition condition.buffer_not_empty
                 :highlight [colors.magenta colors.bg "bold"]}}

     {:FileSize {:provider "FileSize"
                 :condition condition.buffer_not_empty
                 :highlight [colors.fg colors.bg]}}

     {:DiagnosticError {:provider "DiagnosticError"
                        :icon "  "
                        :highlight [colors.red colors.bg]}}

     {:DiagnosticWarn {:provider "DiagnosticWarn"
                       :icon "  "
                       :highlight [colors.yellow colors.bg]}}

     {:DiagnosticHint {:provider "DiagnosticHint"
                       :icon "  "
                       :highlight [colors.cyan colors.bg]}}

     {:DiagnosticInfo {:provider "DiagnosticInfo"
                       :icon "  "
                       :highlight [colors.blue colors.bg]}}]))

;; local function midCondition()
;;   local tbl = {['dashboard'] = true['']=true}
;;   if tbl[vim.bo.filetype] then
;;     return false
;;   end
;;   return true
;; end

; (fn git-branch-provider []
;   )

(fn status-mid [colors condition]
  [{:FileEncode {:provider "FileEncode"
                 :condition condition.hide_in_width
                 :separator "  "
                 :separator_highlight ["NONE" colors.bg]
                 :highlight [colors.green colors.bg "bold"]}}

   {:FileFormat {:provider "FileFormat"
                 :condition condition.hide_in_width
                 :separator "  "
                 :separator_highlight ["NONE" colors.bg]
                 :highlight [colors.green colors.bg "bold"]}}

   {:LineInfo {:provider "LineColumn"
               :separator "  "
               :separator_highlight ["NONE" colors.bg]
               :highlight [colors.fg colors.bg]}}

   {:PerCent {:provider "LinePercent"
              :separator "  "
              :separator_highlight ["NONE" colors.bg]
              :highlight [colors.fg colors.bg "bold"]}}])

(fn status-right [colors condition]
  [{:GitBranch {:provider "GitBranch"
                :icon "  "
                :separator " "
                :separator_highlight ["NONE" colors.bg]
                :condition condition.check_git_workspace
                :highlight [colors.violet colors.bg "bold"]}}

   {:DiffAdd {:provider "DiffAdd"
              :condition condition.hide_in_width
              :separator " "
              :separator_highlight ["NONE" colors.bg]
              :icon "  "
              :highlight [colors.green colors.bg]}}

   {:DiffModified {:provider "DiffModified"
                   :condition condition.hide_in_width
                   :icon " 柳 "
                   :highlight [colors.orange colors.bg]}}

   {:DiffRemove {:provider "DiffRemove"
                 :condition condition.hide_in_width
                 :icon "  "
                 :highlight [colors.red colors.bg]}}

   {:ShowLspClient {:provider "GetLspClient"
                    :condition midCondition
                    :icon "  "
                    :highlight [colors.cyan colors.bg "bold"]}}

   {:SectionCapRight {:provider section-end-right
                      :highlight [colors.bg]}}])

(fn status-short-line-left [colors condition]
  [{:BufferType {:provider "FileTypeName"
                 :separator " "
                 :separator_highlight ["NONE" colors.bg]
                 :highlight [colors.blue colors.bg "bold"]}}

   {:SFileName {:provider  "SFileName"
                :condition condition.buffer_not_empty
                :highlight [colors.fg colors.bg "bold"]}}])

(fn status-short-line-right [colors condition]
  [{:BufferIcon {:provider "BufferIcon"
                 :highlight [colors.fg colors.bg]}}])


;;
;; Methods and recipe def for resetting the highlight based on current theme highlihts
;;

(fn reset-hi-for-section [sec color]
  (each [_ obj (ipairs sec)]
    (each [key opt (pairs obj)]
      ; Handle the section caps differently than the normal sections
      (if (or (= key :SectionCapLeft)
              (= key :SectionCapRight))
        (tset opt.highlight 1 color)
        (tset opt.highlight 2 color))

      ; Handle separator highlights
      (when opt.separator_highlight
        (tset opt.separator_highlight 2 color)))))

(fn reset-hi-for-status-line [gl color]
  ; (defhighlight :StatusLine {:cterm :NONE
  ;                            :gui :NONE
  ;                            :guibg color})
  (vim.cmd (.. "hi StatusLine cterm=NONE gui=NONE guibg=" color)) ; TODO: Vim Hi Macro with lazy eval?
  (each [_ prop (ipairs [:left :mid :right :short_line_left :short_line_right])]
    (reset-hi-for-section (. gl prop) color)))

(fn reset-highlights [gls]
  (reset-hi-for-status-line gls (get-bg)))

(fn configure []
  (set! :termguicolors true)
  (set! :laststatus 3)
  (let [gls (. (require :galaxyline) :section)
        colors (. (require :galaxyline.themes.colors) :default)
        condition (require :galaxyline.condition)]
    (set colors.bg (get-bg))
    (set gls.left (status-left colors condition))
    (set gls.mid (status-mid colors condition))
    (set gls.right (status-right colors condition))
    (set gls.short_line_left (status-short-line-left colors condition))
    (set gls.short_line_right (status-short-line-right colors condition))

    (defcommand :StatuslineResetHighlights
      (fn [] (reset-highlights gls))))

  ; Reset highlights on theme change
  (augroup :Theme
    (autocmd :ColorScheme "*" ":StatuslineResetHighlights")))

(defrecipe statusline
  (default [:NTBBloodbath/galaxyline.nvim] configure))
