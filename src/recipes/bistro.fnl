(import-macros {: defcommand : defun } :macros)

(fn plugins [] [])

(fn configure []
  (defcommand :BistroBuild
    (fn []
      (: (require :bistro) :build)))

  (defcommand :BistroEdit
    (fn []
      (let [bistro (require :bistro)]
        (if (= bistro.sourceDir "")
          (print "Please set the Bistro source directory")
          (let [bistroFile (.. bistro.sourceDir "/bistro.fnl")
                cmd (.. "edit " bistroFile)]
            (vim.cmd cmd))))))
            
  (defcommand :BistroEditConfiguration
    (fn []
      (let [bistro (require :bistro)]
        (if (= bistro.sourceDir "")
          (print "Please set the Bistro source directory")
          (let [configFile (.. bistro.sourceDir "/configure.fnl")
                cmd (.. "edit " configFile)]
            (vim.cmd cmd))))))

  (defun ListRecipes [A L P]
    (let [bistro (require :bistro)]
        bistro.recipes))

  (defcommand BistroEditRecipe
    (fn [recipe] 
      (let [bistro (require :bistro)]
        (bistro:editRecipe (tostring recipe))))
    {:complete "customlist,v:lua.ListRecipes"
     :nargs 1})

  (defcommand :BistroRefresh "lua require('bistro'):refresh()")

  (defcommand :BistroReloadPlugins "lua require('bistro'):loadPlugins()")

  (defcommand :BistroReconfigure "lua require('bistro'):configureRecipes()")

  (defcommand :BistroReloadAndReconfigure "lua require('bistro'):loadPlugins():configureRecipes()"))

{: configure : plugins }
