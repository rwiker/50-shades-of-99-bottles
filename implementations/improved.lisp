(in-package #:99-bottles)

(defpackage #:improved
  (:documentation "Slightly improved version: still using the *do* loop and low-level printing
functions, but at least somehwat structured.")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:improved)

(defun bottles (n &optional beginning-of-line)
  (if (zerop n)
      (if beginning-of-line
	  (princ "No more")
	  (princ "no more"))
      (princ n))
  (princ " bottle")
  (if (/= n 1)
      (princ "s"))
  (princ " of beer"))

(defun line-1 (n)
  (fresh-line)
  (bottles n t)
  (princ " on the wall, ")
  (bottles n)
  (princ ".")
  (terpri))

(defun line-2 (n)
  (princ "Take one down and pass it around, ")
  (bottles (- n 1))
  (princ " on the wall.")
  (terpri))

(defun verse (n)
  (line-1 n)
  (line-2 n)
  (terpri))

(defun last-verse (n)
  (line-1 0)
  (princ "Go to the store and buy some more, ")
  (bottles n)
  (princ " on the wall.")
  (terpri))

(defun bottle-song (bottles)
  (do ((i bottles (1- i)))
      ((zerop i) nil)
    (verse i))
  (last-verse bottles))
	
(register-test-forms :run (lambda () (bottle-song 3)))
       
#||
(bottle-song 3)
||#
