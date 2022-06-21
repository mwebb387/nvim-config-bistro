(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(import-macros {: defun} :macros)

(defrecipe :test-bistro)

;; TODO: Finish...

(defconfig
  (command! Bistro
            (fn [cmd]
              (let [bistro (require :bistro)
                    {: args} cmd]
                (match args
                  :build (bistro:build)
                  :refresh (bistro:refresh)
                  :plugins (bistro:loadPlugins)
                  :configure (bistro:configureRecipes))))
            ; TODO: Update to cmd lua function...
            {:complete "customlist,v:lua.ListOperations"
             :nargs 1})

  (setup!
    (fn []
      (defun ListOperations [A L P]
        [:build
         :refresh
         :plugins
         :configure]))))
