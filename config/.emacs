(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(auto-save-default nil)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(tsdh-dark))
 '(make-backup-files nil)
 '(org-agenda-files nil)
 '(org-archive-mark-done t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(org-agenda nil "t")
(add-to-list 'load-path "/home/patrik/.emacs.d/load")
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-agenda-files '("/home/patrik/Documents/org"))
(add-hook 'after-init-hook 'org-todo-list)
(delete-other-windows)
(setq org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done))
(setq inhibit-splash-screen t)
(setq make-backup-files nil)
(setq auto-save-default nil)  
