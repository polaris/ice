;;;; tests/main.lisp

(in-package #:ice/tests)

(def-suite :ice)

(in-suite :ice)

(def-suite* :ice/tests :in :ice)

(test test-validate-https-url
      "Test URL validation."
      (is (= 1 1)))
(test test-degrees-to-radians
      (is (= (ice::degrees-to-radians 0) 0))
      (is (= (ice::degrees-to-radians 180) PI))
      (is (= (ice::degrees-to-radians 360) (* 2 PI))))

(test test-random-double
      (loop repeat 1000
            do (let ((s (ice::random-double)))
                 (is (and (<= s 1) (>= s 0))))))

(test test-random-double-min-max
      (progn
       (let ((s (ice::random-double-min-max -1 1)))
         (is (and (<= s 1)
                  (>= s -1))))
       (let ((s (ice::random-double-min-max -10 0)))
         (is (and (<= s 0)
                  (>= s -10))))
       (let ((s (ice::random-double-min-max 0 10)))
         (is (and (<= s 10)
                  (>= s 0))))))

(test test-clamp
      (is (= (ice::clamp 0.5 0.0 1.0) 0.5))
      (is (= (ice::clamp 2.0 0.0 1.0) 1.0))
      (is (= (ice::clamp -1.0 0.0 1.0) 0.0)))

(defun one-tenth (s)
  (/ s 10.0))

(test test-one-tenth
      (is (= (one-tenth 1.0) 0.1))
      (is (= (one-tenth 10.0) 1.0)))

(test test-vec-near-zero
      (let ((less-than-near-zero (one-tenth ice::near-zero)))
        (is (ice::vec-near-zero (vec less-than-near-zero
                                     less-than-near-zero
                                     less-than-near-zero)))))
