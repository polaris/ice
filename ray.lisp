;;;; ray.lisp

(in-package #:ice)

(defclass ray ()
    ((origin
      :initarg :origin
      :reader get-origin)
     (direction
      :initarg :direction
      :reader get-direction)))

(defmethod at ((r ray) (tt number))
  (v+ (get-origin r) (v* (get-direction r) tt)))
