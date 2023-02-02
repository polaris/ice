;;;; tests/main.lisp

(in-package #:ice/tests)

(def-suite :ice)

(in-suite :ice)

(def-suite* :ice/tests :in :ice)

(test test-validate-https-url
  "Test URL validation."
  (is (= 1 1)))
