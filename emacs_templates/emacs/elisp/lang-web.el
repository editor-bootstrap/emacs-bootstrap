(use-package web-mode
  :mode
  (("\\.js\\'" . web-mode)
   ("\\.html?\\'" . web-mode)
   ("\\.phtml?\\'" . web-mode)
   ("\\.tpl\\.php\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode)
   ("\\.jsx$" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2)

  (add-hook 'web-mode-hook 'jsx-flycheck)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'company-mode)

  ;; highlight enclosing tags of the element under cursor
  (setq web-mode-enable-current-element-highlight t)

  (defadvice web-mode-highlight-part (around tweak-jsx activate)
    (if (equal web-mode-content-type "jsx")
        (let ((web-mode-enable-part-face nil))
          ad-do-it)
      ad-do-it))

  (defun jsx-flycheck ()
    (when (equal web-mode-content-type "jsx")
      ;; enable flycheck
      (flycheck-select-checker 'jsxhint-checker)
      (flycheck-mode))))

(provide 'lang-web)
