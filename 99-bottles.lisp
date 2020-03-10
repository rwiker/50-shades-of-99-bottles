;;;; 99-bottles.lisp

(in-package #:99-bottles)

(defvar *implementation-registry*
  (make-hash-table :test #'equalp))

(defclass test-form ()
  ((expand :accessor expand :initarg :expand :initform nil)
   (run :accessor run :initarg :run :initform nil)))
  
(defun register-test-forms (&key expand run)
  (let ((key (package-name *package*)))
    (setf (gethash key *implementation-registry*)
          (make-instance 'test-form :expand expand :run run))))

(defun get-expand-form (implementation)
  (let ((desc (gethash implementation *implementation-registry*)))
    (and desc (expand desc))))

(defun get-run-form (implementation)
  (let ((desc (gethash implementation *implementation-registry*)))
    (and desc (run desc))))

(defun main ()
  (restas:start :99-bottles-server :port 8080)
  (loop (sleep 1)))

