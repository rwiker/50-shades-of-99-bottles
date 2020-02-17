(in-package #:99-bottles)

(defpackage #:simple-format
  (:documentation "This version eschews the low-level printing format in favour of
*format*, which is the Swiss Army Chainsaw of printing functions.

The awesomeness of *format* is not brought out in this implementation, but note the
constructs _~&_ to effect _fresh-line_, _~%_ for _terpri_ and _~A_ for _princ_.")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:simple-format)

(defun bottles (n &optional beginning-of-line)
  (format t "~a bottle~a of beer"
	  (if (zerop n)
	      (if beginning-of-line
		  "No more"
		  "no more")
	      n)
	  (if (= n 1) "" "s")))

(defun line-1 (n)
  (format t "~&")
  (bottles n t)
  (format t " on the wall, ")
  (bottles n)
  (format t  ".~%"))

(defun line-2 (n)
  (format t "Take one down and pass it around, ")
  (bottles (- n 1))
  (format t " on the wall.~%"))

(defun verse (n)
  (line-1 n)
  (line-2 n)
  (format t "~%"))

(defun last-verse (n)
  (line-1 0)
  (format t "Go to the store and buy some more, ")
  (bottles n)
  (format t " on the wall.~%"))

(defun bottle-song (bottles)
  (do ((i bottles (1- i)))
      ((zerop i) nil)
    (verse i))
  (last-verse bottles))

(register-test-forms :run (lambda () (bottle-song 3)))

#||
(bottle-song 3)
||#
