;;;; ray.lisp

(in-package #:ice)

(defclass ray ()
  ((origin
    :initarg :origin
    :reader get-origin)
   (direction
    :initarg :direction
    :reader get-direction)))

(defmethod at (r tt)
  (3d-vectors:v+ (get-origin r) (3d-vectors:v* (get-direction r) tt)))
