;;;; ice.lisp

(in-package #:ice)

(defun ray-color (r world depth)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type fixnum depth))
  (if (= depth 0)
      (vec 0 0 0)
      (let ((rec (hit world r 0 infinity)))
        (if (not (null rec))
          (let* ((target (v+ (hit-record-point rec) (hit-record-normal rec) (random-in-unit-sphere)))
                 (dir (v- target (hit-record-point rec)))
                 (new-r (make-instance 'ray :origin (hit-record-point rec) :direction dir)))
            (v* 0.5 (ray-color new-r world (1- depth))))
          (let* ((unit-direction (vunit (get-direction r)))
                 (tt (* 0.5 (1+ (vy unit-direction)))))
            (v+ (v* (- 1.0 tt) (vec 1 1 1)) (v* tt (vec 0.5 0.7 1.0))))))))

(defun shoot-ray (cam world i j image-width image-height max-depth)
  (let* ((u (/ (+ i (random-double)) (1- image-width)))
         (v (/ (+ j (random-double)) (1- image-height)))
         (r (get-ray cam u v)))
    (ray-color r world max-depth)))

(defun render-pixel (output cam world i j image-width image-height samples-per-pixel max-depth)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type fixnum samples-per-pixel))
  (let ((pixel-color (vec 0 0 0)))
    (loop repeat samples-per-pixel do
            (nv+ pixel-color (shoot-ray cam world i j image-width image-height max-depth)))
    (write-pixel-color output (calculate-pixel-color pixel-color samples-per-pixel))))

(defun render-internal (output image-width world)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type fixnum image-width))
  (declare (type stream output))
  (let* ((aspect-ratio (/ 16.0 9.0))
         (image-height (floor image-width aspect-ratio))
         (samples-per-pixel 100)
         (max-depth 50)
         (cam (make-camera)))
    (format output "P3~%~d ~d~%255~%" image-width image-height)
    (loop for j from (1- image-height) downto 0 do
            (loop for i from 0 below image-width do
                    (render-pixel output cam world i j image-width image-height samples-per-pixel max-depth)))))

(defun render (filename image-width)
  (setf *random-state* (make-random-state t))
  (with-open-file (output filename
                          :direction :output
                          :if-does-not-exist :create
                          :if-exists :overwrite)
    (let ((world (list (make-instance 'sphere :center (vec 0 0 -1) :radius 0.5)
                       (make-instance 'sphere :center (vec 0 1 -1) :radius 0.5)
                       (make-instance 'sphere :center (vec 0 -100.5 -1) :radius 100))))
      (render-internal output image-width world))))
