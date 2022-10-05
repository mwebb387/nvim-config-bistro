(import-macros {: defconfig} :recipe-macros)

(defconfig
  ; === Keymaps ===
  ; (map! [:n] "<M-`>" ":NextTerminal<CR>")
  ; (map! [:t] "<M-`>" :<c-\><c-n><c-w><c-q>)
  (map! [:n] "<M-`>" ":FTermToggle<CR>")
  (map! [:t] "<M-`>" :<c-\><c-n>:FTermToggle<CR>)

  ; === Commands ===
  (command! FTermToggle
            (fn [] (let [fterm (require :FTerm)]
                     (fterm.toggle))))

  (command! NextTerminal
            (fn []
              (vim.cmd :20new)
              (let [{: filter} (require :util)
                    term-bufs (-> (vim.api.nvim_list_bufs)
                                  (filter (fn [v]
                                            (string.find
                                              (vim.api.nvim_buf_get_name v)
                                              "term://"))))
                    terms (> (length term-bufs) 0)]
                (if terms
                  (vim.api.nvim_win_set_buf 0 (. term-bufs 1))
                  (vim.fn.termopen :powershell)))))

  (command! Powershell
            (fn []
              (vim.cmd :enew)
              (vim.fn.termopen :powershell)))

  (command! DotnetWatchDev
            (fn []
              (vim.cmd :enew)
              (vim.fn.termopen "powershell Dotnet-Watch-Dev")))

  (command! NpmRun
            (fn []
              (vim.cmd :enew)
              (vim.fn.termopen "powershell Npm-Run")))

  (command! NpmStart
            (fn []
              (vim.cmd :enew)
              (vim.fn.termopen "powershell Npm-Start")))

  (use! [:numToStr/FTerm.nvim])
  
  (setup! (fn [] (let [fterm (require :FTerm)]
                   (fterm.setup {:cmd :powershell})))))

