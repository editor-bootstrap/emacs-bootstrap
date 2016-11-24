(use-package js2-mode
  :config
  (custom-set-variables '(js2-strict-inconsistent-return-warning nil))
  (custom-set-variables '(js2-strict-missing-semi-warning nil))

  (setq js-indent-level 2)
  (setq js2-indent-level 2)
  (setq js2-basic-offset 2)
  (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-jsx-mode)))

(use-package js2-refactor)

(use-package js-comint
  :config
  (setq inferior-js-program-command "node"))

(provide 'lang-javascript)
