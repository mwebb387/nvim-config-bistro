(fn format-table [tbl kv-format-fn]
    "Formats the Key/Value pairs in a table as a string using the supplied format method"
    (let [formatted (icollect [k v (pairs tbl)]
                              (kv-format-fn k v))]
        (table.concat formatted " ")))

(fn inc [n]
    "Increment a number 'n' by 1"
    (+ n 1))

(fn flags-from-args [...]
    "Converts a list of arguments to a table where each Key is an argument and each value is 'true'"
    (let [tbl {}
          lst [...]]
        (each [_ v (ipairs lst)]
            (tset tbl (. lst v) true))
        tbl))

; TODO: error checking
(fn table-from-args [...]
    "Converts a list of arguments, as pairs, to a Key/Value table"
    (let [tbl {}
          lst [...]]
        (for [i 1 (length lst) 2]
            (tset tbl (. lst i) (. lst (inc i))))
        tbl))

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

 :configure-bistro
 (fn [...]
     `(let [bistro# (require :bistro)]
          (doto bistro#
              ,...
              (: :load-plugins)
              (: :configure-recipes))))

 :with-recipes
 (fn [bistro ...]
     ; Collect each module name and its args pulled from each method call
     (let [mods (collect [i mod (ipairs [...])]
                         (values (tostring (. mod 1))
                                 (icollect [i v (ipairs mod)]
                                           (when (> i 1) v))))]
         `(: ,bistro :load-recipes ,mods)))

 :defhighlight
 (fn [group args]
     (let [hi (.. "highlight " group)
           flds (format-table args (fn [k v] (.. k "=" v)))
           cmd (.. hi " " flds)]
         `(vim.cmd ,cmd)))

 :defmap
 (fn [modes lhs rhs opts]
     (let [opts- (or opts {:noremap true})
           out []]
         (each [_ mode (ipairs modes)]
             (table.insert out `(vim.api.nvim_set_keymap ,(tostring mode) ,lhs ,rhs ,opts-)))
         `,(unpack out)))

 :defsign
 (fn [name args]
     (let [sign (.. "sign define " name)
           flds (format-table args (fn [k v] (.. k "=" v)))
           cmd (.. sign " " flds)]
         `(vim.cmd ,cmd)))

 :let-g
 (fn let-g [key value]
     `(tset vim.g ,(tostring key) ,value))

 :module
 (fn [module-table module-name ...]
     `(let [module# (require (.. "modules." ,module-name))]
          (each [_# plugin# (ipairs (module#.plugins ,...))]
              (table.insert (. ,module-table :plugins) plugin#))
          (table.insert (. ,module-table :configs) (fn [] (module#.configure ,...)))))

:set!
(fn [name value]
    `(tset vim.opt ,name ,value))

;TODO: Add more here...
:syntax-sync
(fn []
    `(vim.cmd "syntax sync fromstart"))

:append!
(fn [name value]
    `(: (. vim.opt ,name) :append ,value))}
