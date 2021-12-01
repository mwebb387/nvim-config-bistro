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
            (vim.cmd cmd))))))
  (defluacommand :BistroRefresh
    (fn []
      (let [bistro (require :bistro)]
        (if (= bistro.sourceDir "")
          (print "Please set the Bistro source directory")
          (vim.cmd "lua require('bistro'):refresh()")))))

  (defluacommand :BistroReloadPlugins
    (fn []
      (let [bistro (require :bistro)]
        (if (= bistro.sourceDir "")
          (print "Please set the Bistro source directory")
          (do
            (vim.cmd "lua require('bistro'):refresh()")
            (vim.cmd "lua require('bistro'):loadPlugins()")
            (print "Bistro reloaded with plugins"))))))
  (defluacommand :BistroReloadAndReconfigure
    (fn []
      (let [bistro (require :bistro)]
        (if (= bistro.sourceDir "")
          (print "Please set the Bistro source directory")
          (do
            (vim.cmd "lua require('bistro'):refresh()")
            (vim.cmd "lua require('bistro'):loadPlugins():configureRecipes()")
            (print "Bistro reloaded and reconfigured")))))))

{: configure : plugins }
