(fn plugins [] [:nvim-treesitter/nvim-treesitter])

; ensure_installed = one of "all", "maintained" (parsers with maintainers), or a list of languages

(fn configure []
  (let [ts (require :nvim-treesitter.configs)]
    (ts.setup {:ensure_installed [:javascript
                                 :typescript
                                 :svelte
                                 :css
                                 :scss
                                 :vue
                                 :c_sharp
                                 :tsx
                                 :python]
               :highlight {:enable true}})))

{: configure : plugins }
