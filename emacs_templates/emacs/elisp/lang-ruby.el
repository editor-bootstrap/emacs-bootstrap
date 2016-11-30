(use-package enh-ruby-mode
  :mode
  (("\\.rb\\'" . ruby-mode)))

(use-package robe
  :config
  (push 'company-robe company-backends))

(use-package rinari)

(provide 'lang-ruby)
