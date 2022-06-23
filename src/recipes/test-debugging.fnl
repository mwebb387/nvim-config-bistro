(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defrecipe :test-debugging)

(defconfig
  (map! [:n :i] :<F5> ":lua require'dap'.continue()<CR>")
  (map! [:n :i] :<F9> ":lua require'dap'.toggle_breakpoint()<CR>")
  (map! [:n :i] :<F10> ":lua require'dap'.step_over()<CR>")
  (map! [:n :i] :<F11> ":lua require'dap'.step_into()<CR>")
  (map! [:n :i] :<F12> ":lua require'dap'.step_out()<CR>"))

(defconfig
  (as-option! :ui)

  (map! [:n] :<F3> ":lua require'dapui'.toggle()<CR>")

  (use! [:rcarriga/nvim-dap-ui])

  (setup! (fn []
            ((. (require :dapui) setup)))))

(defconfig
  (as-option! :csharp)

  (setup! (fn []
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
                                                         (vim.fn.input "Path to DLL: " dllpath :file))}])))))

(defconfig
  (as-option! :typescript)

  ; TODO: Fix this; not working
  (setup! (fn []
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
              (tset dap :configurations :typescript [config])))))
