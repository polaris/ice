(in-package #:ice)

(defun downscale-pixel-color (pixel-color samples-per-pixel)
  (let ((s (/ 1.0 samples-per-pixel)))
    (3d-vectors:vec (* s (3d-vectors:vx pixel-color))
		    (* s (3d-vectors:vy pixel-color))
		    (* s (3d-vectors:vz pixel-color)))))

(defun gamma-correct (pixel-color)
  (3d-vectors:vec (clamp (sqrt (3d-vectors:vx pixel-color)) 0.0 0.999)
		  (clamp (sqrt (3d-vectors:vx pixel-color)) 0.0 0.999)
		  (clamp (sqrt (3d-vectors:vx pixel-color)) 0.0 0.999)))

(defun calculate-pixel-color (pixel-color samples-per-pixel)
  (let ((corrected-pixel-color (gamma-correct (downscale-pixel-color pixel-color samples-per-pixel))))
    (let ((r (floor (* 255.999 (3d-vectors:vx corrected-pixel-color))))
          (g (floor (* 255.999 (3d-vectors:vy corrected-pixel-color))))
          (b (floor (* 255.999 (3d-vectors:vz corrected-pixel-color)))))
      (3d-vectors:vec r g b))))

(defun write-pixel-color (out pixel-color)
  (format out "~d ~d ~d~%"
	  (round (3d-vectors:vx pixel-color))
	  (round (3d-vectors:vy pixel-color))
	  (round (3d-vectors:vz pixel-color))))
