;;;; 99-bottles.asd

(asdf:defsystem #:99-bottles
  :description "Describe 99-bottles here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:restas #:restas-directory-publisher #:cl-json #:3bmd)
  :components ((:file "package")
               (:file "99-bottles")
               (:file "server")))

