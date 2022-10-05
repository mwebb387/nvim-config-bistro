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

; (fn build [self]
;   (if (= self.sourceDir "")
;     (print "Please set the Bistro source directory")
;     (let [buildScript (.. self.sourceDir "build.fnl")
;           buildDir (.. (vim.fn.stdpath :config) "/lua/")
;           cmd (.. "!" :fennel " " buildScript " " self.sourceDir " " buildDir)]
;       (vim.cmd cmd)))
;   self)

(fn build [self]
  (let [cmd (.. "!" :powershell " " :bistro-build.ps1)]
    (vim.cmd cmd))
  self)

(fn editConfig [self]
  (if (= self.sourceDir "")
    (print "Please set the Bistro source directory")
    (let [configFile (.. self.sourceDir "/configure.fnl")
          cmd (.. "edit " configFile)]
      (vim.cmd cmd)))
  self)

(fn editRecipe [self name]
  (if (= self.sourceDir "")
    (print "Please set the Bistro source directory")
    (let [recipeFile (.. self.sourceDir "/recipes/" name ".fnl")
          cmd (.. "edit " recipeFile)]
      (vim.cmd cmd)))
  self)

; (fn loadPlugins [self]
;   (let [packer (require :packer)]
;     (packer.setup (fn [use]
;       (each [_ plugin (ipairs self.plugins)]
;         (match (type plugin)
;           :string (use plugin)
;           :table (let [[repo options] plugin]
;                    (use repo options))))))))

(fn loadPlugins [self plugins]
  (let [plug-path (.. (vim.fn.stdpath :config) :/plugged/)]
    (vim.fn.plug#begin plug-path)
    (each [_ plugin (ipairs (or plugins self.plugins))]
      (match (type plugin)
        :string (vim.fn.plug# plugin)
        :table (let [[repo options] plugin]
                 (vim.fn.plug# repo options))))
    (vim.fn.plug#end))
  self)

(fn refresh [self]
  ; Clear bistro cache
  (tset package.loaded :configure nil)
  (tset package.loaded :bistro nil)
  (print "Cache cleared. Please re-require and run 'bistro:setup()'")
  self)




; Methods for new style config loading
(fn setupRecipes [self]
  (if (anyMissingPlugins)
    (do
      (print "Not all plugins are installed.")
      (print "Run :PlugInstall first, then re-run :lua require'bistro':setupRecipes()"))
    (do
      ; Set globals
      (each [key value (pairs self.config.globals)]
        (tset vim :g key value))

      ; Set options
      (each [key value (pairs self.config.options)]
        (tset vim :opt key value))
      
      ; Create keymaps
      (each [_ [maps lhs rhs opts] (ipairs self.config.keymaps)]
        (vim.keymap.set maps lhs rhs opts))
      
      ; Create Commands
      (each [key [cmd opts] (pairs self.config.commands)]
        (vim.api.nvim_create_user_command key cmd opts))
      
      ; Run setup methods
      (each [_ setupFn (ipairs self.config.setup)]
        (setupFn))
      ))
  self)

(fn setup [self]
  ; Load plugins
  (self:loadPlugins self.config.plugins)
  (self:setupRecipes)
  self)

(local bistro
  {:configs [] ;; For new style configs
   :plugins [] ;; Plugin paths and options
   :sourceDir ""
   :autoInstallPluginManager true
   :syncPlugins true
   : addPlugins
   : build
   : editRecipe
   : loadPlugins
   : refresh
   : setup
   : setupRecipes})

; Auto-load recipes
((require :configure) bistro)

bistro
