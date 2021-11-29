(fn initRecipe [self name]
   (print (.. "Init Recipe " name)))

(fn configureBistro [self]
   (print "Configure Bistro!"))

(fn loadRecipes [self recipes]
   (each [module-name module-args (pairs recipes)]
      (table.insert self.modules module-name)
      (let [module (require (.. "modules." module-name))]
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

; (local bistro {:configs []
;                :modules []
;                :plugins []
;                : configureBistro
;                : configureRecipes
;                : initRecipe
;                : loadRecipes
;                : loadPlugins})

; (set _G.bistro bistro)

; bistro

(let [bistro {:configs []
              :modules []
              :plugins []
              : configureBistro
              : configureRecipes
              : initRecipe
              : loadRecipes
              : loadPlugins}]
   (set _G.bistro bistro)
   bistro)