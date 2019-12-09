
(with-eval-after-load 'winum
  (define-key winum-keymap (kbd "M-1") nil)
  (define-key winum-keymap (kbd "M-2") nil)
  (define-key winum-keymap (kbd "M-3") nil)
  (define-key winum-keymap (kbd "M-4") nil)
  (define-key winum-keymap (kbd "M-5") nil)
  (define-key winum-keymap (kbd "M-6") nil))

(global-set-key (kbd "M-1") 'mc/mark-all-like-this-dwim)
(global-set-key (kbd "M-!") 'mc/mark-more-like-this-extended) ;; Todo: special actions transient state

(global-set-key (kbd "M-2") 'er/expand-region)
(global-set-key (kbd "M-@") 'er/contract-region)

(global-set-key (kbd "C-3") 'mc/mark-next-symbol-like-this)
(global-set-key (kbd "C-#") 'mc/unmark-next-symbol-like-this)

(global-set-key (kbd "M-3") 'mc/mark-next-like-this)
(global-set-key (kbd "M-#") 'mc/unmark-next-like-this)

(global-set-key (kbd "M-4") 'mc/cycle-forward)
(global-set-key (kbd "M-$") 'mc/cycle-backward)

(global-set-key (kbd "M-5") 'mc/skip-to-next-like-this)
(global-set-key (kbd "M-%") 'mc/skip-to-previous-like-this)

(global-set-key (kbd "M-6") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-^") 'mc/unmark-previous-like-this)

(global-set-key (kbd "C-6") 'mc/mark-previous-symbol-like-this)
(global-set-key (kbd "C-^") 'mc/unmark-previous-symbol-like-this)
