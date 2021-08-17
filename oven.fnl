; ,help

; ,reset

;fennel

(local fennel (require :fennel))

(local configure
   {:in-dir "C:/Users/mwebb/fennel/"
    :in-files ["configure" "modules/default" "modules/themes"]
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

