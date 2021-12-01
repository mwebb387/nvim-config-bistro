(import-macros {: get-inputdir } :macros)

(fn build [self]
   (if (= self.sourceDir "")
      (print "Please set the Bistro source directory")
      (let [buildScript (.. self.sourceDir "/build.fnl")
            buildDir (.. (vim.fn.stdpath :config) :lua)
            args [:fennel buildScript self.sourceDir buildDir]]
         (vim.fn.system args)
         (print "Bistro build complete")))
   self)

(fn configureRecipes [self]
   (each [_ config (ipairs self.configs)]
      (config))
   self)

(fn editRecipe [self name]
   (if (= self.sourceDir "")
      (print "Please set the Bistro source directory")
      (let [recipeFile (.. self.sourceDir "/modules/" name ".fnl")
            cmd (.. "edit " recipeFile)]
         (vim.cmd cmd)))
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

(fn refresh [self reloadPlugins reconfigureRecipes]
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
    :functions []
    :sourceDir (get-inputdir)
    : build
    : configureRecipes
    : editRecipe
    : loadRecipes
    : loadPlugins
    : refresh})

; Auto-load recipes
((require :configure) bistro)

bistro
