
(in-package :OM-AIS)

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
      
(defun string-to-list (str) ; Solution by Banjocat - stackoverflow.com
        (if (not (streamp str))
           (string-to-list (make-string-input-stream str))
           (if (listen str)
               (cons (read str) (string-to-list str))
               nil)))

(defun read-text-file (string) 
(let ((stream (open (merge-pathnames om::*OM-AIS-path* (parse-namestring (concatenate 'string string ".txt"))))))
(string-to-list stream))) 

(defun s-AIS (label)
(let ((AIS-list (read-text-file "AIS-list")))  
(loop for list in AIS-list
      when (equal (first list) label)
          return (second list))))
      
(defun list-mod-12 (input-lists)
  (loop
     for list in input-lists
     for y = (mapcar #'(lambda (input1)
            (mod input1 12)) list)
     collect y))

(defun mod12 (input-list)
(mapcar #'(lambda (input1)
            (mod input1 12)) input-list))

(defun subtraction (input-lists)
 (mapcar #'(lambda (input1)
   (om::om- input1 (first input1))) input-lists))

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

(om::defmethod! RQ-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns RQ-AIS."
(retrograde (operation-q AIS)))

(om::defmethod! 0-AIS ((AIS list))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) )
	:indoc '("AIS") 
	:icon 04
	:doc "Returns OPERATION-0-AIS (exchange 3 for 9)."
(operation-0 AIS))

(defun get-ais-chord (AIS low)
 (om::dx->x low (om::om* 100 (mod12 (om::x->dx AIS)))))

(om::defmethod! AIS->CHORDS ((AIS-list list) (lowest-note number))
        :initvals '( '((0 1 3 2 7 10 8 4 11 5 9 6) (0 1 3 2 9 5 10 4 7 11 8 6)) '3600)
	:indoc '("AIS-list" "midics") 
	:icon 04
	:doc "Returns a list of chords in midicents, transposed to the lowest note <midicents>."
(mapcar #'(lambda (input1)
 (get-ais-chord input1 lowest-note)) AIS-list))

(om::defmethod! AIS->CHORDS ((AIS-list list) (lowest-notes list))
        :initvals '( '((0 1 3 2 7 10 8 4 11 5 9 6) (0 1 3 2 9 5 10 4 7 11 8 6)) '(3600 3400))
	:indoc '("AIS-list" "midics-list") 
	:icon 04
	:doc "Returns a list of chords in midicents, transposed to the lowest note <midicents>."
(mapcar #'(lambda (input1 input2)
 (get-ais-chord input1 input2)) AIS-list lowest-notes))


(om::defmethod! AIS->CHORD ((AIS list) (lowest-note number))
        :initvals '( '(0 1 3 2 7 10 8 4 11 5 9 6) '3600)
	:indoc '("AIS" "midics") 
	:icon 04
	:doc "Returns a chord in midicents, transposed to the lowest note."
(get-ais-chord AIS lowest-note))

(defun operation-q (AIS)
(let* ((rotations-AIS (mapcar #'(lambda (input1)
                       (om::rotate AIS input1)) (om::arithm-ser 1 (- (length AIS) 1) 1)))
        (transp-to-zero (list-mod-12 (subtraction rotations-AIS)))) 
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

(defun m-7 (AIS)
(mapcar #'(lambda (input1)
  (mod (om::om* 7 input1) 12)) AIS))

(defun operation-0 (AIS)
(om::subs-posn AIS (list (position 3 AIS) (position 9 AIS)) '(9 3)))

#|

METHOD FOR CALCULATIONS OF ALL AIS - REQUIRE OMCS

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
                           ;(om::last-elem ) 
                           ;(first (omcs::rev-partial-solution))))
                    (t (not (member
                            (mod (- (second (omcs::rev-partial-solution)) 
                            (first (omcs::rev-partial-solution))) 12)
                            (cdr (mapcar #'(lambda (input1)
                            (mod input1 12)) (om::x->dx (omcs::rev-partial-solution))))))))))))

(omcs::pmc-engine space (list first-rule second-rule) nil nil :all nil nil))) 
|#

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


