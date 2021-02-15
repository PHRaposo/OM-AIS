(in-package :om-ais)

#|
;;; MODEL FOR OM::DEFMETHOD! DEFINITION ;;;

(om::defmethod! name ((input1 type) (input2 type) (... ...))
        :initvals '( 'input1-initvals 'input2-initvals '...)
	:indoc '("description-input1" "description-input2" "...") 
	:icon number for icon
        :menuins '( (input-number (("name1" output) ("name2" output2) ("..." ...)) ) )
        :numouts number ;values construction
	:doc "short documentation"
|#

;;; BASIC-FUNCTIONS ;;;
      
(defun string-to-list (str) ; Solution by Banjocat - stackoverflow.com
        (if (not (streamp str))
           (string-to-list (make-string-input-stream str))
           (if (listen str)
               (cons (read str) (string-to-list str))
               nil)))

(defun read-text-file (string) 
(let ((stream (open (merge-pathnames om::*OM-AIS-path* (parse-namestring (concatenate 'string string ".txt"))))))
(string-to-list stream))) 

(defun subtraction (input-lists)
 (mapcar #'(lambda (input1)
   (om::om- input1 (first input1))) input-lists))

(defun get-ais-chord (AIS low)
 (om::dx->x low (om::om* 100 (mod12 (om::x->dx AIS)))))

(defun operation-q (AIS)
(let* ((rotations-AIS (mapcar #'(lambda (input1)
                       (om::rotate AIS input1)) (om::arithm-ser 1 (- (length AIS) 1) 1)))
        (transp-to-zero (mod12 (subtraction rotations-AIS)))) 
(flat (loop
     for list in transp-to-zero
     for y = (om::last-elem list)
     when (= 6 y)
     collect list))))

(defun inversion (AIS)
 (mapcar #' (lambda (input1)
    (mod input1 12)) (om::om- 12 AIS)))

(defun retrograde (AIS)  
(let ((reverse-AIS (reverse AIS)))
 (mapcar #' (lambda (input1)
  (mod input1 12)) (om::om- reverse-AIS (first reverse-AIS)))))

(defun m-5 (AIS)
(mapcar #'(lambda (input1)
  (mod (om::om* 5 input1) 12)) AIS))

(defun operation-0 (AIS)
(om::subs-posn AIS (list (position 3 AIS) (position 9 AIS)) '(9 3)))

(defun t-0 (AIS)
   (mod12 (om::om- AIS (first AIS))))


;;; METHOD FOR CALCULATIONS OF ALL AIS - REQUIRE OMCS ;;;
#|

(defun calculate-AIS ()
(let* ((space (om::x-append 
              (list '(0)) 
              (om::repeat-n '(0 1 2 3 4 5 7 8 9 10 11) 10)
              (list '(6))))
       (first-rule ;no duplicate pcs
        (omcs::wildcard-rule
         (lambda (input1)
          (not (member input1 (cdr (omcs::rev-partial-solution)))))))

       (second-rule ;no duplicate intervals
        (omcs::wildcard-rule 
         (lambda () (cond ((<= (length (omcs::rev-partial-solution)) 2)) 
                    (t (not (member
                            (mod (- (second (omcs::rev-partial-solution)) 
                            (first (omcs::rev-partial-solution))) 12)
                            (cdr (mapcar #'(lambda (input1)
                            (mod input1 12)) (om::x->dx (omcs::rev-partial-solution))))))))))))


(omcs::pmc-engine space (list first-rule second-rule) nil nil :all nil nil))) 

|#

;;; OM-INTERFACE ;;;

(om::defmethod! Q-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns Q-AIS."
(operation-q AIS))

(om::defmethod! I-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns I-AIS."
(inversion AIS))

(om::defmethod! R-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns R-AIS."
(retrograde AIS))

(om::defmethod! RI-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns RI-AIS."
(inversion (retrograde AIS)))

(om::defmethod! M-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns M-AIS."
(m-5 AIS))

(om::defmethod! IM-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns IM-AIS."
(inversion (m-5 AIS)))

(om::defmethod! QR-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns QR-AIS."
(retrograde (operation-q AIS)))

(om::defmethod! 0-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns OPERATION-0-AIS (exchange 3 for 9)."
(operation-0 AIS))

(om::defmethod! AIS->CHORDS ((AIS-list list) (lowest-note number))
        :initvals '( '((0 1 3 2 7 10 8 4 11 5 9 6) (0 1 3 2 9 5 10 4 7 11 8 6)) 3600)
	:indoc '("AIS-list" "midics") 
	:icon 06
	:doc "Returns a list of chords in midicents, transposed to the lowest note <midicents>."
(mapcar #'(lambda (input1)
 (get-ais-chord input1 lowest-note)) AIS-list))

(om::defmethod! AIS->CHORDS ((AIS-list list) (lowest-notes list))
        :initvals '( '((0 1 3 2 7 10 8 4 11 5 9 6) (0 1 3 2 9 5 10 4 7 11 8 6)) '(3600 3400))
	:indoc '("AIS-list" "midics-list") 
	:icon 06
	:doc "Returns a list of chords in midicents, transposed to the lowest note <midicents>."
(mapcar #'(lambda (input1 input2)
 (get-ais-chord input1 input2)) AIS-list lowest-notes))


(om::defmethod! AIS->CHORD ((AIS list) (lowest-note number))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) 3600)
	:indoc '("AIS" "midics") 
	:icon 06
	:doc "Returns a chord in midicents, transposed to the lowest note."
(get-ais-chord AIS lowest-note))

(om::defmethod! normal-AIS ()
	:icon 013
	:doc "Returns all 3856 normal form AIS."
(read-text-file "3856-AIS"))

(om::defmethod! prime-AIS ()
	:icon 013
	:doc "Returns all 1928 prime form AIS."
(read-text-file "1928-AIS"))

(om::defmethod! normal-R-invariant ()
	:icon 013
	:doc "Returns all normal form R invariant AIS."
(read-text-file "normal-R-invariant"))

(om::defmethod! prime-R-invariant ()
	:icon 013
	:doc "Returns all prime form R invariant AIS."
(read-text-file "prime-R-invariant"))

(om::defmethod! normal-QI-invariant ()
	:icon 013
	:doc "Returns all normal form QI invariant AIS."
(read-text-file "normal-QI-invariant"))

(om::defmethod! prime-QI-invariant ()
	:icon 013
	:doc "Returns all prime form QI invariant AIS."
(read-text-file "prime-QI-invariant"))

(om::defmethod! normal-QRMI-invariant ()
	:icon 013
	:doc "Returns all normal form QRMI invariant AIS."
(read-text-file "normal-QRMI-invariant"))

(om::defmethod! prime-QRMI-invariant ()
	:icon 013
	:doc "Returns all prime form QRMI invariant AIS."
(read-text-file "prime-QRMI-invariant"))

(om::defmethod! LINK-CHORDS ()
	:icon 013
	:doc "Returns all 192 LINK-CHORDS."
(read-text-file "LINK-CHORDS"))

(om::defmethod! LINK-RI-invariant ()
	:icon 013
	:doc "Returns all four RI invariant LINK-CHORDS."
(read-text-file "LINK-RI-invariant"))

(om::defmethod! SAISs ()
	:icon 013
	:doc "Returns all 267 shorter listing of source-AISs (SAISs)."
(read-text-file "SAISs"))

(om::defmethod! MYSTERY-AIS ()
	:icon 013
	:doc "Returns two Mysterious AIS."
(read-text-file "MYSTERY"))


;;; UTILS ;;; 

(om::defmethod! mc->pc ((midicents list))
        :initvals '((6500 6400 7200 6900 7900 7400 8000 7300 7500 6600 7000 5900))
	:indoc '("List midicents") 
	:icon 05
	:doc "Midicents to pitch classes."
(mod12 (om::om/ midicents 100)))

(om::defmethod! pc->mc ((pcs list))
        :initvals '(0 1 3 2 7 10 8 4 11 5 9 6)
	:indoc '("List midicents") 
	:icon 05
	:doc "Pitch classes to midicents."
(om::om+ 6000 (om::om* pcs 100)))

(om::defmethod! intervals-mod12 ((AIS list))
        :initvals '((5 4 0 9 7 2 8 1 3 6 10 11))
	:indoc '("List or list of lists.") 
	:icon 05
	:doc "Calculates the intervals mod12 of an AIS."
(mod12 (om::x->dx AIS)))

(om::defmethod! AIS->normal ((AIS list))
        :initvals '((0 1 3 2 7 10 8 4 11 5 9 6))
	:indoc '("AIS - list of pitch-classes") 
	:icon 05
	:doc "Transposes an AIS to its normal form."
(t-0 AIS))

(om::defmethod! AIS->prime ((AIS list))
        :initvals '((0 1 3 2 7 10 8 4 11 5 9 6))
	:indoc '("AIS - list of pitch-classes") 
	:icon 05
	:doc "Calculates the prime form of an AIS."
(let* ((normal-form (t-0 AIS))
       (first-interval (- (second normal-form) (first normal-form))))
   (cond ((< first-interval (- 12 first-interval))
          (write normal-form))
   (t (write (inversion normal-form))))))

(om::defmethod! all-rotations ((PCS list))
        :initvals '((0 1 3 2 7 10 8 4 11 5 9 6))
	:indoc '("AIS - list of pitch-classes") 
	:icon 05
	:doc "Calculates all rotations of a given list."
 (mapcar #'(lambda (input1)
  (om::rotate PCS input1)) (om::arithm-ser 0 (- (length PCS) 1) 1)))
  
(om::defmethod! mod12 ((arg number))
        :initvals '( -5)
	:indoc '("number or list of numbers") 
	:icon 05
	:doc "Calculates the modulo 12 of a number or list of numbers."
(mod arg 12))

(om::defmethod! mod12 ((args list))
        :initvals '( (-1 -4 -5 -7))
	:indoc '("number or list of numbers") 
	:icon 05
	:doc "Calculates the modulo 12 of a number or list of numbers."
(mapcar #'(lambda (input1)
          (mod12 input1)) args))

     


