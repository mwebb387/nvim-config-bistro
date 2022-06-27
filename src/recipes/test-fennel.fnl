(import-macros {: defrecipe
                : defconfig} :recipe-macros)

(defrecipe :test-fennel)

(defconfig
  (use! [[:bakpakin/fennel.vim {:for :fennel}]]))
