;; C-; as prefix key
(stumpwm:set-prefix-key (stumpwm:kbd "C-;"))

(define-key *top-map* (kbd "s-n") "pull-hidden-next")
(define-key *top-map* (kbd "s-p") "pull-hidden-previous")

(define-key *top-map* (kbd "s-h") "resize 40 0")
(define-key *top-map* (kbd "s-l") "resize -40 0")
(define-key *top-map* (kbd "s-j") "resize 0 40")
(define-key *top-map* (kbd "s-k") "resize 0 -40")

(define-key *top-map* (kbd "s-u") "exec pamixer -i 5")
(define-key *top-map* (kbd "s-d") "exec pamixer -d 5")

(define-key *top-map* (kbd "s-w") "exec xbacklight -inc 5")
(define-key *top-map* (kbd "s-s") "exec xbacklight -dec 5")

(define-key *top-map* (kbd "s-TAB") "fnext")
(define-key *top-map* (kbd "s-ISO_Left_Tab") "fprev")

(define-key *root-map* (kbd "C-t") "exec alacritty")
(define-key *root-map* (kbd "b") "exec firefox")

(when (is-work-machine)
  (define-key *root-map* (kbd "C-i") "exec aggietimed --action clock-in")
  (define-key *root-map* (kbd "C-o") "exec aggietimed --action clock-out"))
