{:augroup
 (fn [name ...]
     (let [cmds (if ... `[(do ,...)] `[])]
         `(do
              (vim.cmd (.. "augroup " ,(tostring name)))
              (vim.cmd "autocmd!")
              ,(unpack cmds)
              (vim.cmd "augroup END"))))

 :autocmd
 (fn [event pattern cmd]
     (let [cmd (.. "autocmd " (tostring event) " " (tostring pattern) " " (tostring cmd))]
         `(vim.cmd ,cmd)))

 :configure
 (fn [...]
     `(let [module-table# {:plugins [] :configs []}]
          (doto module-table#
                ,...)

          ;; First configure all the plugins
          (vim.cmd "call plug#begin(stdpath('config').'/plugged/')")
          (each [_# plugin# (ipairs module-table#.plugins)]
              (vim.cmd (.. "Plug '" plugin# "'")))
          (vim.cmd "call plug#end()")

          ;; Next call each configure method for the modules
          (each [_# config# (ipairs module-table#.configs)]
              (config#))))

 :configure-modules
 (fn [...]
     ; First collect each module name and its args pulled from each method call
     (let [mods (collect [i mod (ipairs [...])]
                    (values (tostring (. mod 1))
                            (icollect [i v (ipairs mod)]
                                (when (> i 1) v))))]

         ; Import each module, collect all plugins and cache all configure calls
         `(let [module-table# {:plugins [] :configs []}]
              (each [module-name# module-args# (pairs ,mods)]
                  (let [module# (require (.. "modules." module-name#))]
                      (each [_# plugin# (ipairs (module#.plugins (unpack module-args#)))]
                          (table.insert (. module-table# :plugins) plugin#))
                      (table.insert (. module-table# :configs) (fn [] (module#.configure (unpack module-args#))))))

              ;; First configure all the plugins
              (vim.cmd "call plug#begin(stdpath('config').'/plugged/')")
              (each [_# plugin# (ipairs module-table#.plugins)]
                  (vim.cmd (.. "Plug \'" plugin# "\'")))
              (vim.cmd "call plug#end()")

              ;; Next call each configure method for the modules
              (each [_# config# (ipairs module-table#.configs)]
                  (config#)))))

 :let-g
 (fn let-g [key value]
     `(tset vim.g ,(tostring key) ,value))

 :map!
 (fn [modes lhs rhs opts]
     (let [opts- (or opts {:noremap true})
           out []]
         (each [_ mode (ipairs modes)]
             (table.insert out `(vim.api.nvim_set_keymap ,(tostring mode) ,lhs ,rhs ,opts-)))
         `,(unpack out)))

 :module
 (fn [module-table module-name ...]
     `(let [module# (require (.. "modules." ,module-name))]
         (each [_# plugin# (ipairs (module#.plugins ,...))]
             (table.insert (. ,module-table :plugins) plugin#))
         (table.insert (. ,module-table :configs) (fn [] (module#.configure ,...)))))

 :opt
 (fn [name value]
    `(tset vim.opt ,name ,value))
 
 :set!
 (fn [name value]
    `(tset vim.opt ,name ,value))

 :append!
 (fn [name value]
    `(: (. vim.opt ,name) :append ,value))
 
 :plug!
 (fn [id]
    `(vim.cmd (.. "Plug " ,id))) ;; ,opts))) ; How to convert 'opts'?

 :plugs!
 (fn [...]
    `(do
        (vim.cmd "call plug#begin(stdpath('config').'/plugged/')")
        ,...
        (vim.cmd "call plug#end()")))}
