;; echo globpath(expand('%:p:h'), '**/*.fnl')

(import-macros {: configure-modules } :macros)

(configure-modules
   (default)
   (themes :tokyonight)
   ; Langs
   (csharp :omnisharp))
