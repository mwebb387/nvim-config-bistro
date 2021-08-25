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
   ; :airblade/vim-gitgutter

   ; LSP, Telescope and Treesitter
   ; :nvim-lua/popup.nvim
   ; :nvim-lua/plenary.nvim
   ; :nvim-telescope/telescope.nvim
   :neovim/nvim-lspconfig
   ; :ray-x/lsp_signature.nvim
   :nvim-treesitter/nvim-treesitter ;, {'do': ':TSUpdate'}
   ; :hrsh7th/nvim-compe
   ; :hrsh7th/vim-vsnip
   ; :rafamadriz/friendly-snippets

   ;Aniseed and Conjure
   ; :Olical/aniseed ;, { 'tag': 'v3.20.0' }
   :Olical/conjure ;, { 'tag': 'v4.22.1' }

   ; c#
   ; :omnisharp/omnisharp-vim

   ; javascript
   ; :pangloss/vim-javascript
   ; :mxw/vim-jsx
   ; :posva/vim-vue

   ; svelte
   ; :leafOfTree/vim-svelte-plugin ; TODO: Is this in polyglot?

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
   ; :kyazdani42/nvim-tree.lua
   :preservim/tagbar

   ; Snippets
   ;:SirVer/ultisnips
   ;:honza/vim-snippets

   ; presentation
   ;:junegunn/goyo.vim
   ;:junegunn/limelight.vim
   ])

(fn set-options []
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
  (set! :previewheight 5))

(fn set-keymaps []
  ; General
  (map! [n] :H :^)
  (map! [n] :L :$)
  (map! [i] :jk :<esc>)
  
  ; Window management
  (map! [n i] :<a-h> :<c-w>h)
  (map! [n i] :<a-j> :<c-w>j)
  (map! [n i] :<a-k> :<c-w>k)
  (map! [n i] :<a-l> :<c-w>l)
  (map! [n i] :<a-H> :<c-w>H)
  (map! [n i] :<a-J> :<c-w>J)
  (map! [n i] :<a-K> :<c-w>K)
  (map! [n i] :<a-L> :<c-w>L)
  (map! [n i] :<a-q> :<c-w>q)
  (map! [t] :<a-h> :<c-\><c-n><c-w>h)
  (map! [t] :<a-j> :<c-\><c-n><c-w>j)
  (map! [t] :<a-k> :<c-\><c-n><c-w>k)
  (map! [t] :<a-l> :<c-\><c-n><c-w>l)
  (map! [t] :<a-q> :<c-\><c-n><c-w>q)
  (map! [t] :<a-n> :<c-\><c-n>)
  
  ;General Insert mode
  (map! [i] :<C-j> :<c-o>j)
  (map! [i] :<C-k> :<c-o>k)
  (map! [i] :<C-l> :<c-o>l)
  (map! [i] :<C-h> :<c-o>h))

(fn configure []
  (set-options)
  (set-keymaps))

{: configure : plugins}
