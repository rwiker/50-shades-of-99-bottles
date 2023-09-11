(in-package #:99-bottles)

(defpackage #:handler-bind
  (:documentation "(Ab)using the Common Lisp condition mechanism.")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:handler-bind)

(define-condition verse ()
  ((bottles :accessor bottles :initarg :bottles)))

(define-condition sub-verse ()
  ((bottles :accessor bottles :initarg :bottles)
   (capitalize :accessor capitalize :initarg :capitalize :initform nil)))

(defun bottle-song (bottles)
  (let ((capacity bottles))
    (handler-bind ((sub-verse (lambda (condition)
                                (let ((bottles (bottles condition))
                                      (capitalize (capitalize condition)))
                                  (format t "~{~a~}"
                                          (list
                                           (if (plusp bottles)
                                             bottles
                                             (if capitalize
                                               "No more"
                                               "no more"))
                                           " bottle"
                                           (if (= bottles 1)
                                             ""
                                             "s")
                                           " of beer"))))))
      (handler-bind ((verse (lambda (condition)
                              (let ((bottles (bottles condition)))
                                (signal (make-condition 'sub-verse :bottles bottles :capitalize t))
                                (format t " on the wall, ")
                                (signal (make-condition 'sub-verse :bottles bottles))
                                (format t ".~%")
                                (if (plusp bottles)
                                  (format t "Take one down and pass it around")
                                  (format t "Go to the store and buy some more"))
                                (format t ", ")
                                (signal (make-condition 'sub-verse :bottles (if (zerop bottles) capacity (1- bottles))))
                                (format t " on the wall.~%~%")
                                (when (zerop bottles)
                                  (throw 'done t))))))
        (catch 'done
          (loop for bottles = capacity then (1- bottles)
                do (signal (make-condition 'verse :bottles bottles))))))))

(register-test-forms :run (lambda () (bottle-song 3)))    

#||
(bottle-song 3)
(error "foo.")
(assert nil)
||#
