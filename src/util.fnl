(fn concat [list1 list2]
  (each [_ v (ipairs list2)]
    (table.insert list1 v)))

(fn includes [list value]
  (let [[first & rest] list]
    (or (= first value)
        (and (> (length rest) 0)
             (includes rest value)))))

{: concat
 : includes}
