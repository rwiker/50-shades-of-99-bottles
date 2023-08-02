(in-package #:99-bottles)

(defpackage #:print-object
  (:documentation "Uses a primary print-object method to print a single verse,
and an :after method to print the next verse (if there is one).")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:print-object)

(defparameter *bottles/fmt*
    "~[no more~:;~:*~d~] bottle~:p of beer")

(defun line-1 (n stream)
  (format stream "~&~@(~?~) on the wall, ~2:*~?.~%"
          *bottles/fmt* (list n)))

(defun line-2 (n stream)
  (format stream "Take one down and pass it around, ~? on the wall.~%~%"
	  *bottles/fmt* (list (- n 1))))

(defun verse (n stream)
  (line-1 n stream)
  (line-2 n stream))

(defun last-verse (n stream)
  (line-1 0 stream)
  (format stream "Go to the store and buy some more, ~? on the wall.~%~%"
	  *bottles/fmt* (list n)))

(defclass wall ()
  ((initial-bottles :reader initial-bottles :initarg :initial-bottles :initform 99)
   (bottles :accessor bottles :initarg :bottles)))

(defmethod print-object ((object wall) stream)
  (if (zerop (bottles object))
      (last-verse (initial-bottles object) stream)
      (verse (bottles object) stream)))

(defmethod print-object :after ((object wall) stream)
  (if (plusp (bottles object))
    (princ (make-instance 'wall :initial-bottles (initial-bottles object)
                          :bottles (1- (bottles object)))
           stream)))

(defun bottle-song (bottles)
  (princ (make-instance 'wall :initial-bottles bottles :bottles bottles)
         *standard-output*)
  (values))

(register-test-forms :run (lambda () (bottle-song 3)))    

#||

(bottle-song 3)
||#
