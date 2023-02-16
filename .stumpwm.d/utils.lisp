(defun string-include (string1 string2)
  (let* ((string1 (string string1)) (length1 (length string1)))
    (if (zerop length1)
        nil 
        (labels ((sub (s)
                   (cond
                    ((> length1 (length s)) nil)
                    ((string= string1 s :end2 (length string1)) string1)
                    (t (sub (subseq s 1))))))
          (sub (string string2))))))

(defun env-exists (name)
  (loop for item in (sb-ext:posix-environ) thereis (string-include name item)))

(defun is-laptop ()
  (env-exists "LAPTOP"))

(defun is-work-machine ()
  (env-exists "WORK_MACHINE"))

(defun insert-seperators (l &optional (seperator " | ") (seperated-list (list seperator)))
  (if (car l)
      (insert-seperators (cdr l) seperator (nconc (list seperator (car l)) seperated-list))
      (reverse seperated-list)))
