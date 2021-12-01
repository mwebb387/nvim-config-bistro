(import-macros {: defluacommand } :macros)

(fn plugins [] [])

(fn configure []
  (defluacommand :BistroBuild
    (fn []
      (: (require :bistro) :build)))

  (defluacommand :BistroEdit
    (fn []
      (let [bistro (require :bistro)]
        (if (= bistro.sourceDir "")
          (print "Please set the Bistro source directory")
          (let [bistroFile (.. bistro.sourceDir "/bistro.fnl")
                cmd (.. "edit " bistroFile)]
            (vim.cmd cmd))))))
            
  (defluacommand :BistroEditConfiguration
    (fn []
      (let [bistro (require :bistro)]
        (if (= bistro.sourceDir "")
          (print "Please set the Bistro source directory")
          (let [configFile (.. bistro.sourceDir "/configure.fnl")
                cmd (.. "edit " configFile)]
            (vim.cmd cmd)))))))

{: configure : plugins }
