(import-macros {: append! : set! : map!} :macros)

(fn plugins []
  [:w0rp/ale
   :sheerun/vim-polyglot

   ; Functionality
   ; :junegunn/fzf
   ; :junegunn/fzf.vim
   :vim-scripts/utl.vim
   :jiangmiao/auto-pairs
   :tpope/vim-surround
   :tpope/vim-speeddating
   :tpope/vim-commentary
   :tpope/vim-unimpaired
   :kassio/neoterm
   :mattn/emmet-vim
   :junegunn/vim-slash

   ; git
   :tpope/vim-fugitive
   :tommcdo/vim-fubitive
   :junegunn/gv.vim
   :airblade/vim-gitgutter

   ; LSP, Telescope and Treesitter
   :nvim-lua/popup.nvim
   :nvim-lua/plenary.nvim
   :nvim-telescope/telescope.nvim
   :neovim/nvim-lspconfig
   ; :ray-x/lsp_signature.nvim
   :nvim-treesitter/nvim-treesitter ;, {'do': ':TSUpdate'}
   ; :hrsh7th/nvim-compe
   ; :hrsh7th/vim-vsnip
   ; :rafamadriz/friendly-snippets

   ;Aniseed and Conjure
   :Olical/aniseed ;, { 'tag': 'v3.20.0' }
   :Olical/conjure ;, { 'tag': 'v4.22.1' }

   ; c#
   ; :omnisharp/omnisharp-vim

   ; javascript
   ; :pangloss/vim-javascript
   ; :mxw/vim-jsx
   ; :posva/vim-vue

   ; svelte
   :leafOfTree/vim-svelte-plugin

   ; auto-complete
   :neoclide/coc.nvim ;', {'branch': 'release'}

   ; look and feel
   ; :glepnir/galaxyline.nvim ;, {'branch': 'main'}
   ;:ryanoasis/vim-devicons
   :kyazdani42/nvim-web-devicons
   :junegunn/rainbow_parentheses.vim

   ; programs / extension
   ; :tpope/vim-vinegar
   ; :scrooloose/nerdtree
   :kyazdani42/nvim-tree.lua
   :preservim/tagbar

   ; Snippets
   ;:SirVer/ultisnips
   ;:honza/vim-snippets

   ; presentation
   ;:junegunn/goyo.vim
   ;:junegunn/limelight.vim
   ])

(fn configure []
  (set! :backup false)
  (set! :undofile false)
  (set! :swapfile false)
  (set! :hidden true)
  (set! :number true)
  (set! :showcmd false)
  (set! :showmode false)

  ; Tab related settings
  (set! :expandtab true)
  (set! :tabstop 2)
  (set! :shiftwidth 2)
  (set! :autoindent true)

  ; Omnifunc
  (set! :omnifunc "syntaxcomplete#complete")

  ; Path additions
  (append! :path "C:/Users/mwebb/AppData/Local/nvim/lua")

  ; Splits
  (set! :splitbelow true)
  (set! :splitright true)

  ; Searching
  (set! :ignorecase true)
  (set! :wildignore "obj/**,bin/**,node_modules/**")
  (set! :grepprg "rg --vimgrep --no-heading --smart-case")
  (set! :grepformat "%f:%l:%c:%m,%f:%l:%m")

  ; Better display for messages
  (set! :cmdheight 2)

  ; You will have bad experience for diagnostic messages when it's default 4000.
  (set! :updatetime 300)

  ; always show signcolumns
  (set! :signcolumn "yes")

  (set! :completeopt "longest,menuone,preview")
  (set! :previewheight 5)

  ; Keymaps
  (map! [n] :H :^)
  (map! [n] :L :$)
  (map! [i] :jk :<esc>))

{: configure : plugins}
