;;; tools/project-env/autoload.el -*- lexical-binding: t; -*-
;;; This file is where you’ll store functions
;;; that shouldn’t be loaded until they’re needed and
;;; logic that should be autoloaded (evaluated very, very early at startup).

;; https://humanlytyped.hashnode.dev/working-effectively-with-env-files-in-emacs
;; .Locating the .env
(defvar +dotenv/dotenv-file-name ".env"
  "The name of the .env file."
  )

(defun +dotenv/find-env-file ()
  "Find the closest .env file in the directory hierarchy."

  (let* ((env-file-directory (locate-dominating-file "." +dotenv/dotenv-file-name))
        (file-name (concat env-file-directory +dotenv/dotenv-file-name)))
    (when (file-exists-p file-name)
        file-name))
  )
;; .Load the environment variables - autoload to expose
;;;###autoload
(defun +dotenv/set-project-env ()
  "Export all environment variables in the closest .env file."
  (use-package! load-env-vars)

  (let ((env-file (+dotenv/find-env-file)))
    (when env-file
      (load-env-vars env-file)))
  )
