;;; flycheck-kotlin.el --- Support kotlin in flycheck

;; Copyright (C) 2017 Elric Milon <whirm@__REMOVETHIS__gmx.com>
;;
;; Author: Elric Milon <whirm_REMOVETHIS__@gmx.com>
;; Created: 20 January 2017
;; Version: 0.1
;; Package-Requires: ((flycheck "0.18"))

;;; Commentary:

;; This package adds support for kotlin to flycheck. To use it, add
;; to your init.el:

;; (require 'flycheck-kotlin)
;; (add-hook 'kotlin-mode-hook 'flycheck-mode)

;;; License:

;; This file is not part of GNU Emacs.
;; However, it is distributed under the same license.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;; Code:
(require 'flycheck)
(require 'url)

(defconst flycheck-kotlin-detekt-jar-path (expand-file-name "~/.emacs.d/detekt-cli-1.0.0-RC12-all.jar"))
(defconst flycheck-kotlin-detekt-config-path (expand-file-name "~/.emacs.d/default-detekt-config.yml"))

;; if detekt jar is not present, let's download it.
(if (not (file-exists-p flycheck-kotlin-detekt-jar-path))
  (url-copy-file "https://github.com/arturbosch/detekt/releases/download/1.0.0-RC12/detekt-cli-1.0.0-RC12-all.jar" flycheck-kotlin-detekt-jar-path)
)

(flycheck-define-checker kotlin-detekt
  ""
  :command ("java" "-jar" (eval flycheck-kotlin-detekt-jar-path) "-c" (eval flycheck-kotlin-detekt-config-path) "-i" source-inplace)
  :error-patterns
  ((error line-start (message) " at " (file-name) ":" line ":" column line-end))
  :modes kotlin-mode)


;;;###autoload
(defun flycheck-kotlin-setup ()
  "Setup Flycheck for Kotlin."
  (add-to-list 'flycheck-checkers 'kotlin-detekt))

(provide 'flycheck-kotlin-detekt)
;;; flycheck-kotlin-detekt.el ends here
