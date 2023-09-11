(in-package #:99-bottles)

(restas:define-module #:99-bottles-server
  (:use #:cl #:99-bottles))

(in-package #:99-bottles-server)

(defparameter *implementations*
  (list "basic"
        "improved"
        "simple-format"
        "generic-functions"
        "classes"
        "improved-format"
        "recursive-format"
        "print-object"
        "closure"
        "goto"
        "recursive"
        "special-recursive"
        "extended-loop"
        "handler-bind"
        "macro-loop"
        "macro-recursive"
        "compiler-macro"
        "cardinal-format"
        "roman-format"
        "bottle-format"
        "bottle-format-improved"))

(defun implementation-pathname (implementation)
  (merge-pathnames (make-pathname :directory (list :relative "implementations") :name implementation :type "lisp")
                   (asdf/system:system-source-directory :99-bottles)))
  
(defun compile-and-load-all-implementations ()
  (loop for implementation in *implementations*
        for filename = (implementation-pathname implementation)
        do (load (compile-file filename))))

(restas:mount-module -static- (#:restas.directory-publisher)
  (:url "/static")
  (restas.directory-publisher:*directory*
   (merge-pathnames "static/"
                    (asdf/system:system-source-directory :99-bottles)))
  (restas.directory-publisher:*directory-index-files* '("index.html")))

(restas:mount-module -static- (#:restas.directory-publisher)
  (:url "/static")
  (restas.directory-publisher:*directory*
   (merge-pathnames "static/"
                    (asdf/system:system-source-directory :99-bottles)))
  (restas.directory-publisher:*directory-index-files* '("index.html")))

(restas:define-route root ("" :method :get)
  (merge-pathnames "./static/index.html" (asdf/system:system-source-directory :99-bottles)))

(restas:define-route implementations ("implementations" :method :get
                                      :content-type "application/json")
  (cl-json:encode-json-to-string *implementations*))

#+nil
(restas:define-route implementation/code ("implementations(':(implementation)')/code"
                                          :method :get :content-type "text/plain")
  (implementation-pathname implementation))


(restas:define-route implementation/code ("implementations(':(implementation)')/code"
                                          :method :get :content-type "text/plain")
  (with-open-file (f (implementation-pathname implementation) :direction :input :element-type 'character)
    (loop for line = (read-line f nil)
          while (and line (not (cl-ppcre:scan "^\\(in-package" line))))
    (loop for line = (read-line f nil)
          while (and line (not (cl-ppcre:scan "^\\(in-package" line))))
    (with-output-to-string (s)
      (loop for line = (read-line f nil)
            for not-done = (and line (not (cl-ppcre:scan "^\\(register-test-forms" line)))
            while not-done
            do (write-line line s)))))

(restas:define-route implementation/result ("implementations(':(implementation)')/result"
                                            :method :get :content-type "text/plain")
  (let ((runner (get-run-form implementation)))
    (if runner
      (with-output-to-string (*standard-output*)
        (funcall runner))
      (setf (hunchentoot:return-code*) hunchentoot:+http-not-found+))))

(restas:define-route implementation/expand ("implementations(':(implementation)')/expand"
                                            :method :get :content-type "text/plain")
  (let ((expander (get-expand-form implementation)))
    (if expander
      (with-output-to-string (*standard-output*)
        (let ((*package* (find-package (string-upcase implementation))))
          (pprint (funcall expander)))
        (setf (hunchentoot:return-code*) hunchentoot:+http-not-found+)))))

(defun markdown (string)
  (with-output-to-string (s)
    (3bmd:parse-string-and-print-to-stream string s)))

(restas:define-route implementation/description ("implementations(':(implementation)')/description"
                                                 :method :get :content-type "text/html")
  (let* ((package (find-package (string-upcase implementation)))
         (documentation (and package (documentation package t))))
    (if documentation
      (markdown documentation)
      (setf (hunchentoot:return-code*) hunchentoot:+http-not-found+))))

(compile-and-load-all-implementations)

#||
(setf hunchentoot:*catch-errors-p* nil)
||#
