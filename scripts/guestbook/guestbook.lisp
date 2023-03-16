(ql:quickload :woo)

(defparameter *icon-file* "~/scripts/guestbook/icon.png")
(defparameter *message-list-file* "~/scripts/guestbook/list.txt")

(defparameter *routes* (make-hash-table :test 'equal))
(defparameter *rate-limits* (make-hash-table :test 'equal))
(defparameter *not-seen-messages* '())

(defun send-alert (msg)
  (uiop:run-program `("notify-send" "--icon" ,*icon-file* ,msg)))


(defun add-message (env)

  

(woo:run
  (lambda (env)
    (let* ((path-info (getf env :path-info))
           (req-method (getf env :request-method))
           (ip (getf env :remote-addr))
           (route-fn (getf *routes* path-info
      
    '(200 (:content-type "text/plain") ("Hello, World")))
  :worker-num 1)
