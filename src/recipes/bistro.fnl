(import-macros {: defconfig} :recipe-macros)

;; TODO: Finish...

(defconfig
  (map! [:n] :<leader>Bb ":Bistro build<CR>")
  (map! [:n] :<leader>BB ":Bistro reconfigure<CR>")
  (map! [:n] :<leader>Br ":Bistro refresh<CR>")
  (map! [:n] :<leader>Bp ":Bistro plugins<CR>")
  (map! [:n] :<leader>Bc ":Bistro configure<CR>")

  (command! Bistro
            (fn [cmd]
              (let [bistro (require :bistro)
                    {: args} cmd]
                (match args
                  :build (bistro:build)
                  :edit (bistro:editConfig)
                  :refresh (bistro:refresh)
                  :plugins (bistro:loadPlugins bistro.config.plugins)
                  :configure (bistro:setupRecipes)
                  :reconfigure (do
                                 (bistro:refresh)
                                 (bistro:setup)))))

            {:complete (fn [A L P] [:build
                                    :edit
                                    :refresh
                                    :plugins
                                    :configure
                                    :reconfigure])
             :nargs 1}))
