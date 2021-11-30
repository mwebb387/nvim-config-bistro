(fn build [self]
   (if (= self.sourceDir "")
      (print "Please set the Bistro source directory")
      (let [buildScript (.. self.sourceDir "/build.fnl")
            buildDir (.. (vim.fn.stdpath :config) :lua)
            args [:fennel buildScript self.sourceDir buildDir]]
         (vim.fn.system args)))
   self)

(fn createRecipe [self name]
   (if (= self.sourceDir "")
      (print "Please set the Bistro source directory")
      (print (.. "Init Recipe " name)))
   self)

(fn loadRecipes [self recipes]
   (each [module-name module-args (pairs recipes)]
      (table.insert self.modules module-name)
      (let [module (require (.. "modules/" module-name))]
         (each [_ plugin (ipairs (module.plugins (unpack module-args)))]
            (table.insert self.plugins plugin))
         (table.insert self.configs (fn [] (module.configure (unpack module-args))))))
   self)

(fn loadPlugins [self]
   (vim.cmd "call plug#begin(stdpath('config').'/plugged/')")
   (each [_ plugin (ipairs self.plugins)]
      (vim.cmd (.. "Plug \'" plugin "\'")))
   (vim.cmd "call plug#end()")
   self)

(fn configureRecipes [self]
   (each [_ config (ipairs self.configs)]
      (config))
   self)

(fn reload [self reloadPlugins reconfigureRecipes]
   ; Clear bistro cache
   (tset package.loaded :configure nil)
   (tset package.loaded :bistro nil)
   (each [_ module (ipairs self.modules)]
      (tset package.loaded (.. "modules/" module) nil))
   (print "Cache cleared. Please reload the Bistro")
   self)
   ; TODO: Reload all the things...
   ; (if reloadPlugins (self.loadPlugins))
   ; (if reconfigureRecipes (self.configureRecipes)))

(local bistro
   {:configs []
    :modules []
    :plugins []
    :commands []
    :sourceDir ""
    : build
    : createRecipe
    : configureBistro
    : configureRecipes
    : loadRecipes
    : loadPlugins
    : reload})

; Auto-load recipes
((require :configure) bistro)

bistro
