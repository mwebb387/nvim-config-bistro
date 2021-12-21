(import-macros {: defcommand : defluacommand : defun } :macros)

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

  (defun TestMethod [arg1 arg2]
      (print (.. "This is a test!" arg1 arg2)))

  (defun ListRecipes [A L P]
    (let [bistro (require :bistro)]
        bistro.modules))

  (vim.cmd "command! -complete=customlist,v:lua.ListRecipes -nargs=1 BistroEditRecipe echo <args>")

; TODO: Command args...?
; (defluacommand :BistroEditRecipes
;   (fn []
;     (let [bistro (require :bistro)]
;       (bistro.editRecipe))))

  (defluacommand :BistroListRecipes
    (fn []
      (let [bistro (require :bistro)]
        (print (vim.inspect bistro.modules)))))

  (defcommand :BistroRefresh "lua require('bistro'):refresh()")

  (defcommand :BistroReloadPlugins "lua require('bistro'):loadPlugins()")

  (defcommand :BistroReconfigure "lua require('bistro'):configureRecipes()"))

  ; (defcommand :BistroReloadAndReconfigure ":BistroReloadPlugins\\<CR>|:BistroReconfigure\\<CR>"))

{: configure : plugins }
