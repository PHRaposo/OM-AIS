# OM-AIS

This is the AIS (All Interval Series) Library for Openmusic and OM#.

By Paulo Henrique Raposo, 2021.

This library was created to deal with calculations and manipulations of All-Interval Series.
There are 3856 possible normal form AIS, 1928 prime form AIS, Link-Chords and some invariant AIS 
(R, QI and QRMI invariants).The operations avaiable are:
 -  retrogradation (R)
 - inversion (I)
 - retrograde inversion (RI) 
 - operation Q (Q)
 - multiplication (M)
 - inversion multiplication (IM)
 - retrograde Q (QR)
 - operation 0 - (0)
 - constellation

References 

Harmony Book, by Elliott Carter

On Eleven-Interval Twelve-Tone Rows, by Stefan Bauer-Mengelberg and Melvin Ferentz

PWGL Book, p.142, by Mikael Laurson and Mika Kuuskankare 

PWConstraints, by Mikael Laurson.

The Structure of All-Interval Series by Robert Morris and Daniel Starr
 
The Composition of Elliott Carter's Night Fantasies, by John F. Link

The "Link Chords", by John F. Link

First OM version: jan 7/2021 - Thanks to Fabio De Sanctis De Benedictis and to Karin Haddad for testing the library.

Updated:jan 12/2021 - Added normal and prime form QRMI invariants.
        jan 13/2021 - Compatible version with OM-sharp. Thanks to Jerome for testing and Jean Bresson for helping with the code.
		jan 16/2021 - New tutorial patch and new functions (UTILS).

 FIRST RELEASE: OM-AIS 1.0 for OM and OM# - feb 10/2021
 Added Link-Chords, PC->MC function, two examples of calculations with Screamer Constraint Solver and Mystery-AIS.
 UPDATE -> OM-AIS 1.1 - may 01/2021: 
 - ADDED SERIES AND CHORDS EXAMPLE;
 - ADDED TUTORIAL PATCHES WITH ALL CALCULATIONS (REQUIRE OMCS LIBRARY)- ONLY FOR OM;
 - FUNCTIONS AIS->CHORD AND AIS->CHORDS MERGED INTO A SINGLE FUNCTION (AIS->CHORD)- MOVED TO 'UTILS' FOLDER;
 - CORRECTED LINK-RI-INVARIANT TO LINK-R-INVARIANT;
 - NEW OPERATION: CONSTELLATION;
 - FUNCTIONS WITH SCREAMER LISP WERE REMOVED (THE LISP FILE STILL AVAILABLE).
 UPDATE -> OM-AIS 1.2 - may 03/2022:
 - ADDED THE FUNCTION AIS->MELODIC-CONTOURS.	

