(in-package #:99-bottles)

(defpackage #:extended-loop
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:extended-loop)

(defun bottles (n)
  (format nil "~[no more~:;~:*~d~] bottle~:p of beer"
	  n))

(defun line-1 (n)
  (format t "~&~@(~a~) on the wall, ~:*~a.~%"
	  (bottles n)))

(defun line-2 (n)
  (format t "Take one down and pass it around, ~a on the wall.~%~%"
	  (bottles (- n 1))))

(defun verse (n)
  (line-1 n)
  (line-2 n))

(defun last-verse (n)
  (line-1 0)
  (format t "Go to the store and buy some more, ~a on the wall.~%~%"
	  (bottles n)))

(defun bottle-song (bottles)
  (loop for i from bottles above 0
     do (verse i)
     finally (last-verse bottles)))

#||
(bottle-song 3)
||#
