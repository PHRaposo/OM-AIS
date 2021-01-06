;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; AIS library for OM, Paulo Henrique Raposo
;;;   All Interval <Twelve Tone> Series
;;;
;;; ***** DESCRIPTION *****
;;;
;;; Copyright (C) 2021 Paulo Henrique Raposo
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the Lisp Lesser Gnu Public License.  See
;;; http://www.cliki.net/LLGPL for the text of this agreement.
;;;
;;;
;;;
;;;
;;;

(in-package :om)

(defvar *OM-AIS-path* (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "AIS"))))

(defpackage OM-AIS
(:use "COMMON-LISP" "OpenMusic" "CL-USER"))

;(import '(functions ...) :OM-AIS) TO USE FUNCTIONS BY TYPING ON THE KEYBOARD;;;; CONFILCTS???

(in-package :OM-AIS)
;(require-library :omcs)

(mapc 'om::compile&load (list (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "sources")) :name "OM-AIS-functions" :type "lisp")))

(om::fill-library '( ("ALL" Nil Nil (NORMAL-AIS PRIME-AIS NORMAL-R-INVARIANT PRIME-R-INVARIANT NORMAL-QI-INVARIANT PRIME-QI-INVARIANT) Nil)

                     ("OPERATIONS" Nil Nil (R-AIS I-AIS Q-AIS M-AIS IM-AIS RQ-AIS 0-AIS) Nil)

                     ("CHORDS" Nil Nil (AIS->CHORD AIS->CHORDS) Nil)))


(print "
OM-AIS (All Interval <Twelve-Tone> Series                                       
   by Paulo Henrique Raposo - 2021
Icons from the series Lyric Suite 
       by Robert Motherwell
")



