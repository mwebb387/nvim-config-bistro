# NeoVim Configuration Bistro

This is the repo for my current NeoVim configuration.

## Details

- Written in [Fennel](https://fennel-lang.org/)
- Extensive use of macros for a more lispy configuration
- Divided into _Recipes_ for groups of functionality
- Separate and buildable outside of NeoVim

## Motivation

I really enjoy NeoVim and I really enjoy lisp(s).

I also liked how Doom Emacs was configured with general groups of functionality that allow extra options to be specifed to enhance or change how that functionality works. This is my attempt at something somewhat similar.

I also did not want to rely on another plugin to allow me to write and update my configuration, so it is written in pure Fennel and exists entirely outside of NeoVim itself.

## Dependencies

- NeoVim (0.5+)
- Fennel
- VimPlug

## Tour of the Bistro

### Loading the Bistro recipes, plugins and configurations in Neovim

To fully load the Bistro, with its recipes, plugins and configurations, add this `lua` code to the Neovim initialization:

```lua
require'bistro'
  :loadPlugins()
  :configureRecipes()
```

### Main Bistro Configuration

The main Bistro configuration is written inside `src/configure.fnl`. It consists of Bisto and Recipe initialization macros followed by a list of method calls. These method calls are designed to look as if you are calling each recipe as a method with any desired options passed to it. For example, if there exists recipe files at `src/recipes/recipe-a` and `src/recipes/recipe-b`, the configuration might looks like the following:

```fennel
; Make sure to import the configuration macros
(import-macros {: configure-bistro
                : with-recipes }
               :macros)

(configure-bistro
  (with-recipes
    (recipe-a)
    (recipe-b :recipe-option)))
```

### Recipe Definition

Each recipe is defined in its own file within the `src/recipes/` folder. They also follow standard `lua` loading, so both of the following are valid recipe file paths:
- `src/recipes/lsp.fnl`
- `src/recipes/lsp/init.fnl`

Recipes are defined using the `defrecipe` macro. This macro takes a set of method calls beginning with either `default`, `mode`, or `option`.

`default` configuration plugins and methods are always loaded/called:

```fennel
(defrecipe
  (default plugin-list config-method)) ; Plugins always loaded and config method always called
```

The `mode` method allows defining a set of mutually exclusive plugins and configuration methods based on the parameters passed to the recipe

```fennel
; Main configuration
(configure-bistro
  (with-recipes
    (csharp :lsp)))

; ...

; src/recipes/csharp.fnl

(defrecipe
  (mode :lsp lsp-plugin-list lsp-config-method) ; Loads only if :lsp option is present/first in the recipe args
  (mode :coc coc-plugin-list coc-config-method)) ; Loads only if :coc option is present/first in the recipe args
```

The `option` method allows defining a set of plugins and configuration methods whenever parameters passed to the recipe

```fennel
; Main configuration
(configure-bistro
  (with-recipes
    (csharp :debug :folding)))

; ...

; src/recipes/csharp.fnl

(defrecipe
  (option :debug dap-plugin-list dap-config-method) ; Loads whenever :debugging option is present
  (option :folding fold-plugin-list fold-config-method)) ; Loads whenever :folding option is present
```

## Macro methods

**augroup**

Defines an autocmd group with the given name

Usage:

```fennel
(augroup :group-name
  ; ... autocmd calls
  )
```

**defcommand**

Defines a command with either a string or a method

```fennel
; With a string
(defcommand :PrettierCheck "!npx prettier --check %")

; With a method
(defcommand :PrettierCheck
  (fn []
    (vim.cmd "!npx prettier --check %")))
```

**defhighlight**

Definies a highlight, passing in the desired options as a table

```fennel
(defhighlight :LspDiagnosticsUnderlineInformation {:cterm :underline
                                                   :gui :underline
                                                   :guifg :LightBlue
                                                   :guisp :LightBlue})

```

**defsign**

Definies a highlight, passing in the desired options as a table

```fennel
(defsign :LspDiagnosticsSignInformation {:text :i
                                         :texthl :LspDiagnosticsSignInformation})
```

**defun**

Defines a function in global scope usable in Neovim (NOTE: This macro name will most likely change in the future)

```fennel
; In fennel:
(defun check_back_space []
  (let [col (vim.fn.col ".")]
    (or col (string.find (. (vim.fn.getline ".") (- col 1)) "%s"))))


; In Neovim:
v:lua.check_back_space()
```

(NOTE: Not all macro methods are documented yet, but all macros can be redily viewed in `src/macros.fnl`)

## TODO

- [ ] Logo
- [x] Readme
- [ ] Documentation and comments
- [ ] More/updated macros for function, syntax, etc.
- [ ] More recipes with more options for configuring
- [x] Cleaner recipe definition using a macro
- [ ] Code clean up
- [ ] Speed enhancements and plugin lazy loading
- [ ] Probably other stuff I haven't though of yet...
