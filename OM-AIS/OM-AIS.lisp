;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; AIS library for OM, Paulo Henrique Raposo
;;;   All Interval <Twelve Tone> Series
;;;
;;; This library was created to deal with calculations and manipulations of All-Interval Series.
;;; There are 3856 possible normal form AIS, 1928 prime form AIS and some invariant AIS 
;;; (R, QI and QRMI invariants).The operations avaiable are:
;;;  -  retrogradation (R)
;;;  - inversion (I)
;;;  - retrograde inversion (RI) 
;;;  - operation Q (Q)
;;;  - multiplication (M)
;;;  - inversion multiplication (IM)
;;;  - retrograde Q (QR)
;;;; - operation 0 - (0)
;;;
;;; References 
;;;
;;; PWGL Book, p.142, by Mikael Laurson and Mika Kuuskankare 
;;; PWConstraints, by Mikael Laurson.
;;; The Structure of All-Interval Series by Robert Morris and Daniel Starr 
;;; On Eleven-Interval Twelve-Tone Rows, by Stefan Bauer-Mengelberg and Melvin Ferentz
;;; The Composition of Elliott Carter's Night Fantasies, by John F. Link
;;; Harmony Book, by Elliott Carter
;;;
;;; Copyright (C) 2021 Paulo Henrique Raposo
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the Lisp Lesser Gnu Public License.  See
;;; http://www.cliki.net/LLGPL for the text of this agreement.
;;;
;;; First OM version: jan 7/2021 - Thanks to Fabio De Sanctis De Benedictis and to Karin Haddad for testing the library.
;;; Updated:jan 12/2021 - Added normal and prime form QRMI invariants.
;;;        jan 13/2021 - Compatible version with OM-sharp. Thanks to Jerome for testing this version and Jean Bresson for helping with the code.
;;;        jan 16/2021 - New tutorial patch and new functions (UTILS).
;;;

(in-package :om)

(defvar *OM-AIS-path* (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "sources") (list "AIS"))))

(mapc 'compile&load (list
                         (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "sources")) :name "package" :type "lisp")
                         (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "sources")) :name "OM-AIS-functions" :type "lisp")))

(fill-library '( ("ALL" Nil Nil (om-ais::NORMAL-AIS
                                     om-ais::PRIME-AIS
                                     om-ais::NORMAL-R-INVARIANT
                                     om-ais::PRIME-R-INVARIANT
                                     om-ais::NORMAL-QI-INVARIANT
                                     om-ais::PRIME-QI-INVARIANT
                                     om-ais::NORMAL-QRMI-INVARIANT
                                     om-ais::PRIME-QRMI-INVARIANT) Nil)

                     ("OPERATIONS" Nil Nil (om-ais::R-AIS
                                            om-ais::RI-AIS
                                            om-ais::I-AIS
                                            om-ais::Q-AIS
                                            om-ais::M-AIS
                                            om-ais::IM-AIS
                                            om-ais::QR-AIS
                                            om-ais::0-AIS) Nil)

                     ("CHORDS" Nil Nil (om-ais::AIS->CHORD
                                        om-ais::AIS->CHORDS) Nil)

                     ("UTILS" Nil Nil (om-ais::MC->PC
                                       om-ais::INT-MOD12
                                       om-ais::MOD-12
                                       om-ais::AIS->NORMAL
                                       om-ais::AIS->PRIME) Nil)

))

(print "
OM-AIS (All-Interval <Twelve-Tone> Series                                       
   by Paulo Henrique Raposo - 2021
Icons from the series Lyric Suite 
       by Robert Motherwell
")



