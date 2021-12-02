(fn value-or-default [v default]
  "Get the value or a default if value is false"
  (or v default)) ; TODO: Check for null/undefined, not just false...

(fn format-table [tbl kv-format-fn]
  "Formats the Key/Value pairs in a table as a string using the supplied format method"
  (let [formatted (icollect [k v (pairs tbl)]
                            (kv-format-fn k (value-or-default v "")))]
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

 :configure-bistro
 (fn [...]
   `(fn [bistro#]
      (doto bistro#
            ,...)))

 :with-recipes
 (fn [bistro ...]
   ; Collect each module name and its args pulled from each method call
   (let [mods (collect [i mod (ipairs [...])]
                       (values (tostring (. mod 1))
                               (icollect [i v (ipairs mod)]
                                         (when (> i 1) v))))]
     `(: ,bistro :loadRecipes ,mods)))

 :defcommand
 (fn [name command]
   (let [cmd (.. "command! " (tostring name) " " command)]
     `(vim.cmd ,cmd)))

 :defluacommand
 (fn [name lua-fn]
   (let [n (tostring name)
         cmd (.. "command! " n " lua require('bistro').functions." n "()")]
     `(do 
        (tset (require :bistro) :functions ,n ,lua-fn)
        (vim.cmd ,cmd))))

 :defhighlight
 (fn [group args]
   (let [hi (.. "highlight " group)
         flds (format-table args (fn [k v] (.. k "=" (tostring v))))
         cmd (.. hi " " flds)]
     `(vim.cmd ,cmd)))

 :defmap
 (fn [modes lhs rhs opts]
   (let [opts- (or opts {:noremap true})
         out []
         rhs- (match (type rhs)
                :string rhs
                :table (let [fn-id (gensym)]
                         `(tset (require :bistro) :functions ,fn-id ,rhs)
                         (.. "lua require('bistro').functions." fn-id "()")))]
     (each [_ mode (ipairs modes)]
       (table.insert out `(vim.api.nvim_set_keymap ,(tostring mode) ,lhs ,rhs- ,opts-)))
     `,(unpack out)))

 :defsign
 (fn [name args]
   (let [sign (.. "sign define " name)
         flds (format-table args (fn [k v] (.. k "=" (tostring v))))
         cmd (.. sign " " flds)]
     `(vim.cmd ,cmd)))

 :defun
 (fn [name func]
   (let [n (tostring name)
         keyword (. func 1)
         args (. func 2)]
     (print "In defun call...")
     (print (.. "Keyword: " (tostring keyword)))
     (print (.. "Name: " n))
     (print (.. "Args: " (length args)))))

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

