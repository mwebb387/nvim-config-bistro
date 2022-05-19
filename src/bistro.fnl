(import-macros {: get-inputdir } :macros)

(local {: concat} (require :util))

;; Helper methods
(fn bootstrap []
  (print "Bootstrapping Packer...")
  (let [install-path (.. (vim.fn.stdpath :data) :/site/pack/packer/start/packer.nvim)
        needs-install (-> install-path
                          (vim.fn.glob)
                          (vim.fn.empty))]
    (when (> needs-install 0)
      (vim.fn.system [:git
                      :clone
                      :--depth
                      :1
                      "https://github.com/wbthomason/packer.nvim"
                      install-path])))
  ; (vim.cmd "packadd packer.nvim")
  (print "Bootstrapped!"))

(fn pconfigure [config]
  "Protected call for a recipe's configure method"
  (let [(res err) (pcall config)]
    (when (not res) (print err))))

;; Bistro methods
(fn addPlugins [self plugins]
  (concat self.plugins plugins))

(fn addConfig [self config]
  (when config
    (table.insert self.configs config)))

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

(fn prepareRecipes [self recipes]
  (each [recipe-name recipe-args (pairs recipes)]
    (table.insert self.recipes recipe-name)
    (let [load-recipe (require (.. "recipes/" recipe-name))]
      (load-recipe self (unpack recipe-args))))
  self)

(fn loadPlugins [self]
  (let [packer (require :packer)]
    (packer.startup (fn [use]
                      (use :wbthomason/packer.nvim)
                      (each [_ plugin (ipairs self.plugins)]
                        (-> plugin (vim.inspect) (print))
                        (use plugin)))))
  self)

(fn refresh [self reloadPlugins reconfigureRecipes]
   ; Clear bistro cache
   (tset package.loaded :configure nil)
   (tset package.loaded :bistro nil)
   (each [_ recipe (ipairs self.recipes)]
      (tset package.loaded (.. "recipes/" recipe) nil))
   (print "Cache cleared. Please reload the Bistro")
   self)

(local bistro
   {:configs []
    :recipes []
    :plugins []
    :functions []
    :sourceDir (get-inputdir)
    :autoInstallPluginManager true
    :syncPlugins true
    : addConfig
    : addPlugins
    : build
    : configureRecipes
    : editRecipe
    : loadPlugins
    : prepareRecipes
    : refresh
    : setup})

; Bootstrap Packer and install if needed
(bootstrap)

; Auto-load recipes
((require :configure) bistro)

bistro
