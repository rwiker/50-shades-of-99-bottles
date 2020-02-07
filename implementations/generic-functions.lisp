(defpackage #:generic-functions
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
  (format t "~@(~a~) on the wall, ~:*~a.~%"
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
  (fresh-line)
  (do ((i bottles (1- i)))
      ((zerop i) nil)
    (verse i))
  (last-verse bottles)
  (terpri))
       
#||
(bottle-song 3)
||#
