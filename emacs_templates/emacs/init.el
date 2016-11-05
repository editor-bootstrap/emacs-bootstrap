;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base)
{% for lang in langs %}
(require 'core-{{ lang }})
{% endfor %}
