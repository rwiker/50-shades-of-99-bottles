(in-package #:99-bottles)

(defpackage #:bottle-format-improved
  (:documentation "Formatting a format-based implementation of the bottle song
in the shape of a bottle. Corrected version of
[http://www.99-bottles-of-beer.net/language-common-lisp-114.html](http://www.99-bottles-of-beer.net/language-common-lisp-114.html).")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

;;; The format string in Common Lisp is almost a
;;; language on its own. Here's a Lisp version
;;; that shows its power. Hope you find it 
;;; entertaining.

(in-package #:bottle-format-improved)

(defun bottle-song (&optional (in-stock 99) (stream *standard-output*))

  ;; Original idea and primary coding by Geoff Summerhayes
  ;;   <sumrnot@hotmail.com>
  ;; Formatting idea by Fred Gilham <gilham@snapdragon.csl.sri.com>
  ;; Actual formatting & minor recoding by Kent M Pitman
  ;;   <pitman@world.std.com>
  ;; Modified to match the "official lyrics" at http://www.99-bottles-of-beer.net/lyrics.html
  ;; by Raymond Wiker <rwiker@gmail.com>

  (format

           stream

         "~01&~:{~
          ~[No mo~
          re~01:;~
          ~01:*~D~
          ~] bott~
         le~:*~P o~
        f beer on t~
      he wall, ~:*~[n~
      o more~0:;~:*~D~
      ~] bottle~:*~P ~
      of beer.~00001%~
      ~:*~[Go to the ~
      store and buy s~
      ome more~0000:;~
      Take one down a~
      nd pass it arou~
      nd~], ~[No more~
      ~:;~1:*~D~] bot~
      tle~1:*~P of be~
      er on the wall.~
      ~000000000002%~}"

   (loop for bottle from in-stock downto 0
         collect (list bottle (if (zerop bottle)
                                in-stock
                                (1- bottle))))))

(register-test-forms :run (lambda () (bottle-song 3)))    

#||
(bottle-song 3)

;;; The non-bottleized format is 
;;;            "~&~:{~[No more~:;~:*~D~] bottle~:*~P of beer on the wall, ~:*~
;;;             ~[no more~:;~:*~D~] bottle~:*~P of beer.~%~:*~
;;;             ~[Go to the store and buy some more, ~:;Take one down and pass it around, ~]~
;;;             ~[No more~:;~:*~D~] bottle~:*~P of beer on the wall.~2%~}"

||#

