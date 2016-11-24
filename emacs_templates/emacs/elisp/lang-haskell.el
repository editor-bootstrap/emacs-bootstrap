(use-package flycheck-haskell
  :config
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'flycheck-mode-hook 'flycheck-haskell-configure))

(use-package company-ghci
  :config
  (push 'company-ghci company-backends))

(use-package haskell-mode
  :config
  (add-hook 'haskell-mode-hook 'haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  (add-hook 'haskell-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook (lambda ()
				 (set (make-local-variable 'company-backends)
				      (append '((company-capf company-dabbrev-code))
					      company-backends)))))

(provide 'lang-haskell)
