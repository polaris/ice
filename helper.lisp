(in-package #:ice)

(defconstant infinity 18446744073709551616)

(defconstant near-zero 0.00000001)

(defun degrees-to-radians (degrees)
  (/ (* degrees PI) 180))

(defun random-double () (random 1.0))

(defun random-double-min-max (min max)
  (+ min (* (- max min) (random-double))))

(defun clamp (x min max)
  (cond ((< x min) min)
        ((> x max) max)
        (t x)))

(defun vec-near-zero (v)
  (let ((s near-zero))
    (and (< (abs (vx v)) s)
         (< (abs (vy v)) s)
         (< (abs (vz v)) s))))
