(in-package #:99-bottles)

(defpackage #:recursive-format
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:recursive-format)

(defparameter *bottles/fmt*
    "~[no more~:;~:*~d~] bottle~:p of beer")

(defun line-1 (n)
  (format t "~&~@(~?~) on the wall, ~2:*~?.~%"
	  *bottles/fmt* (list n)))

(defun line-2 (n)
  (format t "Take one down and pass it around, ~? on the wall.~%~%"
	  *bottles/fmt* (list (- n 1))))

(defun verse (n)
  (line-1 n)
  (line-2 n))

(defun last-verse (n)
  (line-1 0)
  (format t "Go to the store and buy some more, ~? on the wall.~%~%"
	  *bottles/fmt* (list n)))

(defun bottle-song (bottles)
  (do ((i bottles (1- i)))
      ((zerop i) nil)
    (verse i))
  (last-verse bottles))
	
    
       
#||

(bottle-song 3)
||#
