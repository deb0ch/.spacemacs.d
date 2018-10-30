;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `multiple-cursors-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `multiple-cursors/init-PACKAGE' to load and initialize the package.
;;
;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `multiple-cursors/pre-init-PACKAGE' and/or
;;   `multiple-cursors/post-init-PACKAGE' to customize the package as it is loaded.

(defconst my-multiple-cursors-packages
  '(
    multiple-cursors
    expand-region
    )
  "The list of Lisp packages required by the my-multiple-cursors layer."
  )

(defun my-multiple-cursors/init-multiple-cursors ()
  (use-package multiple-cursors
    :defer t
    :commands (mc/cycle-forward
               mc/cycle-backward)))

(defun my-multiple-cursors/post-init-expand-region ())
