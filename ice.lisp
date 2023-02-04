;;;; ice.lisp

(in-package #:ice)

(defun ray-color (r)
  (let ((unit-direction (3d-vectors:vunit (get-direction r))))
    (let ((tt (* 0.5 (+ (3d-vectors:vy unit-direction) 1))))
      (3d-vectors:v+ (3d-vectors:v* (- 1.0 tt) (3d-vectors:vec 1 1 1)) (3d-vectors:v* tt (3d-vectors:vec 0.5 0.7 1.0))))))

(defun render (filename image-width)
  (let* ((aspect-ratio (/ 16.0 9.0))
	 (image-height (floor (/ image-width aspect-ratio)))
	 (viewport-height 2.0)
	 (viewport-width (* aspect-ratio viewport-height))
	 (focal-length 1.0)
	 (origin (3d-vectors:vec 0 0 0))
	 (horizontal (3d-vectors:vec viewport-width 0 0))
	 (vertical (3d-vectors:vec 0 viewport-height 0))
	 (lower-left-corner
	   (3d-vectors:v- (3d-vectors:v- (3d-vectors:v- origin (3d-vectors:v/ horizontal 2)) (3d-vectors:v/ vertical 2)) (3d-vectors:vec 0 0 focal-length))))
    (with-open-file (output filename
			    :direction :output
			    :if-does-not-exist :create
			    :if-exists :overwrite)
      (progn
	(format output "P3~%~d ~d~%255~%" image-width image-height)
	(loop for j from (- image-height 1) downto 0
	      do (loop for i from 0 below image-width
		       do (let* ((u (/ i (- image-width 1)))
				 (v (/ j (- image-height 1)))
				 (direction
				   (3d-vectors:v- (3d-vectors:v+ (3d-vectors:v+ lower-left-corner (3d-vectors:v* u horizontal)) (3d-vectors:v* v vertical)) origin))
				 (r (make-instance 'ray :origin origin :direction direction))
				 (pixel-color (ray-color r)))
			    (write-pixel-color output pixel-color))))))))
