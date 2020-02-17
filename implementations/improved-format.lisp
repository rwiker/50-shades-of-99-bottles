(in-package #:99-bottles)

(defpackage #:improved-format
  (:documentation "This implementation demonstrates some of the power of _format_:

- The conditional construct _~[...~;...~;...~:;~]_

- The \"goto\" construct _~*_, here used in the form _~:*_, which means go back to
the previous parameter.

- The _case-change_ directive, which in the form _~@(...~)_ capitalizes the first word
of the enclosed string.

- Note also _~p_, which conditionally inserts a plural indicator \"s\", depending
on the value of the next parameter to _format_.


")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:improved-format)

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
  (do ((i bottles (1- i)))
      ((zerop i) nil)
    (verse i))
  (last-verse bottles))

(register-test-forms :run (lambda () (bottle-song 3)))    

#||
(bottle-song 3)
||#
