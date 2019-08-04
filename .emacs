(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

;; This is to avoid the  warining "ls does not support --dired" that happens in MacOS.
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


;; use-package
(eval-when-compile
  (require 'use-package))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; A GNU Emacs library to ensure environment variables inside Emacs look the same as in the user's shell.
;; (use-package exec-path-from-shell
;;  :ensure t)
;;  (when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize))

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

(org-babel-do-load-languages
 'org-babel-load-languages '((emacs-lisp . t) (mermaid . t) (gnuplot . t)))
