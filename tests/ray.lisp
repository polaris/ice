;;;; ray.lisp

(in-package #:ice/tests)

(in-suite :ice/tests)

(test test-ray-at
  (let ((r (make-instance 'ice::ray :origin (3d-vectors:vec 1 1 1) :direction (3d-vectors:vec 0 0 1))))
    (is (ice::at r 10) (3d-vectors 1 1 11))))
