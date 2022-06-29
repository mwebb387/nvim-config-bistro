(import-macros {: defrecipe : defcommand : defmap : defun : let-g } :macros)

(fn configure-coc []
  ; Method definitions
  (defun check_back_space []
    (let [col (vim.fn.col ".")]
      (or col (string.find (. (vim.fn.getline ".") (- col 1)) "%s"))))

  (defun show_documentation []
    (if (>= (vim.fn.index [:vim :help] vim.o.filetype) 0)
      (vim.cmd (.. "h " (vim.fn.expand "<cword>")))
      (vim.cmd "call CocAction('doHover')")))

  ; Commands
  ; Use `:Format` to format current buffer
  (defcommand :Format ":call CocAction('format')")
  (defcommand :Prettier ":CocCommand prettier.formatFile")

  ; Mappings
  (defmap [:i] :<TAB>
              "pumvisible() ? \"\\<C-n>\" : v:lua.check_back_space() ? \"\\<TAB>\" : coc#refresh()"
              {:noremap true :expr true :silent true})
  (defmap [:i] :<C-SPACE> "coc#refresh()" {:noremap true :expr true :silent true})
  (defmap [:i] :<CR> "pumvisible() ? coc#_select_confirm() : \"\\<C-g>u\\<CR>\"" {:noremap true :expr true})
  (defmap [:n] :gd "<Plug>(coc-definition)" {:silent true})
  (defmap [:n] :gD "<Plug>(coc-type-definition)" {:silent true})
  (defmap [:n] :gi "<Plug>(coc-implementation)" {:silent true})
  (defmap [:n] :gr "<Plug>(coc-references)" {:silent true})

  ; Remap for rename current word
  (defmap [:n] :<leader>lcrn "<Plug>(coc-rename)")
  (defmap [:n] :<F2> "<Plug>(coc-rename)")

  ; Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  (defmap [:n :x] :<leader>lca "<Plug>(coc-codeaction-selected)")
  (defmap [:n] :<leader>. ":CocAction<cr>" {:noremap true :silent true})

  (defmap [:n] :K ":call v:lua.show_documentation()<CR>" {:noremap true :silent true})

  ; Using CocList
  ; Show all diagnostics
  (defmap [:n] :<leader>lcd ":<C-u>CocList diagnostics<cr>" {:noremap true :silent true})
  ; Manage extensions
  (defmap [:n] :<leader>lce ":<C-u>CocList extensions<cr>" {:noremap true :silent true})
  ; Show commands
  (defmap [:n] :<leader>lcc ":<C-u>CocList commands<cr>" {:noremap true :silent true})
  ; Find symbol of current document
  (defmap [:n] :<leader>lco ":<C-u>CocList outline<cr>" {:noremap true :silent true})
  ; Search workspace symbols
  (defmap [:n] :<leader>lcs ":<C-u>CocList -I symbols<cr>" {:noremap true :silent true})
  ; Do default action for next item.
  (defmap [:n] :<leader>j ":<C-u>CocNext<CR>" {:noremap true :silent true})
  ; Do default action for previous item.
  (defmap [:n] :<leader>k ":<C-u>CocPrev<CR>" {:noremap true :silent true})
  ; Resume latest coc list
  (defmap [:n] :<leader>p ":<C-u>CocListResume<CR>" {:noremap true :silent true}))

  ; TODO: Remaining mappings and autocmds

  ; Highlight symbol under cursor on CursorHold
  ; --- autocmd CursorHold * silent call CocActionAsync('highlight')

  ; Remap for format selected region
  ; --- xmap <leader>lcf  <Plug>(coc-format-selected)
  ; --- nmap <leader>lcf  <Plug>(coc-format-selected)
  ;
  ; --- augroup mygroup
  ; ---   autocmd!
  ; ---   " Setup formatexpr specified filetype(s).
  ; ---   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  ; ---   " Update signature help on jump placeholder
  ; ---   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  ; --- augroup end

  ; Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  ; nmap <silent> <TAB> <Plug>(coc-range-select)
  ; xmap <silent> <TAB> <Plug>(coc-range-select)
  ; xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
  ;
  ; Add status line support, for integration with other plugin, checkout `:h coc-status`
  ;set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
  ;

(fn configure-vcm []
  ; inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  (defmap [:i] :<CR> "pumvisible() ? \"\\<C-y>\" : \"\\<C-g>u\\<CR>\"" {:noremap true :expr true})); TODO: Better mapping for expressions...

(fn configure-coq [])
  ;(let-g :coq_settings {:auto_start :shut-up}))

(fn configure-cmp []
  (let [cmp (require :cmp)
        sources (cmp.config.sources [{:name :nvim_lsp}
                                     {:name :vsnip}
                                     {:name :path}]
                                    [{:name :buffer}])]
    (cmp.setup {:snippet {:expand (fn [args]
                                    (vim.fn.vsnip#anonymous args.body))}
                :sources sources})))

(defrecipe complete
  (mode vcm
        [:ackyshake/VimCompletesMe
         :ncm2/float-preview.nvim]
        configure-vcm)

  (mode coc [:neoclide/coc.nvim] configure-coc)

  (mode coq [[:ms-jpq/coq_nvim {:branch :coq}]
             [:ms-jpq/coq.artifacts {:branch :artifacts}]]
            (configure-coq))

  (mode cmp [:hrsh7th/cmp-nvim-lsp
             :hrsh7th/cmp-buffer
             :hrsh7th/cmp-path
             :hrsh7th/cmp-cmdline
             :hrsh7th/cmp-omni
             :hrsh7th/nvim-cmp

             :hrsh7th/cmp-vsnip
             :hrsh7th/vim-vsnip]
        (configure-cmp)))

