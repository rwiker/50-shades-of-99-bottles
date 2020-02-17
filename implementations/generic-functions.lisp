(defpackage #:generic-functions
  (:documentation "In Common Lisp, methods do not belong to classes, and can in fact
be used without any classes at all. In this case, we use methods with _eql specifiers_
to dispatch based on specific parameter values.")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:generic-functions)

(defgeneric bottles (n))

(defmethod bottles (n)
  (format nil "~d bottles of beer" n))

(defmethod bottles ((n (eql 1)))
  "1 bottle of beer")

(defmethod bottles ((n (eql 0)))
  "no more bottles of beer")

(defun line-1 (n)
  (format t "~&~@(~a~) on the wall, ~:*~a.~%"
	  (bottles n)))

(defun line-2 (n)
  (format t "Take one down and pass it around, ~a on the wall.~%"
	  (bottles (- n 1))))

(defun verse (n)
  (line-1 n)
  (line-2 n)
  (format t "~%"))

(defun last-verse (n)
  (line-1 0)
  (format t "Go to the store and buy some more, ~a on the wall.~%"
	  (bottles n)))

(defun bottle-song (bottles)
  (do ((i bottles (1- i)))
      ((zerop i) nil)
    (verse i))
  (last-verse bottles))

(register-test-forms :run (lambda () (bottle-song 3)))    
       
#||
(bottle-song 3)
||#
