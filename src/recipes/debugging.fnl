(import-macros {: defrecipe : defmap} :macros)

(fn configure-ui []
  (let [dapui (require :dapui)]
    (dapui.setup)
    (defmap [:n] :<F3> ":lua require'dapui'.toggle()<CR>")))

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

; TODO: Fix this; not working
(fn configure-typescript []
  (let [home (vim.fn.expand "~")
        scriptPath (.. home :\.dap\vscode-node-debug2\out\src\nodeDebug.js)
        config {:type :node2
                :name :Launch
                :request :launch
                :args [:--inspect "${file}"]
                :cwd (vim.fn.getcwd)
                :envFile (.. (vim.fn.getcwd) :\.env)
                :runtimeArgs [:-r :ts-node/register]
                :runtimeExecutable :node
                :skipFiles ["<node_internals>/**" "node_modules/**"]
                :sourceMaps: true}
        dap (require :dap)]
    (tset dap :adapters :node2 {:type :executable
                                :command :node
                                :args [scriptPath]})
    ;(tset dap :configurations :javascript [config])
    (tset dap :configurations :typescript [config])))

(fn set-keymaps []
  (defmap [:n :i] :<F5> ":lua require'dap'.continue()<CR>")
  (defmap [:n :i] :<F9> ":lua require'dap'.toggle_breakpoint()<CR>")
  (defmap [:n :i] :<F10> ":lua require'dap'.step_over()<CR>")
  (defmap [:n :i] :<F11> ":lua require'dap'.step_into()<CR>")
  (defmap [:n :i] :<F12> ":lua require'dap'.step_out()<CR>"))


(defrecipe debugging
  (default [:mfussenegger/nvim-dap] (fn []
                                      (set-keymaps)
                                      (configure-csharp)
                                      (configure-typescript)))
  (option ui [:rcarriga/nvim-dap-ui] configure-ui))
