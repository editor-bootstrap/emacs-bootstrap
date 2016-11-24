(use-package js2-mode
  :config
  (custom-set-variables '(js2-strict-inconsistent-return-warning nil))
  (custom-set-variables '(js2-strict-missing-semi-warning nil))

  (setq js-indent-level 2)
  (setq js2-indent-level 2)
  (setq js2-basic-offset 2)
  (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode)))

(use-package js2-jsx-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-jsx-mode)))

(use-package js2-refactor)

(use-package js-comint
  :config
  (setq inferior-js-program-command "node"))

(use-package npm
  :bind
  ("M-n i" . npm-install)
  ("M-n n" . npm-new)
  ("M-n d" . npm-new-dependency)
  ("M-n e" . npm-new-dev-dependency)
  ("M-n p" . npm-publish)
  ("M-n b" . npm-patch)
  ("M-n m" . npm-minor)
  ("M-n a" . npm-major)
  ("M-n t" . npm-test)
  ("M-n s" . npm-search)
  ("M-n v" . npm-version))


(provide lang-js)
