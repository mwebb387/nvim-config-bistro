(import-macros {: defconfig} :recipe-macros)

(defconfig
  (use! [:goolord/alpha-nvim])
  
  (setup!
    (fn [] (let [alpha (require :alpha)
                 theme (require :alpha.themes.dashboard)]
             (set theme.section.header.val ["⠀⠀⠀⠀⢀⣠⣤⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣤⣄⣀⠀⠀⠀⠀"
                                            "⠀⠀⠀⢰⣿⡿⠟⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠿⣿⣧⠀⠀⠀"
                                            "⠀⠀⠀⣿⣿⡃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⡶⣶⡶⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡄⠀⠀"
                                            "⠀⠀⠀⣿⣿⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠋⠃⠀⠀⡀⣠⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀"
                                            "⠀⠀⠀⣿⣿⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⠛⠛⠛⠛⠛⢿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀"
                                            "⠀⠀⢠⣿⡿⠀⠀⠀⠀⠀⠀⢠⣶⣶⣤⣤⣤⣤⣤⣤⣤⠀⣠⣤⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣇⠀⠀"
                                            "⣲⣶⡿⠟⠁⠀⠀⠀⠀⠀⠀⠈⠿⠟⠏⠋⠋⠋⠋⠋⠋⠀⠙⠙⠙⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣷⣶"
                                            "⠚⠛⢿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⡶⣶⡶⣶⣶⢶⣶⣶⣶⣶⣿⣿⣦⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠛"
                                            "⠀⠀⠈⣿⣿⡀⠀⠀⠀⠀⠀⠀⣀⣤⡀⠁⠉⠉⠉⠉⠈⠉⠁⠉⠈⠁⠛⠋⠃⠀⠀⠀⠀⠀⠀⣼⣿⡇⠀⠀"
                                            "⠀⠀⠀⣿⣿⡂⠀⠀⠀⠀⠀⠨⣿⣿⡿⠛⠟⠻⠛⠟⠻⠛⠟⠟⠂⠐⠟⠟⠂⠀⠀⠀⠀⠀⠀⣿⣟⡇⠀⠀"
                                            "⠀⠀⠀⣿⣿⡂⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⢀⣀⣀⣀⣠⣴⣦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠇⠀⠀"
                                            "⠀⠀⠀⢿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠛⠛⠛⣯⡿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⠁⠀⠀"
                                            "⠀⠀⠀⠘⢿⣿⣷⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣾⣿⣟⠏⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠀⠀⠀"])
             (set theme.section.buttons.val [(theme.button "e" "  New file" ":ene <BAR> startinsert <CR>")
                                             (theme.button "CTRL p" "  Find file" "<c-p>")
                                             (theme.button "q" "  Quit NVIM" ":qa<CR>")])
             (alpha.setup theme.config)))))
