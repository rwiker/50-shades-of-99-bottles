(in-package #:99-bottles)

(defpackage #:goto
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:goto)

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
  (let ((i bottles))
    (tagbody
     loop
     (verse i)
     (decf i)
     (when (plusp i)
       (go loop))))
  (last-verse bottles))

#||
(bottle-song 3)
||#
