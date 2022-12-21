(defn marker [data-buffer sequence-length]
  (loop [sequence (subvec data-buffer 0 sequence-length)
         buffer (subvec data-buffer sequence-length (count data-buffer))
         index sequence-length]
    (println sequence buffer index)
    (if (>= (count buffer) 1)
      (recur (conj sequence (first buffer)) (subvec buffer 1 (count buffer)) (inc index))
      index)))
  
(println "result:" (marker [1 2 3 4 5 6 7 8] 4))

