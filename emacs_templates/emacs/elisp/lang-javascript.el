;; js2-mode
;; https://github.com/mooz/js2-mode
(use-package js2-mode
  :ensure t
  :mode
  ("\\.js$" . js2-mode)
  ("\\.json$" . js2-jsx-mode)
  :config
  (custom-set-variables '(js2-strict-inconsistent-return-warning nil))
  (custom-set-variables '(js2-strict-missing-semi-warning nil))

  (setq js-indent-level 2)
  (setq js2-indent-level 2)
  (setq js2-basic-offset 2)

  ;; tern :- IDE like features for javascript and completion
  ;; http://ternjs.net/doc/manual.html#emacs
  (use-package tern
    :ensure t
    :config
    (defun my-js-mode-hook ()
      "Hook for `js-mode'."
      (set (make-local-variable 'company-backends)
           '((company-tern company-files))))
    (add-hook 'js2-mode-hook 'my-js-mode-hook)
    (add-hook 'js2-mode-hook 'company-mode))

  (add-hook 'js2-mode-hook 'tern-mode)

  ;; company backend for tern
  ;; http://ternjs.net/doc/manual.html#emacs
  (use-package company-tern
    :ensure t)

  ;; Run a JavaScript interpreter in an inferior process window
  ;; https://github.com/redguardtoo/js-comint
  (use-package js-comint
    :bind (:map js2-mode-map
                (("C-x C-e" . js-send-last-sexp)
                 ("C-M-x" . js-send-last-sexp-and-go)
                 ("C-c C-b" . js-send-buffer-and-go)
                 ("C-c C-l" . js-load-file-and-go)))
    :ensure t
    :config
    (setq inferior-js-program-command "node"))

  ;; js2-refactor :- refactoring options for emacs
  ;; https://github.com/magnars/js2-refactor.el
  (use-package js2-refactor :defer t
    :ensure t
    :diminish js2-refactor
    :bind ("C-c j r" . js2r-add-keybindings-with-prefix)))

(provide 'lang-javascript)
