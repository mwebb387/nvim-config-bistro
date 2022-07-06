# Neovim Configuration Bistro

This is the repo for my current Neovim configuration.

## Details

- Written in [Fennel](https://fennel-lang.org/)
- Extensive use of macros for a more lispy configuration
- Divided into _Recipes_ for groups of functionality
- Separate and buildable outside of Neovim

## Motivation

I really enjoy Neovim and I really enjoy lisp(s).

I also liked how Doom Emacs was configured with general groups of functionality that allow extra options to be specified to enhance or change how that functionality works. This is my attempt at something somewhat similar.

I also did not want to rely on another plugin to allow me to write and update my configuration, so it is written in pure Fennel and exists entirely outside of Neovim itself.

## Dependencies

- Neovim (0.5+)
- Fennel
- VimPlug

## Installation

Make sure to have `fennel` in your system path and run the following command in the terminal...

```
fennel <bistro repo>/build.fnl <bistro repo>/src/ <nvim lua folder>
```

...where `<bistro repo>` is the path to the local copy of this repo and `<nvim lua folder>` is the path to the lua folder in Neovim.

This will accomplish two things:
1. Compile the configuration and fennel source in the `/src` folder. NOTE: This will not write and compile files in the `/src/recipes` folder
2. Write the `/src` folder location into the compiled source so that the Bistro can re-build itself within Neovim

## Tour of the Bistro

### Loading the Bistro recipes, plugins and configurations in Neovim

To fully load the Bistro, with its recipes, plugins and configurations, add this `lua` code to the Neovim initialization:

```lua
require'bistro':setup()
```

### Main Bistro Configuration

The main Bistro configuration is written inside `src/configure.fnl`. It consists of a Bistro initialization macro followed by a list of method calls. These method calls are designed to look as if you are calling each recipe as a method with any desired options passed to it. For example, if there exists recipe files at `src/recipes/recipe-a` and `src/recipes/recipe-b`, the configuration might looks like the following:

```fennel
; Make sure to import the configuration macro
(import-macros {: load-recipes} :recipe-macros)

; Make sure to import any macros used in your recipe files
; This requirement will be removed in future versions
(import-macros {: augroup
                : autocmd
                : defhighlight
                : defsign
                : defun} :macros)

(load-recipes
  (recipe-a)
  (recipe-b :recipe-option))
```

### Recipe Definition

Each recipe is defined in its own file within the `src/recipes/` folder. They also follow standard `lua` loading, so both of the following are valid recipe file paths:
- `src/recipes/lsp.fnl`
- `src/recipes/lsp/init.fnl`

Recipe configurations are defined using the `defconfig` macro. This macro takes a set of method calls that specify options, keymaps, commands, etc. that are part of a user's main configuration.

The full set of methods commands are the following:

#### as-mode!

The `as-mode!` method sets the current configuration as a mutually exclusive configuration based on the parameters passed to the recipe

```fennel
; Main configuration
(load-recipes
  (csharp :lsp))

; ...

; src/recipes/csharp.fnl

(defconfig
  (as-mode! :lsp lsp-config-method) ; Loads only if :lsp option is present and first in the recipe args
  (use! lsp-plugin-list)
  (setup! (fn [] (setup-instructions-here))))

(defconfig
  (as-mode! :coc coc-config-method) ; Loads only if :coc option is present and first in the recipe args
  (use! coc-plugin-list)
  (setup! (fn [] (coc-setup-here))))
```

#### as-option!

The `as-option!` method allows defining a set of plugins and configuration methods whenever parameters passed to the recipe

```fennel
; Main configuration
(load-recipes
  (csharp :debug :folding))

; ...

; src/recipes/csharp.fnl

(defconfig
  (as-option! :debug)
  (use! dap-plugin-list)
  (setup! (fn [] (dap-config-method)))) ; Loads whenever :debugging option is present


(defconfig
  (as-option! :folding)
  (use! fold-plugin-list)
  (setup! (fn [] (fold-config-method)))) ; Loads whenever :folding option is present
```

#### command!

The `command!` method allows defining a user command


```fennel
(defconfig
  (command! UserExplore ":edit .")

  (command! UserCommandName
    (fn [] (user-command-fn))
    {
    ; Options...
    }))
```

#### log
The `log` method is for debugging purposes and will output the contents of the configuration at build time

```fennel
(defconfig
  (log))
```

#### map!
The `map!` method is for creating keymaps

```fennel
(defconfig
  (map! [:n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true}))
```

#### set!
The `set!` method is for setting regular options

```fennel
(defconfig
  (set! hidden true))
```

#### set-g!
The `set-g!` method is for setting global options

```fennel
(defconfig
  (set-g! material_style "deep ocean"))
```

#### setup!
The `setup!` method is for defining a method that will be executed as part of the bistro configuration routine

```fennel
(defconfig
  (setup!
    (fn configure_telescope []
      (let [telescope (require :telescope)]
        (telescope.setup {})))))
```

#### use!
The `use!` method is for defining a set of plugins to install as part of the configuration

```fennel
(defconfig
  (use! [:nvim-lua/popup.nvim
         :nvim-lua/plenary.nvim
         :nvim-telescope/telescope.nvim]))
```

A single plugin can also be defined as a list in the form `[plug-name plug-options]` where `plug-options` are the same options passed to *vim-plug*

```fennel
(defconfig
  (use! [:tpope/vim-fugitive
         [:junegunn/gv.vim {:on :GV}]
         [:kdheepak/lazygit.nvim {:on :LazyGit}]]))
```


## Macro methods

These methods are general methods that can be used in the function defined with `(setup! (fn [] ...))` in a configuration.

For now, any macros used in a `(setup! (fn []...))` MUST be imported in `configure.fnl`so they can be resolved at compile time.

**augroup**

Defines an autocmd group with the given name

```fennel
(augroup :group-name
  ; ... autocmd calls
  )
```

**autocmd**

Defines an autocmd for Neovim. Currently requires 3 strings be passed to the command for `event`, `pattern` and `command` respectively

```fennel
(autocmd :CursorHold :<buffer> "lua vim.lsp.buf.document_highlight()")
```

**configure-bistro** (_DEPRECATED_)

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

```fennel
; Single mode input
(defmap [i] :jk :<esc>)

; Multiple modes
(defmap [n i] :<a-q> :<c-w>q)

; With explicit options
(defmap [n] :<leader>gp ":Git pull<CR>" {:noremap true :silent true}))
```

**defrecipe** (_DEPRECATED_)

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

**with-recipes** (_DEPRECATED_)

Receives methods passed in where each method name is the name of a recipe in `src/recipes/` and the arguments are parameters passed to each recipe within its setup. NOTE: Should be used within the `configure-bistro` macro

```fennel
(with-recipes
  (themes :nightfox) ; Loads 'src/recipes/themes.fnl' and passes in :nightfox as parameter to the recipe

  ; Langs
  (fennel)) ; Loads 'src/recipes/fennel.fnl' with no parameters
```

(NOTE: Not all macro methods are documented yet, but all macros can be readily viewed in `src/macros.fnl`)

## TODO

- [ ] Logo
- [x] Readme
- [x] Documentation and comments
- [ ] More/updated macros for function, syntax, etc.
- [ ] More recipes with more options for configuring
- [x] Cleaner recipe definition using a macro
- [ ] Code clean up
- [ ] Speed enhancements and plugin lazy loading
- [ ] Probably other stuff I haven't though of yet...
