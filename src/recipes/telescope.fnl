(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defconfig
  ; === Maps ===
  (map! [:n] :<leader>sf "<cmd>Telescope find_files<CR>")
  (map! [:n] :<c-p> "<cmd>Telescope git_files<CR>")
  (map! [:n] :<leader>sb "<cmd>Telescope buffers<CR>")
  (map! [:n] :<leader>bs "<cmd>Telescope buffers<CR>")
  (map! [:n] :<m-b> "<cmd>Telescope buffers<CR>")
  (map! [:n] :<leader>sg "<cmd>Telescope live_grep<CR>")
  (map! [:n] :<leader>sh "<cmd>Telescope help_tags<CR>")
  (map! [:n] :<leader>so "<cmd>Telescope oldfiles<CR>")
  (map! [:n] :<leader>sr "<cmd>Telescope registers<CR>")
  (map! [:n] :<leader>sq "<cmd>Telescope quickfix<CR>")
  (map! [:n] :<leader>sd "<cmd>Telescope diagnostics bufnr=0<CR>")
  (map! [:n] :<leader>sD "<cmd>Telescope diagnostics<CR>")
  (map! [:n] :<leader>ss "<cmd>Telescope lsp_document_symbols<CR>")

  (map! [:n] :<leader>gb "<cmd>Telescope git_branches<CR>")
  (map! [:n] :<leader>gc "<cmd>Telescope git_commits<CR>")
  (map! [:n] :<leader>gf "<cmd>Telescope git_files<CR>")
  (map! [:n] :<leader>gs "<cmd>Telescope git_status<CR>")
  (map! [:n] :<leader>gS "<cmd>Telescope git_stash<CR>")

  (map! [:t] :<a-b> "<c-\\><c-n> <cmd>Telescope buffers<CR>")
  (map! [:t] :<a-f> "<c-\\><c-n> <cmd>Telescope find_files<CR>")
  (map! [:t] :<a-/> "<c-\\><c-n> <cmd>Telescope live_grep<CR>")


  ; === Plugins ===
  (use! [:nvim-lua/popup.nvim
         :nvim-lua/plenary.nvim
         :nvim-telescope/telescope.nvim])
  
  (setup!
    (fn configure_telescope []
      (let [actions (require :telescope.actions)
            telescope (require :telescope)]
        (telescope.setup {:defaults {:mappings {:i {:<esc> actions.close
                                                    :<c-h> actions.move_to_top
                                                    :<c-j> actions.move_selection_next
                                                    :<c-k> actions.move_selection_previous
                                                    :<c-l> actions.move_to_bottom
                                                    :<c-z> actions.delete_buffer}}
                                     :prompt_prefix " "
                                     :selection_caret " "}})))))

(defconfig
  (as-option! :dap)
  (use! [:nvim-telescope/telescope-dap.nvim]))
