(fn list-files [dir recurse]
   "List files using file system file listing (potentially unsecure)"
   (let [ls (if recurse "dir /A-D /B /S " "dir /A-D /B ")]
      (with-open [fin (io.popen (.. ls dir))]
         (icollect [line (fin:lines)]
            line))))

(fn get-input-files [in-dir]
   "Get all bistro files/recipes excluding the macros.fnl file"
   (icollect [i v (ipairs (list-files in-dir true))]
                         (when (and
                                  (not (string.find v :macros))
                                  (string.find v ".fnl"))
                            v)))

(fn format-output-filename [file in-dir out-dir]
   "Format filepath for writing compiled output"
   (-> file
      (string.gsub in-dir out-dir)
      (string.gsub ".fnl" ".lua")))


(fn compile-file [file in-dir out-dir fennel]
   "Use fennel to compile a .fnl source file to Lua"
   (with-open [fin (io.open file :r)
               fout (io.open (format-output-filename file in-dir out-dir) :w)]
      (fout:write (tostring (fennel.compile-string (fin:read :*all))))))

(fn report-compile-error [in-file err]
   "Report compilation error to stdout"
   (print (.. "Compile error in " in-file "\n" err)))

(fn try-compile [file in-dir out-dir fennel]
   "Attempt to compile a .fnl file to Lua, reporting any errors to stdout"
   (let [(res err) (pcall compile-file file in-dir out-dir fennel)]
      (when (not res) (report-compile-error file err))))

(fn build [input-dir output-dir]
   "Build the config bistro library with all recipes"
   (let [in-files (get-input-files input-dir)
         fennel (require :fennel)]
      (set fennel.path (.. input-dir "?.fnl;" fennel.path))
      (each [_ file (ipairs in-files)]
         (try-compile file input-dir output-dir fennel))))


; Get input and output paths from args
(local (in out) ...)

; Check args and build
(if (and in out)
   (build in out)
   (do
      (print "Please supply both 'in' and 'out' directory parameters to build.fnl")
      (print "Ex. fennel ./build.fnl <indir> <outdir>")))

