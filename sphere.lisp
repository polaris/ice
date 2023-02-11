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
  (declare (optimize (speed 3) (safety 0)))
  (declare (type single-float discriminant half-b a t-min t-max))
  (let* ((sqrtd (sqrt discriminant))
         (root-1 (/ (- (- half-b) sqrtd) a)))
    (declare (type single-float sqrtd))
    (if (or (< root-1 t-min) (< t-max root-1))
        (let ((root-2 (/ (+ (- half-b) sqrtd) a)))
          (if (or (< root-2 t-min) (< t-max root-2))
              nil
              root-2))
        root-1)))

(defmethod hit ((s sphere) (r ray) (t-min number) (t-max number))
  (declare (optimize (speed 3) (safety 0)))
  (let* ((oc (v- (get-origin r) (get-center s)))
         (a (vsqrlength (get-direction r)))
         (half-b (v. oc (get-direction r)))
         ;(radius (get-radius s))
         ;(c (- (vsqrlength oc) (* radius radius)))
         (c (- (vsqrlength oc) (* (get-radius s) (get-radius s))))
         (discriminant (- (* half-b half-b) (* a c))))
    (declare (type single-float a half-b c discriminant radius))
    (if (< discriminant 0)
        nil
        (let ((root (calc-root discriminant half-b a t-min t-max)))
          (if (null root)
              nil
              (let* ((point (at r root))
                     (outward-normal (v/ (v- point (get-center s)) (get-radius s)))
                     (front-face (< (v. (get-direction r) outward-normal) 0))
                     (normal (if front-face outward-normal (v- outward-normal))))
                (make-hit-record :point point :normal normal :tt root :front-face front-face)))))))
