(in-package :stumpwm)

;; Utils and helpers
(load "~/.stumpwm.d/utils.lisp")

;; Swank
(load "~/.stumpwm.d/swank.lisp")

;; Keybindings and whatnot
(load "~/.stumpwm.d/keyboard.lisp")

;; Groups
(load "~/.stumpwm.d/groups.lisp")

;; The actual rice
(load "~/.stumpwm.d/theme.lisp")
(load "~/.stumpwm.d/gaps.lisp")
(load "~/.stumpwm.d/modeline.lisp")

;; Follow focus on mouse hover
(setq *mouse-focus-policy* :sloppy)

(when (is-work-machine)
  (run-shell-command "sleep 3 && . ~/scripts/watch_aggietimed.sh"))
(run-shell-command "dunst")
