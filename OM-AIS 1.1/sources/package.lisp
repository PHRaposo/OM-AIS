(in-package :om)

(defvar *OM-AIS-path* (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "AIS"))))

;(require-library "Mathtools")

(defpackage :OM-AIS
(:use "COMMON-LISP" "OM" "CL-USER"))






