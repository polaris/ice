;;;; camera.lisp

(in-package #:ice)

(defclass camera ()
    ((origin
      :initarg :origin
      :reader get-origin)
     (lower-left-corner
      :initarg :lower-left-corner
      :reader get-lower-left-corner)
     (horizontal
      :initarg :horizontal
      :reader get-horizontal)
     (vertical
      :initarg :vertical
      :reader get-vertical)))

(defun make-camera ()
  (let* ((aspect-ratio (/ 16.0 9.0))
         (viewport-height 2.0)
         (viewport-width (* aspect-ratio viewport-height))
         (focal-length 1.0)
         (origin (vec 0 0 0))
         (horizontal (vec viewport-width 0 0))
         (vertical (vec 0 viewport-height 0))
         (lower-left-corner (v- origin (v/ horizontal 2) (v/ vertical 2) (vec 0 0 focal-length))))
    (make-instance 'camera :origin origin
      :lower-left-corner lower-left-corner
      :horizontal horizontal
      :vertical vertical)))

(defmethod get-ray ((c camera) (u number) (v number))
  (declare (optimize (speed 3) (safety 0)))
  (let ((direction (v-
                       (v+ (get-lower-left-corner c)
                         (v* u (get-horizontal c))
                         (v* v (get-vertical c)))
                     (get-origin c))))
    (make-instance 'ray :origin (get-origin c) :direction direction)))
