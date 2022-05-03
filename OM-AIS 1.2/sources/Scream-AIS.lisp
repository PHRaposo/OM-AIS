(in-package :s)

;;; ALL-INTERVAL-SERIES CALCULATIONS WITH SCREAMER ;;;

(defun intervalv (var1 var2)
 (-v var2 var1))

(defun mod12v (var)
 (funcallv #'mod var 12))

;;;; NORMAL-FORM AIS ;;;

(defun normal-AIS-s ()

;;; DOMAIN ;;;

;;; first = 0 and last = 6

(setf a 0)
(setf l 6)

;var-2 to var-11: (1 2 3 4 5 7 8 9 10 11) 

(let ((b (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (c (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (d (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (e (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (f (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (g (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (h (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (i (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (j (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (k (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11))))

;;; RULES ;;;

;1-) all-diff

(assert! (/=v b c))
(assert!-notv-memberv d (list b c))
(assert!-notv-memberv e (list b c d))
(assert!-notv-memberv f (list b c d e))
(assert!-notv-memberv g (list b c d e f))
(assert!-notv-memberv h (list b c d e f g))
(assert!-notv-memberv i (list b c d e f g h))
(assert!-notv-memberv j (list b c d e f g h i))
(assert!-notv-memberv k (list b c d e f g h i j))

;2-) all-diff-intervals(mod12)

(assert! (/=v (mod12v (intervalv a b)) (mod12v (intervalv b c)) (mod12v (intervalv c d)) 
              (mod12v (intervalv d e)) (mod12v (intervalv e f)) (mod12v (intervalv f g)) 
              (mod12v (intervalv g h)) (mod12v (intervalv h i)) (mod12v (intervalv i j)) 
              (mod12v (intervalv j k)) (mod12v (intervalv k l))))

;force-solution

(all-values
 (solution 
  (list a b c d e f g h i j k l)
   (static-ordering #'linear-force)))))


;;;; PRIME-FORM-AIS ;;;;

(defun prime-AIS-s ()

(setf a 0)
(setf l 6)

(let ((b (an-integer-betweenv 1 5)) ;<<<--- ONLY PRIME-FORM AIS ;;;
      (c (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (d (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (e (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (f (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (g (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (h (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (i (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (j (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11)))
      (k (a-member-ofv (list 1 2 3 4 5 7 8 9 10 11))))

(assert! (/=v b c))
(assert!-notv-memberv d (list b c))
(assert!-notv-memberv e (list b c d))
(assert!-notv-memberv f (list b c d e))
(assert!-notv-memberv g (list b c d e f))
(assert!-notv-memberv h (list b c d e f g))
(assert!-notv-memberv i (list b c d e f g h))
(assert!-notv-memberv j (list b c d e f g h i))
(assert!-notv-memberv k (list b c d e f g h i j))

(assert! (/=v (mod12v (intervalv a b)) (mod12v (intervalv b c)) (mod12v (intervalv c d)) 
              (mod12v (intervalv d e)) (mod12v (intervalv e f)) (mod12v (intervalv f g)) 
              (mod12v (intervalv g h)) (mod12v (intervalv h i)) (mod12v (intervalv i j)) 
              (mod12v (intervalv j k)) (mod12v (intervalv k l))))

(all-values
 (solution 
  (list a b c d e f g h i j k l)
   (static-ordering #'linear-force)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :om-ais)

(om::defmethod! normal-ais-scream ()
	:icon 01
	:doc "Returns 3856 normal-form all-interval series"
	(time (s::normal-ais-s)))

(om::defmethod! prime-ais-scream ()
	:icon 01
	:doc "Returns 1928 prime-form all-interval series"
	(time (s::prime-ais-s)))

