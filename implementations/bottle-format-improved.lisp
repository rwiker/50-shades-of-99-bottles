(in-package #:99-bottles)

(defpackage #:bottle-format-improved
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
      ~:*~[Go to the s~
      tore and buy som~
      e more~00000:;Ta~
      ke one down and ~
      pass it around~]~
      , ~[No more~00:;~
      ~01:*~D~] bottle~
      ~1:*~P of beer o~
      n the wall.~02%~}"

   (loop for bottle from in-stock downto 0
         collect (list bottle (if (zerop bottle)
                                in-stock
                                (1- bottle))))))


#||
(bottle-song 3)

;;; The non-bottleized format is 
;;;            "~&~:{~[No more~:;~:*~D~] bottle~:*~P of beer on the wall, ~:*~
;;;             ~[no more~:;~:*~D~] bottle~:*~P of beer.~%~:*~
;;;             ~[Go to the store and buy some more, ~:;Take one down and pass it around, ~]~
;;;             ~[No more~:;~:*~D~] bottle~:*~P of beer on the wall.~2%~}"

||#
