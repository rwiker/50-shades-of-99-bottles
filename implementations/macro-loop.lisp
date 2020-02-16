(in-package #:99-bottles)

(defpackage #:macro-loop
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:macro-loop)

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

(defmacro bottle-song (bottles)
  `(progn
     ,@(loop for btls from bottles downto 0
             collect (if (plusp btls)
                       `(verse ,btls)
                       `(last-verse ,bottles)))))
       
#||
(macroexpand '(bottle-song 3))
(bottle-song 3)
(let ((n 3))
  (bottle-song n))

||#
