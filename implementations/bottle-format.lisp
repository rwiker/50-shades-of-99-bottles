(in-package #:99-bottles)

(defpackage #:bottle-format
  (:documentation "Formatting a format-based implementation of the bottle song
in the shape of a bottle. See
[http://www.99-bottles-of-beer.net](http://www.99-bottles-of-beer.net/language-common-lisp-114.html).

Unfortunately, it does not quite follow the specification, so...")
  (:use #:99-bottles #:common-lisp)
  (:export #:bottle-song))

;;; The format string in Common Lisp is almost a
;;; language on its own. Here's a Lisp version
;;; that shows its power. Hope you find it 
;;; entertaining.

(in-package #:bottle-format)

(defun bottle-song (&optional (in-stock 99) (stream *standard-output*))

  ;; Original idea and primary coding by Geoff Summerhayes
  ;;   <sumrnot@hotmail.com>
  ;; Formatting idea by Fred Gilham <gilham@snapdragon.csl.sri.com>
  ;; Actual formatting & minor recoding by Kent M Pitman
  ;;   <pitman@world.std.com>

  (format

           stream 
         "-----~2%~
          ~{~&~1&~
          ~[~^~:;~
          ~1:*~@(~
          ~R~) bo~
         ttle~:P o~
        f beer on t~
      he wall~01:*~[.~
      ~:;,~%~1:*~@(~R~
      ~) bottle~:*~P ~
      of beer.~%You t~
      ake one down, p~
      ass it around, ~
      ~01%~[*No* more~
      ~:;~01:*~@(~R~)~
      ~] bottle~:*~P ~
      of beer on the ~
      wall.~2&-----~%~
      ~1%~:*~]~]~}~0%"

   (loop for bottle from in-stock downto 0 collect bottle)))

(register-test-forms :run (lambda () (bottle-song 3)))

#||
(bottle-song 3)
||#
