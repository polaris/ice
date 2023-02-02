;;;; ice.lisp

(in-package #:ice)

(defun render (filename image-width image-height)
  (with-open-file (output filename
			  :direction :output
			  :if-does-not-exist :create
			  :if-exists :overwrite)
    (progn
      (format output "P3~%~d ~d~%255~%" image-width image-height)
      (loop for j from (- image-height 1) downto 0
	    do (loop for i from 0 below image-width
		     do (let ((pixel-color (3d-vectors:vec (/ i (- image-width 1))
							   (/ j (- image-height 1))
							   0.25)))
			  (write-pixel-color output pixel-color)))))))
