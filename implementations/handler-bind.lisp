(in-package #:99-bottles)

(defpackage #:handler-bind
  (:documentation "(Ab)using the Common Lisp condition-handler mechanism.

- The `handler-bind` mechanism is used to handle various conditions (_note:_ not necessarily exceptions) at run-time.
- A signalled condition is matched against the currently active handlers, and the
applicable handlers are run in the order they were specified.
- More recent (inner) occurrences of `handler-bind` take precedence over earlier ones.
- Evaluation of handlers stops with the first handlers that indicates that it has _handled_
the exception.
- In this particular example, no handler indicates that it has handled the condition, so
all handlers are run.
")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

(in-package #:handler-bind)

(define-condition verse ()
  ((bottles :accessor bottles :initarg :bottles)))

(define-condition sub-verse ()
  ((bottles :accessor bottles :initarg :bottles)
   (capitalize :accessor capitalize :initarg :capitalize :initform nil)))

(defun bottle-song (bottles &optional (stream *standard-output*))
  (let ((capacity bottles))
    (handler-bind ((sub-verse (lambda (condition)
                                (when (plusp (bottles condition))
                                  (princ (bottles condition) stream))))
                   (sub-verse (lambda (condition)
                                (unless (plusp (bottles condition))
                                  (write-string (if (capitalize condition)
                                                  "No more"
                                                  "no more")
                                                stream))))
                   (sub-verse (lambda (condition)
                                (declare (ignore condition))
                                (write-string " bottle" stream)))
                   (sub-verse (lambda (condition)
                                (unless (= (bottles condition) 1)
                                  (write-char #\s stream))))
                   (sub-verse (lambda (condition)
                                (declare (ignore condition))
                                (write-string " of beer" stream))))
      (handler-bind ((verse (lambda (condition)
                              (signal (make-condition 'sub-verse
                                                      :bottles (bottles condition)
                                                      :capitalize t))))
                     (verse (lambda (condition)
                              (declare (ignore condition))
                              (write-string " on the wall, " stream)))
                     (verse (lambda (condition)
                              (signal (make-condition 'sub-verse
                                                      :bottles (bottles condition)))))
                     (verse (lambda (condition)
                              (declare (ignore condition))
                              (write-char #\. stream)
                              (terpri stream)))
                     (verse (lambda (condition)
                              (when (plusp (bottles condition))
                                (write-string
                                 "Take one down and pass it around" stream))))
                     (verse (lambda (condition)
                              (unless (plusp (bottles condition))
                                (write-string "Go to the store and buy some more" stream))))
                     (verse (lambda (condition)
                              (declare (ignore condition))
                              (write-string ", " stream)))
                     (verse (lambda (condition)
                              (signal (make-condition 'sub-verse
                                                      :bottles (if (zerop (bottles condition))
                                                                 capacity
                                                                 (1- bottles))))))
                     (verse (lambda (condition)
                              (declare (ignore condition))
                              (write-string " on the wall." stream)
                              (terpri stream)
                              (terpri stream)))
                     (verse (lambda (condition)
                              (when (zerop (bottles condition))
                                (throw 'done t)))))
        (catch 'done
          (loop for bottles = capacity then (1- bottles)
                do (signal (make-condition 'verse :bottles bottles))))))))

(register-test-forms :run (lambda () (bottle-song 3)))    

#||
(bottle-song 3)
(error "foo.")
(assert nil)
||#
