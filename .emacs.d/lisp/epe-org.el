(require 'org)
(require 'org-agenda)

(add-to-list 'org-modules 'org-habit)

(let*
    ((prefix "~/DriveFileStream/My Drive/org/")
     (agenda-files '("personal.org")))

  (setq org-log-into-drawer t

        ;; todo states
        org-todo-keywords '((sequence "TODO" "PR" "DONE"))
        org-todo-keyword-faces '(("PR" . (:foreground "light")))

        ;; capture / refile
        org-default-notes-file (concat prefix "g.org")
        org-refile-use-outline-path 'file
        org-refile-targets '((org-agenda-files :maxlevel . 2))

        ;; clock
        org-agenda-clockreport-parameter-plist '(:link t :maxlevel 2 :narrow 80)

        ;; agenda
        org-agenda-files (mapcar (lambda (s) (concat prefix s)) agenda-files)
        org-agenda-todo-ignore-scheduled 'all
        org-agenda-sorting-strategy
        '((agenda habit-down time-up priority-down todo-state-up category-keep)
          (todo priority-down todo-state-up category-keep)
          (tags priority-down category-keep)
          (search category-keep))))

;; TODO: split window vertically even if it's wide enough for horizonal
;;       maybe not on laptop though?
(defun epe-org-agenda (&rest args)
  "Putting org-agenda directly in the :bind section of
use-package doesn't seem to work like I'd expect. Putting this in
there does. I suspect some sort of autoload weirdness. TODO:
investigate a better fix."
  (interactive)
  (apply 'org-agenda args))

(defun epe-org-agenda-full ()
  (interactive)
  (epe-org-agenda nil "n"))

(provide 'epe-org)
