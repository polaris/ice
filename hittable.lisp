;;;; hittable.lisp

(in-package #:ice)

(defstruct (hit-record) point normal tt front-face)

(defgeneric hit (obj r t-min t-max))

(defmethod hit ((world cons) (r ray) (t-min number) (t-max number))
  (let ((closest-so-far t-max)
        (rec nil))
    (dolist (object world)
      (let ((temp-rec (hit object r t-min closest-so-far)))
        (if (not (eq temp-rec nil))
            (progn
              (setf closest-so-far (hit-record-tt temp-rec))
              (setf rec temp-rec)))))
    rec))
