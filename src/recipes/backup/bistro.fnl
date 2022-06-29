(import-macros {: defrecipe
                : defcommand
                : defmap
                : defun
                : augroup
                : autocmd}
               :macros)

(fn configure-commands []

  ; Test autocmd
  (augroup PlugTest
    (autocmd "BufUnload" :vim-plug ":lua print'Leaving Vim-Plug Buffer!'"))

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

  (defun ListOperations [A L P]
    [:build
     :refresh
     :plugins
     :configure])
  
  (defcommand Bistro
    (fn [cmd]
      (let [bistro (require :bistro)
            {: args} cmd]
            (match args
              :build (bistro:build)
              :refresh (bistro:refresh)
              :plugins (bistro:loadPlugins)
              :configure (bistro:configureRecipes))))
    {:complete "customlist,v:lua.ListOperations"
     :nargs 1})

  (defcommand BistroEditRecipe
    (fn [cmd] 
      (let [bistro (require :bistro)
            {: args} cmd]
        (bistro:editRecipe args)))
    {:complete "customlist,v:lua.ListRecipes"
     :nargs 1})

  (defcommand :BistroReloadAndReconfigure "lua require('bistro'):loadPlugins():configureRecipes()")
  
  (defun BistroRebuildReloadAndReconfigure []
    (vim.cmd ":Bistro build")
    (vim.cmd ":Bistro refresh")
    (vim.cmd ":BistroReloadAndReconfigure"))
  
  (defcommand BistroReconstruct "exe v:lua.BistroRebuildReloadAndReconfigure()"))

(fn configure-maps []
  (defmap [:n] :<leader>BB :BistroReconstruct<CR>)
  (defmap [:n] :<leader>Bb :BistroBuild<CR>)
  (defmap [:n] :<leader>Br :BistroRefresh<CR>)
  (defmap [:n] :<leader>Bp :BistroReloadPlugin<CR>)
  (defmap [:n] :<leader>Bc :BistroReconfigure<CR>))

(fn configure []
  (configure-commands)
  (configure-maps))

(defrecipe bistro
  (default [] configure))
