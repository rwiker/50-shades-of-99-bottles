(in-package #:99-bottles)

(defpackage #:closure
  (:documentation "Lexical closures - functions capturing a variable binding.

This is the inverse of objects and classes, where methods are associated with
an object. With closures, you have bindings associated with methods.")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:closure)

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

(defun make-closure (n)
  (let ((initial-bottles n)
        (bottles n))
    (values (lambda () (plusp bottles))
            (lambda () (prog1
                           (verse bottles)
                         (decf bottles)))
            (lambda () (last-verse initial-bottles)))))

(defun bottle-song (bottles)
  (multiple-value-bind (more? next last)
      (make-closure bottles)
    (loop while (funcall more?)
          do (funcall next)
          finally (funcall last))))

(register-test-forms :run (lambda () (bottle-song 3)))    

#||
(bottle-song 3)
||#
