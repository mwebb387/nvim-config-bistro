(import-macros {: defrecipe : defmap } :macros)

(fn configure-telescope-mappings []
  (defmap [:n] :<leader>sf "<cmd>Telescope find_files<CR>")
  (defmap [:n] :<c-p> "<cmd>Telescope git_files<CR>")
  (defmap [:n] :<leader>sb "<cmd>Telescope buffers<CR>")
  (defmap [:n] :<leader>bs "<cmd>Telescope buffers<CR>")
  (defmap [:n] :<m-b> "<cmd>Telescope buffers<CR>")
  (defmap [:n] :<leader>sg "<cmd>Telescope live_grep<CR>")
  (defmap [:n] :<leader>sh "<cmd>Telescope help_tags<CR>")
  (defmap [:n] :<leader>so "<cmd>Telescope oldfiles<CR>")
  (defmap [:n] :<leader>sr "<cmd>Telescope registers<CR>")
  (defmap [:n] :<leader>sq "<cmd>Telescope quickfix<CR>")
  (defmap [:n] :<leader>sd "<cmd>Telescope diagnostics bufnr=0<CR>")
  (defmap [:n] :<leader>sD "<cmd>Telescope diagnostics<CR>")
  (defmap [:n] :<leader>ss "<cmd>Telescope lsp_document_symbols<CR>")

  (defmap [:n] :<leader>gb "<cmd>Telescope git_branches<CR>")
  (defmap [:n] :<leader>gc "<cmd>Telescope git_commits<CR>")
  (defmap [:n] :<leader>gf "<cmd>Telescope git_files<CR>")
  (defmap [:n] :<leader>gs "<cmd>Telescope git_status<CR>")
  (defmap [:n] :<leader>gS "<cmd>Telescope git_stash<CR>")

  (defmap [:t] :<a-b> "<c-\\><c-n> <cmd>Telescope buffers<CR>")
  (defmap [:t] :<a-f> "<c-\\><c-n> <cmd>Telescope find_files<CR>")
  (defmap [:t] :<a-/> "<c-\\><c-n> <cmd>Telescope live_grep<CR>"))

(fn configure-telescope []
  (let [actions (require :telescope.actions)
        telescope (require :telescope)]
    (telescope.setup {:defaults {:mappings {:i {:<esc> actions.close
                                             :<c-h> actions.move_to_top
                                             :<c-j> actions.move_selection_next
                                             :<c-k> actions.move_selection_previous
                                             :<c-l> actions.move_to_bottom
                                             :<c-z> actions.delete_buffer}}
                                :prompt_prefix " "
                                :selection_caret " "}})))

(fn configure []
  (configure-telescope)
  (configure-telescope-mappings))

(fn no-op [])

(defrecipe telescope
  (default
    [:nvim-lua/popup.nvim
     :nvim-lua/plenary.nvim
     :nvim-telescope/telescope.nvim]
    configure)
  (option dap [:nvim-telescope/telescope-dap.nvim] no-op))

