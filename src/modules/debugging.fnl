(import-macros {: defmap} :macros)

(fn configure-ui []
  (let [dapui (require :dapui)]
    (dapui.setup)))

(fn configure-csharp []
  (let [home (vim.fn.expand "~")
        exe (.. home :\scoop\apps\netcoredbg\current\netcoredbg.exe)
        dllpath (.. (vim.fn.getcwd) :\bin\Debug)
        dap (require :dap)]
    (tset dap :adapters :netcoredbg {:type :executable
                                     :command exe
                                     :args ["--interpreter=vscode"]})
    (tset dap :configurations :cs [{:type :netcoredbg
                                    :name "launch - netcoredbg"
                                    :request :launch
                                    :program (fn []
                                               (vim.fn.input "Path to DLL: " dllpath :file))}])))

(fn set-keymaps []
  (defmap [n i] :<F5> ":lua require'dap'.continue()<CR>")
  (defmap [n i] :<F9> ":lua require'dap'.toggle_breakpoint()<CR>")
  (defmap [n i] :<F10> ":lua require'dap'.step_over()<CR>")
  (defmap [n i] :<F11> ":lua require'dap'.step_into()<CR>")
  (defmap [n i] :<F12> ":lua require'dap'.step_out()<CR>"))

(fn plugins [...]
  (let [args [...]
        plugs [:mfussenegger/nvim-dap]]
    (match args
      [:ui] (table.insert plugs :rcarriga/nvim-dap-ui))
    plugs))

(fn configure [...]
  (set-keymaps)
  (configure-csharp) ; TODO: Make optional and move to csharp...
  (match [...]
    [:ui] (configure-ui)))

{: configure : plugins}
