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
;;;  - operation 0 - (0)
;;;  - constellation
;;;
;;; References 
;;;
;;; PWGL Book, p.142, by Mikael Laurson and Mika Kuuskankare 
;;; PWConstraints, by Mikael Laurson.
;;; The Structure of All-Interval Series by Robert Morris and Daniel Starr 
;;; On Eleven-Interval Twelve-Tone Rows, by Stefan Bauer-Mengelberg and Melvin Ferentz
;;; The Composition of Elliott Carter's Night Fantasies, by John F. Link
;;; Harmony Book, by Elliott Carter
;;; The "Link Chords", by John Link
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
;;; FIRST RELEASE: OM-AIS 1.0 for OM and OM# - feb 10/2021
;;; Added LINK-CHORDS, NEW FUNCTIONS (PC->MC) AND TWO EXAMPLES OF CALCULATIONS USING SCREAMER CONSTRAINT SOLVER.
;;;
;;; UPDATE -> OM-AIS 1.1 - may 01/2021: 
;;; - ADDED SERIES AND CHORDS EXAMPLE;
;;; - ADDED TUTORIAL PATCHES WITH ALL CALCULATIONS (REQUIRE OMCS LIBRARY)-ONLY FOR OM;
;;;	- FUNCTIONS AIS->CHORD AND AIS->CHORDS MERGED INTO A SINGLE FUNCTION (AIS->CHORD)- MOVED TO 'UTILS' FOLDER;
;;; - CORRECTED LINK-RI-INVARIANT TO LINK-R-INVARIANT;
;;; - NEW OPERATION: CONSTELLATION;
;;; - FUNCTIONS WITH SCREAMER LISP WERE REMOVED (THE LISP FILE STILL AVAILABLE).
;;; UPDATE -> OM-AIS 1.2 - may 03/2022:
;;; ADDED THE FUNCTION AIS->MELODIC-CONTOURS.	
	
	
(in-package :om)

;(defvar *OM-AIS-path* (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "sources") (list "AIS"))))

(mapc 'compile&load (list
                         (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "sources")) :name "package" :type "lisp")
                         (make-pathname  :directory (append (pathname-directory *load-pathname*) (list "sources")) :name "OM-AIS-functions" :type "lisp")
                         ;(make-pathname  :directory (append (pathname-directory *load-pathname*) (list "sources")) :name "Scream-AIS" :type "lisp")
))

(fill-library '( ("ALL" Nil Nil (om-ais::NORMAL-AIS
                                     om-ais::PRIME-AIS
                                     om-ais::NORMAL-R-INVARIANT
                                     om-ais::PRIME-R-INVARIANT
                                     om-ais::NORMAL-QI-INVARIANT
                                     om-ais::PRIME-QI-INVARIANT
                                     om-ais::NORMAL-QRMI-INVARIANT
                                     om-ais::PRIME-QRMI-INVARIANT
                                     om-ais::LINK-CHORDS
									 om-ais::LINK-CHORDS-TWO-INSTANCES
                                     om-ais::LINK-R-INVARIANT	
                                     om-ais::SAISs	
                                     om-ais::MYSTERY-AIS										 									 							 																		 
									 ) Nil)

                     ("OPERATIONS" Nil Nil (om-ais::R-AIS
                                            om-ais::RI-AIS
                                            om-ais::I-AIS
                                            om-ais::Q-AIS
                                            om-ais::M-AIS
                                            om-ais::IM-AIS
                                            om-ais::QR-AIS
                                            om-ais::0-AIS
											om-ais::CONSTELLATION) Nil)

                     ;("CHORDS" Nil Nil (om-ais::AIS->CHORD
                     ;                   om-ais::AIS->CHORDS) Nil)

                     ("UTILS" Nil Nil (om-ais::AIS->CHORD
						 			   om-ais::AIS->MELODIC-CONTOURS
						               om-ais::MC->PC
						  			   om-ais::PC->MC
                                       om-ais::INTERVALS-MOD12
                                       om-ais::MOD12
                                       om-ais::AIS->NORMAL
                                       om-ais::AIS->PRIME) Nil)

                     ;("SCREAMS" Nil Nil (om-ais::NORMAL-AIS-SCREAM
                     ;                    om-ais::PRIME-AIS-SCREAM) Nil)

))

(print "
OM-AIS (All-Interval <Twelve-Tone> Series                                       
   by Paulo Henrique Raposo - 2021
   Version 1.2 - may 03/2022
Icons from the series Lyric Suite 
       by Robert Motherwell
")



