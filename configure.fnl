;; echo globpath(expand('%:p:h'), '**/*.fnl')

(import-macros m :macros)

(m.configure!
   (m.module! :default)
   (m.module! :themes :tokyonight))
