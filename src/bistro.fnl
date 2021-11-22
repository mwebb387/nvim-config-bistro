(fn init-recipe [self name]
   (print (.. "Init Recipe " name)))

(fn configure-bistro [self]
   (print "Configure Bistro!"))

(fn load-recipes [self recipes]
   (each [module-name module-args (pairs recipes)]
      (table.insert self.modules module-name)
      (let [module (require (.. "modules." module-name))]
         (each [_ plugin (ipairs (module.plugins (unpack module-args)))]
            (table.insert self.plugins plugin))
         (table.insert self.configs (fn [] (module.configure (unpack module-args))))))
   self)

(fn load-plugins [self]
   (vim.cmd "call plug#begin(stdpath('config').'/plugged/')")
   (each [_ plugin (ipairs self.plugins)]
      (vim.cmd (.. "Plug \'" plugin "\'")))
   (vim.cmd "call plug#end()")
   self)

(fn configure-recipes [self]
   (each [_ config (ipairs self.configs)]
      (config))
   self)

{:configs []
 :modules []
 :plugins []
 : configure-bistro
 : configure-recipes
 : init-recipe
 : load-recipes
 : load-plugins}
