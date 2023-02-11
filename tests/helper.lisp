(in-package #:ice/tests)

(in-suite :ice/tests)

(test test-random-in-unit-sphere
  (loop repeat 1000
        do (is (< (vsqrlength (ice::random-in-unit-sphere)) 1))))
