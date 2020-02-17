(in-package #:99-bottles)

(defpackage #:cardinal-format
  (:documentation "Another useful function of _format_ is to convert numbers
into their textual equivalent.")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:cardinal-format)

(defun bottles (n)
  (format nil "~[no more~:;~:*~r~] bottle~:p of beer"
	  n))

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
