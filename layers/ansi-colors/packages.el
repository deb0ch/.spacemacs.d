
(defconst ansi-colors-packages
  '(
    (tty-format :location local)
    )
  "The list of Lisp packages required by the my-multiple-cursors layer."
  )


(defun ansi-colors/init-tty-format ()
  (use-package tty-format
    :config
    (progn
      ;; M-x display-ansi-colors to explicitly decode ANSI color escape sequences
      (defun display-ansi-colors ()
        (interactive)
        (format-decode-buffer 'ansi-colors))

      ;; decode ANSI color escape sequences for *.txt or README files
      (add-hook 'find-file-hooks 'tty-format-guess)

      ;; decode ANSI color escape sequences for .log files
      (add-to-list 'auto-mode-alist '("\\.log\\'" . display-ansi-colors)))))
