(import-macros {: defrecipe : set!} :macros)

; Seed random generator
(math.randomseed (os.time))

(local all-themes (vim.api.nvim_eval "uniq(sort(map(globpath(&runtimepath, \"colors/*.vim\", 0, 1), 'fnamemodify(v:val, \":t:r\")')))"))
;(local all-themes
;  (-> (vim.fn.globpath vim.opt.runtimepath "colors/*.vim" 0 1)
;      (vim.fn.map "fnamemodify(v:val, \":t:r\")")
;      (vim.fn.sort)
;      (vim.fn.uniq)))

; Local methods
(fn colorscheme [theme]
  ;(print (tostring theme))
  (vim.cmd (.. "colorscheme " theme)))

(fn set-random-theme [] 
  (let [rand-theme-idx (math.random (- (length all-themes) 1))]
    (colorscheme (. all-themes rand-theme-idx))))

; Recipe definition
;(fn random-theme [] 
;  setRandomTheme()
;end

(local theme-plugins
  [:tomasiser/vim-code-dark
   :theniceboy/nvim-deus
   :whatyouhide/vim-gotham
   :ntk148v/vim-horizon
   :nightsense/cosmic_latte
   :Nequo/vim-allomancer
   :folke/tokyonight.nvim
   :marko-cerovac/material.nvim
   :nanotech/jellybeans.vim
   :crater2150/vim-theme-chroma
   :EdenEast/nightfox.nvim
   :wojciechkepka/bogster
   :bluz71/vim-nightfly-guicolors
   :akai54/2077.nvim])

(fn configure [theme]
  ; Set style for material theme
  (set vim.g.material_style "deep ocean")
  (set vim.g.material_italic_comments true)
  (set vim.g.material_borders true)
  (set! :termguicolors true)
  (if (not theme)
    (set-random-theme)
    (colorscheme theme)))


(defrecipe themes
  (default theme-plugins configure))
