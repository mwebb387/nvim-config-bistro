; ,help

; ,reset

;fennel


;; === WIP ===
; (fn list-files [dir recurse]
;    (let [ls (if recurse "dir /A-D /B /S " "dir /A-D /B ")]
;       (with-open [fin (io.popen (.. ls dir))]
;          (icollect [line (fin:lines)]
;             (string.gsub line dir "")))))

; (fn get-input-files []
;    (let [files (icollect [i v (ipairs (list-files :C:\Users\mwebb\fennel\src\modules true))] (.. "modules" v))]
;       (table.insert files "configure")
;       files))

; (get-input-files)

;; =========

;; TODO: Handle recursive module resolution in folders...
;; TODO: Handle output paths that don't exist yet...

(local fennel (require :fennel))

(local configure
   {:in-dir "C:/Users/mwebb/fennel/src/"
    :in-files ["configure"
               "modules/lsp/attach"
               "modules/lsp/handlers"
               "modules/lsp/init"
               "modules/default"
               "modules/files"
               "modules/themes"
               "modules/csharp"
               "modules/telescope"]
    ; :in-files ["modules/statusline"]
    :out-dir "C:/Users/mwebb/AppData/Local/nvim/lua/"})

(set fennel.path (.. configure.in-dir "?.fnl;" fennel.path))

(fn bake-file [file]
   (let [{: in-dir : out-dir} configure]
      (with-open [fin (io.open (.. in-dir file ".fnl") :r) fout (io.open (.. out-dir file ".lua") :w)]
         (fout:write (tostring (fennel.compile-string (fin:read :*all)))))))

(fn bake []
   (each [_ file (ipairs configure.in-files)]
      (bake-file file)))

(bake)

