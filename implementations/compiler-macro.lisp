(in-package #:99-bottles)

(defpackage #:compiler-macro
  (:documentation "Illustrates the use of _compiler macros_ to selectively
replace forms with alternative implementations. In this case, if the argument
to bottle-song is an integer between 1 and 5 inclusive, the call to bottle-song
will be inlined.")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:compiler-macro)

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

(defun recurse (bottles)
  (when (plusp bottles)
    (verse bottles)
    (recurse (1- bottles))))

(defun bottle-song (bottles)
  (recurse bottles)
  (last-verse bottles))

(define-compiler-macro bottle-song (&whole form bottles)
  (if (and (typep bottles 'integer)
           (<= 1 bottles 5))
      `(progn
         ,@(loop for btls from bottles downto 0
                 collect (if (plusp btls)
                           `(verse ,btls)
                           `(last-verse ,bottles))))
      form))

(register-test-forms :expand (lambda ()
                               (loop for b in (list 3 6)
                                     collect `((bottle-song ,b) => 
                                               ,(funcall (compiler-macro-function 'bottle-song)
                                                         `(bottle-song ,b)
                                                         nil))))
                     :run (lambda () (bottle-song 3)))
       
#||
(funcall (compiler-macro-function 'bottle-song) '(bottle-song 3) nil)
(bottle-song 3)

(funcall (compiler-macro-function 'bottle-song) '(bottle-song 6) nil)
(bottle-song 6)

||#
