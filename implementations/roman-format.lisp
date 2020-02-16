(in-package #:99-bottles)

(defpackage #:roman-format
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:roman-format)

(defun bottles (n &optional beginning-of-line)
  (format nil (if (and beginning-of-line (zerop n))
		  "~@(~a~)"
		  "~a")
	  (format nil "~[no more~:;~:*~@R~] bottle~:p of beer"
		  n)))

(defun line-1 (n)
  (format t "~a on the wall, ~a.~%"
	  (bottles n t) (bottles n)))

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
	
    
       
#||
(bottle-song 3)
||#
