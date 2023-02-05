;;;; sphere.lisp

(in-package #:ice)

(defclass sphere ()
  ((center
    :initarg :center
    :reader get-center)
   (radius
    :initarg :radius
    :reader get-radius)))

(defun calc-root (discriminant half-b a t-min t-max)
  (let* ((sqrtd (sqrt discriminant))
	 (root-1 (/ (- (- half-b) sqrtd) a)))
    (if (or (< root-1 t-min) (< t-max root-1))
	(let ((root-2 (/ (+ (- half-b) sqrtd) a)))
	  (if (or (< root-2 t-min) (< t-max root-2))
	      nil
	      root-2))
	root-1)))

(defmethod hit ((s sphere) (r ray) (t-min number) (t-max number))
  (let* ((oc (3d-vectors:v- (get-origin r) (get-center s)))
	 (a (3d-vectors:vsqrlength (get-direction r)))
	 (half-b (3d-vectors:v. oc (get-direction r)))
	 (c (- (3d-vectors:vsqrlength oc) (* (get-radius s) (get-radius s))))
	 (discriminant (- (* half-b half-b) (* a c))))
    (if (< discriminant 0)
	nil
	(let ((root (calc-root discriminant half-b a t-min t-max)))
	  (if (eq root nil)
	      nil
	      (let* ((p (at r root))
		     (outward-normal (3d-vectors:v/ (3d-vectors:v- p (get-center s)) (get-radius s)))
		     (front-face (< (3d-vectors:v. (get-direction r) outward-normal) 0))
		     (normal (if front-face outward-normal (3d-vectors:v- outward-normal))))
		(make-hit-record :point p :normal normal :tt root :front-face front-face)))))))
	  
	      
