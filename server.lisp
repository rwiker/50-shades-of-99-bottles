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
        "goto"
        "recursive"
        "special-recursive"
        "extended-loop"
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

(restas:define-route implementation/code ("implementations(':(implementation)')/code"
                                          :method :get :content-type "text/plain")
  (implementation-pathname implementation))

(restas:define-route implementation/result ("implementations(':(implementation)')/result"
                                            :method :get :content-type "text/plain")
  (let* ((package (find-package (string-upcase implementation)))
         (symbol (and package (find-symbol "BOTTLE-SONG" package))))
    (if symbol
      (with-output-to-string (*standard-output*)
        (funcall symbol 3))
      (setf (hunchentoot:return-code*) hunchentoot:+http-not-found+))))

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
(restas:start :99-bottles-server :port 8080)

(setf hunchentoot:*catch-errors-p* nil)