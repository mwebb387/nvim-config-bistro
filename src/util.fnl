(fn in [list value]
  (let [[first & rest] list]
    (or (= first value)
        (and (> (length rest) 0)
             (in rest value)))))

{: in}
