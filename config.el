;;; tools/project-env/config.el -*- lexical-binding: t; -*-
;;; The heart of every module. Code in this file should expect dependencies (in packages.el)
;;; to be installed and available. Use it to load and configure its packages.

;; https://humanlytyped.hashnode.dev/working-effectively-with-env-files-in-emacs
(use-package! load-env-vars)

;; Use the featurep!
;; macro to make some configuration conditional
;; based on the state of another module or the presence of a flag.
(after! projectile
  (add-hook! 'projectile-mode-hook #'+dotenv/set-project-env)
  (add-hook! 'projectile-after-switch-project-hook #'+dotenv/set-project-env)
  )
(after! comint
  (add-hook! 'comint-exec-hook #'+dotenv/set-project-env) )
(after! lsp-mode
  (add-hook! 'lsp-mode-hook #'+dotenv/set-project-env) )
(after! vterm
  (add-hook! 'vterm-mode-hook :append #'+dotenv/set-project-env))
