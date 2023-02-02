;;;; ice.asd

(asdf:defsystem #:ice
  :description "A simple raytracer."
  :author "Jan Deinhard <jan.deinhard@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:clerk
               #:inferior-shell
               #:trivial-clipboard
               #:fiveam)
  :components ((:file "package")
               (:file "ice"))
  :in-order-to ((test-op (test-op "ice/tests"))))

(asdf:defsystem #:ice/tests
  :depends-on (#:ice
               #:fiveam)
  :components ((:module "tests"
		:serial t
		:components ((:file "package")
			     (:file "main"))))
  :perform (test-op (o c)
		    (uiop:symbol-call '#:fiveam '#:run! :ice/tests)))
