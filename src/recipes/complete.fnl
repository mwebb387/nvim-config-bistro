(import-macros {: defconfig} :recipe-macros)

(defconfig
  (as-mode! :vcm)

  (use! [:ackyshake/VimCompletesMe
         :ncm2/float-preview.nvim])

  (map! [:i]
        :<CR>
        "pumvisible() ? \"\\<C-y>\" : \"\\<C-g>u\\<CR>\""
        {:noremap true :expr true}))

(defconfig
  (as-mode! :mu)

  (use! [:lifepillar/vim-mucomplete]))

(defconfig
  (as-mode! :coc)

  ; Commands
  ; Use `:Format` to format current buffer
  (command! :Format ":call CocAction('format')")
  (command! :Prettier ":CocCommand prettier.formatFile")

  ; Mappings
  (map! [:i]
        :<TAB>
        "pumvisible() ? \"\\<C-n>\" : v:lua.check_back_space() ? \"\\<TAB>\" : coc#refresh()"
        {:noremap true :expr true :silent true})
  (map! [:i] :<C-SPACE> "coc#refresh()" {:noremap true :expr true :silent true})
  (map! [:i] :<CR> "pumvisible() ? coc#_select_confirm() : \"\\<C-g>u\\<CR>\"" {:noremap true :expr true})
  (map! [:n] :gd "<Plug>(coc-definition)" {:silent true})
  (map! [:n] :gD "<Plug>(coc-type-definition)" {:silent true})
  (map! [:n] :gi "<Plug>(coc-implementation)" {:silent true})
  (map! [:n] :gr "<Plug>(coc-references)" {:silent true})

  ; Remap for rename current word
  (map! [:n] :<leader>lcrn "<Plug>(coc-rename)")
  (map! [:n] :<F2> "<Plug>(coc-rename)")

  ; Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  (map! [:n :x] :<leader>lca "<Plug>(coc-codeaction-selected)")
  (map! [:n] :<leader>. ":CocAction<cr>" {:noremap true :silent true})

  (map! [:n] :K ":call v:lua.show_documentation()<CR>" {:noremap true :silent true})

  ; Using CocList
  ; Show all diagnostics
  (map! [:n] :<leader>lcd ":<C-u>CocList diagnostics<cr>" {:noremap true :silent true})
  ; Manage extensions
  (map! [:n] :<leader>lce ":<C-u>CocList extensions<cr>" {:noremap true :silent true})
  ; Show commands
  (map! [:n] :<leader>lcc ":<C-u>CocList commands<cr>" {:noremap true :silent true})
  ; Find symbol of current document
  (map! [:n] :<leader>lco ":<C-u>CocList outline<cr>" {:noremap true :silent true})
  ; Search workspace symbols
  (map! [:n] :<leader>lcs ":<C-u>CocList -I symbols<cr>" {:noremap true :silent true})
  ; Do default action for next item.
  (map! [:n] :<leader>j ":<C-u>CocNext<CR>" {:noremap true :silent true})
  ; Do default action for previous item.
  (map! [:n] :<leader>k ":<C-u>CocPrev<CR>" {:noremap true :silent true})
  ; Resume latest coc list
  (map! [:n] :<leader>p ":<C-u>CocListResume<CR>" {:noremap true :silent true})
  
  ; Plugins
  (use! [:neoclide/coc.nvim])
  
  ; Additional Setup
  (setup! (fn []
            ; Method definitions
            (global check_back_space (fn []
              (let [col (vim.fn.col ".")]
                (or col (string.find (. (vim.fn.getline ".") (- col 1)) "%s")))))

            (global show_documentation (fn []
              (if (>= (vim.fn.index [:vim :help] vim.o.filetype) 0)
                (vim.cmd (.. "h " (vim.fn.expand "<cword>")))
                (vim.cmd "call CocAction('doHover')"))))))

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
  )

(defconfig
  (as-mode! :coq)
  
  (use! [[:ms-jpq/coq_nvim {:branch :coq}]
             [:ms-jpq/coq.artifacts {:branch :artifacts}]])
  
  (setup! (fn []
            (let [cmp (require :cmp)
                  sources (cmp.config.sources [{:name :nvim_lsp}
                                               {:name :vsnip}
                                               {:name :path}]
                                              [{:name :buffer}])]
              (cmp.setup {:snippet {:expand (fn [args]
                                              (vim.fn.vsnip#anonymous args.body))}
                          :sources sources})))))

(defconfig
  (as-mode! :cmp)

  (use! [:hrsh7th/cmp-nvim-lsp
         :hrsh7th/cmp-buffer
         :hrsh7th/cmp-path
         :hrsh7th/cmp-cmdline
         ; :hrsh7th/cmp-omni
         :hrsh7th/nvim-cmp

         :hrsh7th/cmp-vsnip
         :hrsh7th/vim-vsnip
         :rafamadriz/friendly-snippets])

  (setup! (fn configure-cmp []
            (let [cmp (require :cmp)
                  mapping (cmp.mapping.preset.insert {:<C-u> (cmp.mapping.scroll_docs -4)
                                                      :<C-d> (cmp.mapping.scroll_docs 4)
                                                      :<A-o> (cmp.mapping.complete)
                                                      :<C-e> (cmp.mapping.abort)
                                                      :<TAB> (cmp.mapping.select_next_item)
                                                      :<S-TAB> (cmp.mapping.select_prev_item)
                                                      :<CR> (cmp.mapping.confirm {:select true})})
                  sources (cmp.config.sources [{:name :nvim_lsp}
                                               {:name :vsnip}
                                               {:name :path}
                                               {:name :neorg}]
                                              [{:name :buffer}])]
              (cmp.setup {:snippet {:expand (fn [args]
                                              (vim.fn.vsnip#anonymous args.body))}
                          : mapping
                          : sources})))))
