;;;; ice.lisp

(in-package #:ice)

(defun ray-color (r world)
  (let ((rec (hit world r 0 infinity)))
    (if (not (null rec))
        (v* 0.5 (v+ (hit-record-normal rec) (vec 1 1 1)))
        (let* ((unit-direction (vunit (get-direction r)))
               (tt (* 0.5 (1+ (vy unit-direction)))))
          (v+ (v* (- 1.0 tt) (vec 1 1 1)) (v* tt (vec 0.5 0.7 1.0)))))))

(defun shoot-ray (i j image-width image-height lower-left-corner horizontal vertical origin world)
  (let* ((u (/ i (1- image-width)))
         (v (/ j (1- image-height)))
         (direction (v- (v+ lower-left-corner (v* u horizontal) (v* v vertical)) origin))
         (r (make-instance 'ray :origin origin :direction direction)))
    (ray-color r world)))

(defun render-internal (output image-width world)
  (let* ((aspect-ratio (/ 16.0 9.0))
         (image-height (floor image-width aspect-ratio))
         (viewport-height 2.0)
         (viewport-width (* aspect-ratio viewport-height))
         (focal-length 1.0)
         (origin (vec 0 0 0))
         (horizontal (vec viewport-width 0 0))
         (vertical (vec 0 viewport-height 0))
         (lower-left-corner (v- origin (v/ horizontal 2) (v/ vertical 2) (vec 0 0 focal-length))))
    (format output "P3~%~d ~d~%255~%" image-width image-height)
    (loop for j from (1- image-height) downto 0 do
      (loop for i from 0 below image-width do
        (write-pixel-color output (shoot-ray i j image-width image-height lower-left-corner horizontal vertical origin world))))))

(defun render (filename image-width)
  (with-open-file (output filename
                          :direction :output
                          :if-does-not-exist :create
                          :if-exists :overwrite)
    (let ((world (list (make-instance 'sphere :center (vec 0 0 -1) :radius 0.5)
                       (make-instance 'sphere :center (vec 0 1 -1) :radius 0.5)
                       (make-instance 'sphere :center (vec 0 -100.5 -1) :radius 100))))
      (render-internal output image-width world))))
