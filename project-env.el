;;; lisp/project-env/project-env.el -*- lexical-binding: t; -*-

;; .env support
(use-package! load-env-vars)

;; https://humanlytyped.hashnode.dev/working-effectively-with-env-files-in-emacs
;; .Locating the .env
(defvar @-dotenv-file-name ".env"
  "The name of the .env file."
  )
(defun @-find-env-file ()
  "Find the closest .env file in the directory hierarchy."

  (let* ((env-file-directory (locate-dominating-file "." @-dotenv-file-name))
        (file-name (concat env-file-directory @-dotenv-file-name)))
    (when (file-exists-p file-name)
        file-name))
  )
;; .Load the environment variables
(defun @-set-project-env ()
  "Export all environment variables in the closest .env file."

  (let ((env-file (@-find-env-file)))
    (when env-file
      (load-env-vars env-file)))
  )
;; .Register functionality
(defun @-set-env-vars-hooks ()

  (use-package load-env-vars)
  (add-hook 'projectile-mode-hook #'@-set-project-env)
  (add-hook 'projectile-after-switch-project-hook #'@-set-project-env)
  (add-hook 'comint-exec-hook #'@-set-project-env)
  (add-hook 'lsp-mode-hook #'@-set-project-env)
  (add-hook 'vterm-mode-hook #'@-set-project-env)
  )
