(import-macros m :macros)

;; TODO: Update code for locals
;; TODO: Update local naming conventions

; (let [x {:y {:foo 1}}]
;   (print x.y.foo))

(local galaxyline (require :galaxyline))
(local condition (require :galaxyline.condition))
(local fi (require :galaxyline.provider_fileinfo))
(local gls galaxyline.section)
(local theme (require :galaxyline.theme))
(local colors theme.default)
(local mode-color {:n colors.red
                   :i colors.green
                   :v colors.blue
                   ; [''] colors.blue ; TODO: how to index this?
                   :V colors.blue
                   :c colors.magenta
                   :no colors.red
                   :s colors.orange
                   :S colors.orange
                   ; :[''] colors.orange ; TODO: how to index this?
                   :ic colors.yellow
                   :R colors.violet
                   :Rv colors.violet
                   :cv colors.red
                   :ce colors.red
                   :r colors.cyan
                   :rm colors.cyan
                   :r? colors.cyan
                   :! colors.red
                   :t colors.red})
(local slbg (-> (vim.fn.hlID "CursorLine")
                (vim.fn.synIDattr "bg")))

(local leftCaps ["" "" "" "" ""])
(local rightCaps ["" "" "" "" ""])

; Get random end cap chars
(local randCapIdx (math.random (- (length leftCaps) 1)))
(local leftCap (. leftCaps randCapIdx))
(local rightCap (. rightCaps randCapIdx))

(fn section-end-left []
  (.. "   " leftCap))

(fn section-end-right []
  (.. rightCap "   "))

; TODO: Vim HI macro?
(fn mode-color-provider []
  ;auto change color according the vim mode
  (vim.api.nvim_command (.. "hi GalaxyViMode guifg=" (. mode-color (vim.fn.mode))))
  (.. "[" (vim.fn.mode) "]  "))

(fn status-left []
  [{:SectionCapLeft {:provider section-end-left
                     :highlight [colors.bg] }}

   {:ViMode {:provider mode-color-provider
             :highlight [colors.red colors.bg "bold"]}}

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
                      :icon " "
                      :highlight [colors.red colors.bg]}}

   {:DiagnosticWarn {:provider "DiagnosticWarn"
                     :icon " "
                     :highlight [colors.yellow colors.bg]}}

   {:DiagnosticHint {:provider "DiagnosticHint"
                     :icon " "
                     :highlight [colors.cyan colors.bg]}}

   {:DiagnosticInfo {:provider "DiagnosticInfo"
                     :icon " "
                     :highlight [colors.blue colors.bg]}}])

;; local function midCondition()
;;   local tbl = {['dashboard'] = true['']=true}
;;   if tbl[vim.bo.filetype] then
;;     return false
;;   end
;;   return true
;; end

; (fn git-branch-provider []
;   )

(fn status-mid []
  [
   ; {:ShowLspClient {:provider "GetLspClient"
   ;                  :condition midCondition
   ;                  :icon "  "
   ;                  :highlight [colors.cyan colors.bg "bold"]}}

   {:GitBranch {:provider (. vim.fn :fugitive#head)
                :icon "  "
                :separator " "
                :separator_highlight ["NONE" colors.bg]
                :condition condition.check_git_workspace
                :highlight [colors.violet colors.bg "bold"]}}

   {:DiffAdd {:provider "DiffAdd"
              :condition condition.hide_in_width
              :icon "  "
              :highlight [colors.green colors.bg]}}

   {:DiffModified {:provider "DiffModified"
                   :condition condition.hide_in_width
                   :icon " 柳"
                   :highlight [colors.orange colors.bg]}}

   {:DiffRemove {:provider "DiffRemove"
                 :condition condition.hide_in_width
                 :icon "  "
                 :highlight [colors.red colors.bg]}}])

(fn status-right []
  [{:FileEncode {:provider "FileEncode"
                 :condition condition.hide_in_width
                 :separator " "
                 :separator_highlight ["NONE" colors.bg]
                 :highlight [colors.green colors.bg "bold"]}}

   {:FileFormat {:provider "FileFormat"
                 :condition condition.hide_in_width
                 :separator " "
                 :separator_highlight ["NONE" colors.bg]
                 :highlight [colors.green colors.bg "bold"]}}

   {:LineInfo {:provider "LineColumn"
               :separator "  "
               :separator_highlight ["NONE" colors.bg]
               :highlight [colors.fg colors.bg]}}

   {:PerCent {:provider "LinePercent"
              :separator "  "
              :separator_highlight ["NONE" colors.bg]
              :highlight [colors.fg colors.bg "bold"]}}

   {:SectionCapRight {:provider sectionEndRight
                      :highlight [colors.bg]}}])

(fn status-short-line-left []
  [{:BufferType {:provider "FileTypeName"
                 :separator " "
                 :separator_highlight ["NONE" colors.bg]
                 :highlight [colors.blue colors.bg "bold"]}}

   {:SFileName {:provider  "SFileName"
                :condition condition.buffer_not_empty
                :highlight [colors.fg colors.bg "bold"]}}])

(fn status-short-line-right []
  [{:BufferIcon {:provider "BufferIcon"
                 :highlight [colors.fg colors.bg]}}])


;;
;; Methods and module def for resetting the highlight based on current theme highlihts
;;

(fn resetHiForSection [sec color]
  (each [_ obj (ipairs sec)]
    (each [key opt (pairs obj)]
      ; Handle the section caps differently than the normal sections
      (if (or (= key "SectionCapLeft")
              (= key "SectionCapRight"))
        (set (. opt.highlight 1) color)
        (set (. opt.highlight 2) color))

      ; Handle separator highlights
      (when opt.separator_highlight
        (set (. opt.separator_highlight 2) color)))))

(fn resetHiForStatusLine [gl color]
  (vim.api.nvim_command (.. "hi StatusLine cterm=NONE gui=NONE guibg=" color)) ; TODO: Vim Hi Macro?
  (each [_ prop (ipairs [:left :mid :right :short_line_left :short_line_right])]
    (resetHiForSection (. gl prop) color)))

  ; (resetHiForSection gl.left color)
  ; (resetHiForSection gl.mid color)
  ; (resetHiForSection gl.right color)

  ; (resetHiForSection gl.short_line_left color)
  ; (resetHiForSection gl.short_line_right color))

; local M = {}
; function M.resetHighlights()
;   local bg = vim.fn.synIDattr(vim.fn.hlID('CursorLine'), 'bg') 
;   resetHiForStatusLine(gls, bg)
; end

; return M

(fn configure []
  (set gls.left (status-left))
  (set gls.left (status-mid))
  (set gls.left (status-right))
  (set gls.left (status-short-line-left))
  (set gls.left (status-short-line-right)))

(fn plugins []
  [:glepnir/galaxyline.nvim])

{: configure : plugins}
