;;;; color.lisp

(in-package #:ice)

(defun downscale-pixel-color (pixel-color samples-per-pixel)
  (let ((s (/ 1.0 samples-per-pixel)))
    (vec (* s (vx pixel-color))
         (* s (vy pixel-color))
         (* s (vz pixel-color)))))

(defun gamma-correct (pixel-color)
  (vec (clamp (sqrt (vx pixel-color)) 0.0 0.999)
       (clamp (sqrt (vy pixel-color)) 0.0 0.999)
       (clamp (sqrt (vz pixel-color)) 0.0 0.999)))

(defun calculate-pixel-color (pixel-color samples-per-pixel)
  (let* ((corrected-pixel-color (gamma-correct (downscale-pixel-color pixel-color samples-per-pixel)))
         (r (floor (* 255.999 (vx corrected-pixel-color))))
         (g (floor (* 255.999 (vy corrected-pixel-color))))
         (b (floor (* 255.999 (vz corrected-pixel-color)))))
    (vec r g b)))

(defun write-pixel-color (out pixel-color)
  (let ((ir (floor (* 255.999 (vx pixel-color))))
        (ig (floor (* 255.999 (vy pixel-color))))
        (ib (floor (* 255.999 (vz pixel-color)))))
    (format out "~d ~d ~d~%" ir ig ib)))
