;;; test-helper.el --- helper of fluentd-mode test

;; Copyright (C) 2016 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'ert)
(require 'undercover)
(setq undercover-force-coverage t)
(undercover
 "*.el"
 (:report-file "coverage/report.json")
 (:report-format 'simplecov)
 (:send-report nil))

(defmacro with-fluenntd-temp-buffer (code &rest body)
  "Insert `code' and enable `fluentd-mode'. cursor is beginning of buffer"
  (declare (indent 0) (debug t))
  `(with-temp-buffer
     (insert ,code)
     (goto-char (point-min))
     (fluentd-mode)
     (font-lock-fontify-buffer)
     ,@body))

(defun forward-cursor-on (pattern &optional count)
  (let ((case-fold-search nil))
    (re-search-forward pattern nil nil (or count 1)))
  (goto-char (match-beginning 0)))

(defun backward-cursor-on (pattern &optional count)
  (let ((case-fold-search nil))
    (re-search-backward pattern nil nil (or count 1)))
  (goto-char (match-beginning 0)))

(defun face-at-cursor-p (face)
  (eq (face-at-point) face))

(provide 'test-helper)

;;; test-helper.el ends here
