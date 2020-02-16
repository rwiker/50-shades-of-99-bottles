(in-package #:99-bottles)

(defpackage #:special-recursive
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:special-recursive)

(defparameter *bottles* 0)

(defun bottles ()
  (format nil "~[no more~:;~:*~d~] bottle~:p of beer"
	  *bottles*))

(defun line-1 ()
  (format t "~&~@(~a~) on the wall, ~:*~a.~%"
	  (bottles)))

(defun line-2 ()
  (format t "Take one down and pass it around, ~a on the wall.~%~%"
          (let ((*bottles* (1- *bottles*)))
            (bottles))))
  
(defun verse ()
  (line-1)
  (line-2))

(defun last-verse ()
  (let ((*bottles* 0))
    (line-1))
  (format t "Go to the store and buy some more, ~a on the wall.~%~%"
	  (bottles)))

(defun recurse ()
  (when (plusp *bottles*)
    (verse)
    (let ((*bottles* (1- *bottles*)))
      (recurse))))

(defun bottle-song (bottles)
  (let ((*bottles* bottles))
    (recurse)
    (last-verse)))
       
#||
(bottle-song 3)
||#
