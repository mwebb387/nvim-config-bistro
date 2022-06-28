(import-macros {: defrecipe
                : defconfig} :recipe-macros)

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
            {:complete (fn [A L P] [:build
                                    :refresh
                                    :plugins
                                    :configure])
             :nargs 1}))
