; (fn append [list1 list2]
;   (each [_ v (ipairs list2)]
;     (table.insert list1 v)))

(fn concat [list1 list2]
  (each [_ v (ipairs list2)]
    (table.insert list1 v)))

(fn includes [list value]
  (let [[first & rest] list]
    (or (= first value)
        (and (> (length rest) 0)
             (includes rest value)))))

(fn filter [list filter-fn]
  (icollect [_ v (ipairs list)]
            (if (filter-fn v)
              v)))

(fn map [list map-fn]
  (icollect [_ v (ipairs list)]
            (map-fn v)))

(fn first [list filter-fn]
  (let [matches (filter list filter-fn)]
    (if (> (length matches) 0)
      (. matches 1))))

(fn any [list filter-fn]
  (> (filter list filter-fn) 0))

{: any
 : concat
 : filter
 : first
 : includes
 : map}
