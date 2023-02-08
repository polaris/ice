;;;; ice.lisp

(in-package #:ice)

(defun ray-color (r world)
  (let ((rec (hit world r 0 infinity)))
    (if (not (null rec))
        (v* 0.5 (v+ (hit-record-normal rec) (vec 1 1 1)))
        (let* ((unit-direction (vunit (get-direction r)))
               (tt (* 0.5 (1+ (vy unit-direction)))))
          (v+ (v* (- 1.0 tt) (vec 1 1 1)) (v* tt (vec 0.5 0.7 1.0)))))))

(defun shoot-ray (cam world i j image-width image-height)
  (let* ((u (/ (+ i (random-double)) (1- image-width)))
         (v (/ (+ j (random-double)) (1- image-height)))
         (r (get-ray cam u v)))
    (ray-color r world)))

(defun render-pixel (output cam world i j image-width image-height samples-per-pixel)
  (let ((pixel-color (vec 0 0 0)))
    (loop repeat samples-per-pixel do
            (nv+ pixel-color (shoot-ray cam world i j image-width image-height)))
    (write-pixel-color output (calculate-pixel-color pixel-color samples-per-pixel))))

(defun render-internal (output image-width world)
  (let* ((aspect-ratio (/ 16.0 9.0))
         (image-height (floor image-width aspect-ratio))
         (samples-per-pixel 100)
         (cam (make-camera)))
    (format output "P3~%~d ~d~%255~%" image-width image-height)
    (loop for j from (1- image-height) downto 0 do
            (loop for i from 0 below image-width do
                    (render-pixel output cam world i j image-width image-height samples-per-pixel)))))

(defun render (filename image-width)
  (with-open-file (output filename
                          :direction :output
                          :if-does-not-exist :create
                          :if-exists :overwrite)
    (let ((world (list (make-instance 'sphere :center (vec 0 0 -1) :radius 0.5)
                       (make-instance 'sphere :center (vec 0 1 -1) :radius 0.5)
                       (make-instance 'sphere :center (vec 0 -100.5 -1) :radius 100))))
      (render-internal output image-width world))))
