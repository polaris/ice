;;;; color.lisp

(in-package #:ice)

(defun downscale-pixel-color (pixel-color samples-per-pixel)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type fixnum samples-per-pixel))
  (let ((s (/ 1.0 samples-per-pixel)))
    (vec (* s (vx pixel-color))
         (* s (vy pixel-color))
         (* s (vz pixel-color)))))

(defun gamma-correct (pixel-color)
  (declare (optimize (speed 3) (safety 0)))
  (vec (clamp (sqrt (vx pixel-color)) 0.0 0.999)
       (clamp (sqrt (vy pixel-color)) 0.0 0.999)
       (clamp (sqrt (vz pixel-color)) 0.0 0.999)))

(defun calculate-pixel-color (pixel-color samples-per-pixel)
  (declare (optimize (speed 3) (safety 0)))
  (let* ((corrected-pixel-color (gamma-correct (downscale-pixel-color pixel-color samples-per-pixel)))
         (r (* 255.999 (vx corrected-pixel-color)))
         (g (* 255.999 (vy corrected-pixel-color)))
         (b (* 255.999 (vz corrected-pixel-color))))
    (declare (type single-float r g b))
    (vec (floor r) (floor g) (floor b))))

(defun write-pixel-color (out pixel-color)
  (format out "~d ~d ~d~%" (floor (vx pixel-color)) (floor (vy pixel-color)) (floor (vz pixel-color))))
