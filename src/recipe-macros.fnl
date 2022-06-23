(fn concat [list1 list2]
  (let [result []]
    (each [_ v (ipairs list1)]
      (table.insert result v))
    (each [_ v (ipairs list2)]
      (table.insert result v))
    result))

(fn append [list1 list2]
  (each [_ v (ipairs list2)]
    (table.insert list1 v)))

(fn includes [list value]
  (let [[first & rest] list]
    (or (= first value)
        (and (> (length rest) 0)
             (includes rest value)))))

(fn filter [lst filter-fn] 
  (icollect [_ x (ipairs lst)]
            (if (filter-fn x)
              x)))

(fn filter-by-types [lst types]
  (filter lst (fn [x]
                (includes types (. x :type)))))

(fn filter-by-names [lst names]
  (filter lst (fn [x]
                (includes names (. x :name)))))

(fn map [lst mapfn]
  (icollect [_ x (ipairs lst)]
            (mapfn x)))

(fn merge-table [tbl1 tbl2]
  (each [k v (pairs tbl2)]
    (tset tbl1 k v)))

;; Recipe specific helpers
(fn merge-recipes [recipe1 other-recipes]
  (each [_ v (ipairs other-recipes)]
    ; Merge globals
    (merge-table recipe1.globals (or v.globals {}))
    ; Merge options
    (merge-table recipe1.options (or v.options {}))
    ; Merge keymaps
    (append recipe1.keymaps (or v.keymaps {}))
    ; Merge commands
    (merge-table recipe1.commands (or v.commands {}))
    ; Merge plugins
    (append recipe1.plugins (or v.plugins {}))
    ; Merge setup methods
    (append recipe1.setup (or v.setup {})))
  recipe1)

;; Default recipe config
;; TODO: Auto-commands
(fn default-config []
  {:globals {} 
   :options {}
   :keymaps []
   :commands {}
   :plugins []
   :setup []})


;; Macro definitions
(fn defrecipe [name]
  (when (not _G.recipes)
    (tset _G :recipes {}))
  (set _G.recipe-name name)
  (tset _G :recipes name []))

(fn in-recipe [name]
  (set _G.recipe-name name))

; TODO: Error checking for recipe-name...
; TODO: change to 'with-options' or similar within defconfig call below
; (fn defconfig [config]
;   (let [recipe (. _G :recipes _G.recipe-name)]
;     (table.insert recipe config)))

; TODO: Error checking for recipe names
(fn load-recipes [...]
  (let [config (default-config)]
    (each [i mod (ipairs [...])]
      (let [[recipe-name & args] mod
            name (tostring recipe-name)]
        (require (.. :recipes/ name))
        (local recipe (. _G :recipes name))
    
        ; Gather recipe plugins and methods
        (let [default (filter-by-types recipe [:default])
              [mode] (-> recipe
                         (filter-by-types [:mode])
                         (filter-by-names args))
              options (-> recipe
                          (filter-by-types [:option])
                          (filter-by-names args))
              all (-> default
                      (concat [mode])
                      (concat options))
              merged (merge-recipes (default-config) all)]

          (doto merged
            (tset :name name)
            (tset :type nil))
          (merge-recipes config [merged]))))

    `(fn [bistro#]
       (tset bistro# :config ,config))
  )
)

;; Recipe creation helper macros
(fn as-mode! [config name]
  (tset config :type :mode)
  (tset config :name name))

(fn as-option! [config name]
  (tset config :type :option)
  (tset config :name name))

(fn command! [config name command options]
  (tset config.commands (tostring name) [command (or options {})]))

(fn log [config]
  (print (view config)))

(fn map! [config modes lhs rhs opts]
  (let [opts- (or opts {})]
    (table.insert config.keymaps [modes lhs rhs opts-])))

(fn set! [config option value options]
  (if options
    (tset config.options (tostring option) [value options])
    (tset config.options (tostring option) value)))

(fn set-g! [config option value options]
  (if options
    (tset config.globals (tostring option) [value options])
    (tset config.globals (tostring option) value)))

(fn setup! [config setupFn]
  (table.insert config.setup setupFn))

(fn use! [config plugins]
  (append config.plugins plugins))

(local recipe-helpers {: as-mode!
                       : as-option!
                       : command!
                       : log
                       : map!
                       : set!
                       : set-g!
                       : setup!
                       : use!})

(fn defconfig [...]
  (let [body [...]
        ;; TODO: See if 'defconfig' can be used here/below
        recipe (. _G :recipes _G.recipe-name)
        config (default-config)]
    (tset config :type :default)

    (each [_ [m & rest] (ipairs body)]
      (let [method (. recipe-helpers (tostring m))]
        ; (print (.. "Calling method " (tostring m) " with args " (view rest)))
        (method config (unpack rest)))
      )
    
    (table.insert recipe config)
    ; (print (.. "Config - " (view config)))
    ; (print (.. "Recipe - " (view recipe)))

    ))

{: defrecipe
 : defconfig
 ; : defmode
 ; : defoption
 : in-recipe
 : load-and-print-recipe
 : load-recipes
 
 : as-mode!
 : as-option!
 : command!
 : map!
 : log
 : set!
 : setup!
 : use!}
