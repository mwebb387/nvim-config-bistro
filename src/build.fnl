(fn sanitize-paths [paths]
  (icollect [i path (ipairs paths)]
    (-> path
      (string.gsub "\\" "/")
      (string.gsub "\\\\" "/"))))

(fn unsanitize-path [path]
  (-> path
    (string.gsub "/" "\\")
    (string.gsub "\\\\" "\\")))

(fn list-files [dir recurse]
   "List files using file system file listing (potentially unsecure)"
   (let [ls (if recurse "dir /A-D /B /S " "dir /A-D /B ")]
      (with-open [fin (io.popen (.. ls (unsanitize-path dir)))]
         (icollect [line (fin:lines)]
            (if recurse line (.. dir line))))))

; Check if a list is empty
(fn empty? [lst]
  (= 0 (length lst)))

; Check to see if any substring in the list
; match any part of the input value
(fn includes-part [list value]
  (let [[first & rest] list]
    (or (string.find value first)
        (and (> (length rest) 0)
             (includes-part rest value)))))

(fn get-input-files [in-dir filter-files]
   "Get all bistro files/recipes excluding the macros.fnl file"
   (icollect [i v (ipairs (sanitize-paths (list-files in-dir false)))]
                         (when (and
                                  (not (string.find v :build))
                                  (not (string.find v :macros))
                                  (not (string.find v :test))
                                  (or (empty? filter-files)
                                      (includes-part filter-files v))
                                  (string.find v ".fnl"))
                            v)))

(fn format-output-filename [file in-dir out-dir]
  "Format filepath for writing compiled output"
  (let [fmt (string.gsub in-dir :%- :%%-)]
    (-> file
        (string.gsub fmt out-dir)
        (string.gsub ".fnl" ".lua"))
    ))


(fn compile-file [file in-dir out-dir fennel]
   ; "Use fennel to compile a .fnl source file to Lua"
   (with-open [fin (io.open file :r)
               fout (io.open (format-output-filename file in-dir out-dir) :w)]
      (fout:write (tostring (fennel.compile-string (fin:read :*all))))))

(fn report-compile-error [in-file err]
   "Report compilation error to stdout"
   (print (.. "Compile error in " in-file "\n" err)))

(fn try-compile [file in-dir out-dir fennel]
   "Attempt to compile a .fnl file to Lua, reporting any errors to stdout"
   (print (.. "Compiling " file))
   (let [(res err) (pcall compile-file file in-dir out-dir fennel)]
      (when (not res) (report-compile-error file err))))

(fn build [input-dir output-dir files]
   "Build the config bistro library with all recipes"
   (let [in-files (get-input-files input-dir (or files []))
         fennel (require :fennel)]
      (each [_ file (ipairs in-files)]
         (try-compile file input-dir output-dir fennel))))


; Get input and output paths from args
(local [in out & files] (sanitize-paths [...]))

(tset _G :inputdir in)

; Check args and build
(if (and in out)
  (do
     (build in out files)
     (print "Bistro build complete"))
  (do
     (print "Please supply both 'in' and 'out' directory parameters to build.fnl")
     (print "Ex. fennel ./build.fnl <indir> <outdir>")))

