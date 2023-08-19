(defn marker [data-buffer sequence-length]
  (loop [sequence (subvec data-buffer 0 sequence-length)
         buffer (subvec data-buffer sequence-length (count data-buffer))
         index sequence-length]
    (if (and
          (>= (count buffer) 1)
          ;; the set has not duplicates. If the size is smaller it had duplicates
          (> (count sequence) (count (set sequence))))
      (recur
        (conj (subvec sequence 1 (count sequence)) (first buffer))
        (subvec buffer 1 (count buffer))
        (inc index))
      index)))

(println (marker (clojure.string/split (read-line) #"") 14))
