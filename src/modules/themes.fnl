(import-macros {: set!} :macros)

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
  (print (tostring theme))
  (vim.cmd (.. "colorscheme " theme)))

(fn set-random-theme [] 
  (let [rand-theme-idx (math.random (- (length all-themes) 1))]
    (colorscheme (. all-themes rand-theme-idx))))

; Module definition
;(fn random-theme [] 
;  setRandomTheme()
;end

(fn plugins []
  [:tomasiser/vim-code-dark
   :theniceboy/nvim-deus
   :whatyouhide/vim-gotham
   :ntk148v/vim-horizon
   :ludokng/vim-odyssey
   :xdg/vim-darkluma
   :maksimr/Lucius2
   :nightsense/cosmic_latte
   :Nequo/vim-allomancer
   :folke/tokyonight.nvim
   :marko-cerovac/material.nvim
   :arcticicestudio/nord-vim
   :nanotech/jellybeans.vim
   :NLKNguyen/papercolor-theme
   :AlessandroYorba/Arcadia
   :crater2150/vim-theme-chroma
   :bcicen/vim-vice
   :dracula/vim
   :EdenEast/nightfox.nvim
   :vim-scripts/proton
   :junegunn/seoul256.vim
   :wojciechkepka/bogster])

(fn configure [theme]
  (set! :termguicolors true)
  (if (not theme)
    (set-random-theme)
    (colorscheme theme)))

{: plugins : configure}
