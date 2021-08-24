;; echo globpath(expand('%:p:h'), '**/*.fnl')

(import-macros {: configure-modules } :macros)

(configure-modules
   (default)
   (files)
   (themes :tokyonight)
   (telescope)
   ; Langs
   (csharp :omnisharp))
