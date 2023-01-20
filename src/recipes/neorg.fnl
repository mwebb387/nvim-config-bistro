(import-macros {: defconfig} :recipe-macros)

(defconfig
  (use! [:nvim-neorg/neorg])
  
  (setup! (fn [] (let [neorg (require :neorg)]
                   (neorg.setup {:load {:core.defaults {}
                                        :core.norg.dirman {:config {:workspaces {:work "~/.norg/work"}}}
                                        :core.norg.completion {:config {:engine :nvim-cmp}}
                                        :core.norg.concealer {}
                                        :core.norg.qol.toc {}}})))))
