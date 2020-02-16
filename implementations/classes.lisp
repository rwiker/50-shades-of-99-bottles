(in-package #:99-bottles)

(defpackage #:classes
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:classes)

(defclass wall ()
  ((capacity :accessor capacity :allocation :class)))

(defclass wall/n (wall)
  ((bottles :accessor bottles :initarg :bottles)))

(defclass wall/1 (wall)
  ())

(defclass wall/0 (wall)
  ())

(defmethod bottles ((object wall/1))
  1)

(defmethod bottles ((object wall/0))
  0)

(defmethod bottle-string ((object wall))
  (format nil "~d bottles of beer" (bottles object)))

(defmethod bottle-string ((object wall/1))
  "1 bottle of beer")

(defmethod bottle-string ((object wall/0))
  "no more bottles of beer")

(defun make-wall (bottles)
  (cond ((minusp bottles)
         nil)
        ((zerop bottles)
         (make-instance 'wall/0))
        ((= bottles 1)
         (make-instance 'wall/1))
        (t
         (make-instance 'wall/n :bottles bottles))))

(defun next (object)
  (make-wall (1- (bottles object))))

(defmethod line-1 (object)
  (format t "~&~@(~a~) on the wall, ~:*~a.~%"
	  (bottle-string object)))

(defmethod line-2 (object)
  (format t "Take one down and pass it around, ~a on the wall.~%~%"
          (bottle-string (next object))))

(defmethod line-2 ((object wall/0))
  (format t "Go to the store and buy some more, ~a on the wall.~%~%"
	  (bottle-string (make-wall (capacity object)))))
  
(defmethod verse (object)
  (line-1 object)
  (line-2 object))

(defun bottle-song (bottles)
  (let ((wall (make-wall bottles)))
    (setf (capacity wall) bottles)
    (loop for w = wall then (next w)
          while w
          do (verse w))))

#||
(bottle-song 3)
||#
