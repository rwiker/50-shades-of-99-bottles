;;;; package.lisp

(defpackage #:99-bottles
  (:use #:cl)
  (:export #:register-test-forms
   #:get-expand-form #:get-run-form))
