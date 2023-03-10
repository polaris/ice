;;;; ray.lisp

(in-package #:ice/tests)

(in-suite :ice/tests)

(test test-ray-at-1
      (let ((r (make-instance 'ice::ray :origin (vec 0 0 0) :direction (vec 1 2 3))))
        (is (ice::at r 2) (vec 2 4 6))))

(test test-ray-at-2
      (let ((r (make-instance 'ice::ray :origin (vec 1 1 1) :direction (vec 0 0 1))))
        (is (ice::at r 10) (vec 1 1 11))))

(test test-ray-at-3
      (let ((r (make-instance 'ice::ray :origin (vec 0 0 0) :direction (vec 0 0 0))))
        (is (ice::at r 10) (vec 0 0 0))))
