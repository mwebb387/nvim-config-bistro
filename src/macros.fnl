(fn value-or-default [v default]
  "Get the value or a default if value is false"
  (or v default)) ; TODO: Check for null/undefined, not just false...

(fn format-table [tbl kv-format-fn separator]
  "Formats the Key/Value pairs in a table as a string using the supplied format method"
  (let [formatted (icollect [k v (pairs tbl)]
                            (kv-format-fn k (value-or-default v "")))]
    (table.concat formatted (or separator " "))))

(fn map-list [list map-fn]
  (icollect [_ v (ipairs list)]
            (map-fn v)))

(fn map-vim-args-to-lua [args]
  (let [sargs (map-list args (fn [a] (tostring a)))
        args-list-vim (map-list sargs (fn [a] (.. "'" a "':a:" a)))
        args-list-lua (map-list sargs (fn [a] (.. "_A." a)))]
    {:argtbl (.. "{" (table.concat args-list-vim ",") "}")
     :argslua (.. "(" (table.concat args-list-lua ", ") ")")
     :argsvim (.. "(" (table.concat sargs ", ") ")")}))

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

 :configure-bistro
 (fn [...]
   `(fn [bistro#]
      (doto bistro#
            ,...)))

 :with-recipes
 (fn [bistro ...]
   ; Collect each recipe name and its args pulled from each method call
   (let [mods (collect [i mod (ipairs [...])]
                       (values (tostring (. mod 1))
                               (icollect [i v (ipairs mod)]
                                         (when (> i 1) v))))]
     `(: ,bistro :prepareRecipes ,mods)))

 :defrecipe
 (fn [recipe-name ...]
   (let [args [...]
         {: concat} (require :util)
         modes []
         options []
         defaults []
         default-configs []
         mode-configs []
         option-configs []]

     ;; Collect each method sent to the macro
     (each [_ obj (ipairs args)]
       (match obj
         (where [keyword & rest] (= (tostring keyword) :mode)) (table.insert modes rest)
         (where [keyword & rest] (= (tostring keyword) :option)) (table.insert options rest)
         [keyword & rest] (table.insert defaults rest)))

     ;; Collect default definitions
     (each [_ default (ipairs defaults)]
       (let [[plugins config] default]
         (table.insert default-configs `(do
                                          (: bistro# :addPlugins ,plugins)
                                          (: bistro# :addConfig (fn [] (,config (unpack args#))))))))

     ;; Collect mode definitions
     (each [_ mode (ipairs modes)]
       (let [[mode-name plugins config] mode]
         (table.insert mode-configs `(util#.includes args# ,(tostring mode-name)))
         (table.insert mode-configs `(do
                                       (: bistro# :addPlugins ,plugins)
                                       (: bistro# :addConfig ,config)))))

     ;; Collect option definitions
     (each [_ option (ipairs options)]
       (let [[option-name plugins config] option]
         (table.insert option-configs `(when (util#.includes args# ,(tostring option-name))
                                         (: bistro# :addPlugins ,plugins)
                                         (: bistro# :addConfig ,config)))))

     `(fn ,recipe-name [bistro# ...]
       (let [args# [...]
             util# (require :util)]

         ;; Add default plugins and config
         ,(unpack default-configs)

         ;; Add Modes
         (if ,(unpack mode-configs))

         ;; Add Options
         ,(unpack option-configs)))))

 :defcommand
 (fn [name command options]
   (let [opts- (or options {})]
     `(vim.api.nvim_create_user_command ,(tostring name) ,command ,opts-)))

 :defhighlight
 (fn [group args]
   (let [hi (.. "highlight " group)
         flds (format-table args (fn [k v] (.. k "=" (tostring v))))
         cmd (.. hi " " flds)]
     `(vim.cmd ,cmd)))

 :defmap
 (fn [modes lhs rhs opts]
   (let [opts- (or opts {})]
     `(vim.keymap.set ,modes ,lhs ,rhs ,opts-)))

 :defsign
 (fn [name args]
   (let [sign (.. "sign define " name)
         flds (format-table args (fn [k v] (.. k "=" (tostring v))))
         cmd (.. sign " " flds)]
     `(vim.cmd ,cmd)))

 :defun ; Define lua function in global scope
 (fn [name args ...]
   (let [n (tostring name)
         lua-fn `(fn ,args ,...)]
     `(global ,name ,lua-fn)))

 :let-g
 (fn let-g [key value]
   `(tset vim.g ,(tostring key) ,value))

 :set!
 (fn [name value]
   `(tset vim.opt ,name ,value))

 :set-test!
 (fn [name value]
   `(set vim.opt.,name ,value))

 ;TODO: Add more here...
 :syntax-sync
 (fn []
   `(vim.cmd "syntax sync fromstart"))

 :append!
 (fn [name value]
   `(: (. vim.opt ,name) :append ,value))

 :get-inputdir
 (fn [] `,_G.inputdir)}

