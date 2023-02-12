;;;; helper.lisp

(in-package #:ice)

(defconstant infinity most-positive-single-float)

(defconstant near-zero 0.00000001)

(defun degrees-to-radians (degrees)
  (/ (* degrees PI) 180))

(declaim (ftype (function () single-float) random-double))
(defun random-double () (random 1.0))

(defun random-double-min-max (min max)
  (+ min (* (- max min) (random-double))))

(defun random-vec ()
  (vec (random-double) (random-double) (random-double)))

(defun random-vec-min-max (min max)
  (vec (random-double-min-max min max) (random-double-min-max min max) (random-double-min-max min max)))

(defun random-in-unit-sphere ()
  (let ((p (random-vec-min-max -1 1)))
    (loop while (> (vsqrlength p) 1)
	  do (setf p (random-vec-min-max -1 1)))
    p))

(defun clamp (x min max)
  (cond ((< x min) min)
        ((> x max) max)
        (t x)))

(defun vec-near-zero (v)
  (let ((s near-zero))
    (and (< (abs (vx v)) s)
         (< (abs (vy v)) s)
         (< (abs (vz v)) s))))
