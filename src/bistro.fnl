(import-macros {: get-inputdir } :macros)

(local {: concat} (require :util))

;; Helper methods
(fn pconfigure [config]
  "Protected call for a recipe's configure method"
  (let [(res err) (pcall config)]
    (when (not res) (print err))))

;; Bistro methods
(fn addPlugins [self plugins]
  (concat self.plugins plugins))

(fn addConfig [self config]
  (table.insert self.configs config))

(fn build [self]
   (if (= self.sourceDir "")
      (print "Please set the Bistro source directory")
      (let [buildScript (.. self.sourceDir "../build.fnl")
            buildDir (.. (vim.fn.stdpath :config) "/" :lua "/")
            cmd (.. "!" :fennel " " buildScript " " self.sourceDir " " buildDir)]
         (vim.cmd cmd)))
   self)

(fn configureRecipes [self]
   (each [_ config (ipairs self.configs)]
      (pconfigure config))
   self)

(fn editRecipe [self name]
   (if (= self.sourceDir "")
      (print "Please set the Bistro source directory")
      (let [recipeFile (.. self.sourceDir "/recipes/" name ".fnl")
            cmd (.. "edit " recipeFile)]
         (vim.cmd cmd)))
   self)

(fn loadRecipes [self recipes]
   (each [recipe-name recipe-args (pairs recipes)]
      (table.insert self.recipes recipe-name)
      (let [recipe (require (.. "recipes/" recipe-name))]
         (each [_ plugin (ipairs (recipe.plugins (unpack recipe-args)))]
            (table.insert self.plugins plugin))
         (table.insert self.configs (fn [] (recipe.configure (unpack recipe-args))))))
   self)

(fn prepareRecipes [self recipes]
  (each [recipe-name recipe-args (pairs recipes)]
    (table.insert self.recipes recipe-name)
    (let [recipe (require (.. "recipes/" recipe-name))]
      (recipe.prepare self (unpack recipe-args))))
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
   (each [_ recipe (ipairs self.recipes)]
      (tset package.loaded (.. "recipes/" recipe) nil))
   (print "Cache cleared. Please reload the Bistro")
   self)
   ; TODO: Reload all the things...
   ; (if reloadPlugins (self.loadPlugins))
   ; (if reconfigureRecipes (self.configureRecipes)))

(local bistro
   {:configs []
    :recipes []
    :plugins []
    :functions []
    :sourceDir (get-inputdir)
    : addConfig
    : addPlugins
    : build
    : configureRecipes
    : editRecipe
    : loadRecipes
    : loadPlugins
    : prepareRecipes
    : refresh})

; Auto-load recipes
((require :configure) bistro)

bistro
