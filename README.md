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

Recipes are defined using the `defrecipe` macro. This macro takes a name and a set of method calls beginning with either `default`, `mode`, or `option`.

`default` configuration plugins and methods are always loaded/called:

```fennel
(defrecipe recipe-name
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

(defrecipe csharp
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

(defrecipe csharp
  (option :debug dap-plugin-list dap-config-method) ; Loads whenever :debugging option is present
  (option :folding fold-plugin-list fold-config-method)) ; Loads whenever :folding option is present
```

## Macro methods

**augroup**

Defines an autocmd group with the given name

```fennel
(augroup :group-name
  ; ... autocmd calls
  )
```

**autocmd**

Defines an autocmd for Neovom. Currently requires 3 strings be passed to the command for `event`, `pattern` and `command` respectively

```fennel
(autocmd :CursorHold :<buffer> "lua vim.lsp.buf.document_highlight()")
```

**configure-bistro**

Macro used in the main configuration to setup recipe loading for the Bistro. Accepts a list of methods and will pass the Bistro object/table into each one in order

```fennel
(configure-bistro
  (with-recipes
    (themes :nightfox))
  (bistro-post-process)
  (log-bistro))
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

Defines a highlight, passing in the desired options as a table

```fennel
(defhighlight :LspDiagnosticsUnderlineInformation {:cterm :underline
                                                   :gui :underline
                                                   :guifg :LightBlue
                                                   :guisp :LightBlue})

```

**defmap**

Defines a key mapping (with `noremap` by default) in Neovim.

**defrecipe**

```fennel
; Single mode input
(defmap [i] :jk :<esc>)

; Multiple modes
(defmap [n i] :<a-q> :<c-w>q)

; With explicit options
(defmap [n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true}))
```

Defines a recipe for the Bistro

```fennel
(defrecipe csharp
  ; Defaults loaded always
  (default [] configure-cs)

  ; Modes, mutually-exclusive
  (mode omnisharp [:omnisharp-plugin] configure-omnisharp)
  (mode omnisharp-ls [:lspconfig-plugin] configure-lsp)
  
  ; Options, based on presence of parameters
  (option :debug [:dap-plugin] configure-debugging))
```

**defsign**

Defines a highlight, passing in the desired options as a table

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

**with-recipes**

Recieves methods passed in where each method name is the name of a recipe in `src/recipes/` and the arguments are parameters passed to each recipe within its setup. NOTE: Should be used within the `configure-bistro` macro

```fennel
(with-recipes
  (themes :nightfox) ; Loads 'src/recipes/themes.fnl' and passes in :nightfox as parameter to the recipe

  ; Langs
  (fennel)) ; Loads 'src/recipes/fennel.fnl' with no parameters
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
