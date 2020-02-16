(defpackage #:basic
  (:documentation "Simple implementation, using a *do* loop, and the low-level
printing functions *fresh-line*, *princ* and *terpri*.")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:basic)

(defun bottle-song (bottles)
  (fresh-line)
  (do ((i bottles (1- i)))
      ((zerop i) nil)
    (princ i)
    (princ " bottle")
    (if (> i 1)
	(princ "s"))
    (princ " of beer on the wall, ")
    (princ i)
    (princ " bottle")
    (if (> i 1)
	(princ "s"))
    (princ " of beer.")
    (terpri)
    (princ "Take one down and pass it around, ")
    (if (zerop (- i 1))
	(princ "no more bottles of beer.")
	(let ((i (- i 1)))
	  (princ i)
	  (princ " bottle")
	  (if (> i 1)
	      (princ "s"))
	  (princ " of beer on the wall.")))
    (terpri)
    (terpri))
  (princ "No more bottles of beer on the wall, no more bottles of beer.")
  (terpri)
  (princ "Go to the store and buy some more, ")
  (princ bottles)
  (princ " bottle")
  (if (> bottles 1)
      (princ "s"))
  (princ " of beer on the wall.")
  (terpri))
	
    
       
#||
(bottle-song 3)
||#
