(import-macros {: get-inputdir } :macros)

(local {: concat} (require :util))

;; Helper methods
; (fn bootstrap []
;   (let [install-path (.. (vim.fn.stdpath :data) :/site/pack/packer/start/packer.nvim)
;         needs-install (-> install-path
;                           (vim.fn.glob)
;                           (vim.fn.empty))]
;     (when (> needs-install 0)
;       (vim.fn.system {:git
;                       :clone
;                       :--depth
;                       :1
;                       "https://github.com/wbthomason/packer.nvim"
;                       install-path}))))

(fn anyMissingPlugins []
  (> (-> vim.g.plugs
        (vim.fn.values)
        (vim.fn.filter "!isdirectory(v:val.dir)")
        (vim.fn.len))
     0))

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
  (if (anyMissingPlugins)
    (do
      (print "Not all plugins are installed.")
      (print "Run :PlugInstall first, then re-run :lua require'bistro':configureRecipes()"))
    (each [_ config (ipairs self.configs)]
      (pconfigure config)))
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

; (fn loadPlugins [self]
;   (let [packer (require :packer)]
;     (packer.setup (fn [use]
;       (each [_ plugin (ipairs self.plugins)]
;         (match (type plugin)
;           :string (use plugin)
;           :table (let [[repo options] plugin]
;                    (use repo options))))))))

(fn loadPlugins [self]
  (let [plug-path (.. (vim.fn.stdpath :config) :/plugged/)]
    (vim.fn.plug#begin plug-path)
    (each [_ plugin (ipairs self.plugins)]
      (match (type plugin)
        :string (vim.fn.plug# plugin)
        :table (let [[repo options] plugin]
                 (vim.fn.plug# repo options))))
    (vim.fn.plug#end))
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

; Auto-load recipes
((require :configure) bistro)

bistro
