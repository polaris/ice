;;;; ice.asd

(asdf:defsystem #:ice
  :description "Describe ice here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:drakma #:cxml)
  :components ((:file "package")
               (:file "ice")))
