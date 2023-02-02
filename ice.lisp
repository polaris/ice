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
		     do (let ((r (/ i (- image-width 1)))
			      (g (/ j (- image-height 1)))
			      (b 0.25))
			  (let ((ir (round (* 255.999 r)))
				(ig (round (* 255.999 g)))
				(ib (round (* 255.999 b))))
			    (write-pixel-color output (3d-vectors:vec ir ig ib)))))))))
