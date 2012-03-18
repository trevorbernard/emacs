;;; less-css-mode.el --- Major mode for editing LESS CSS

;; Copyright (C) 2012
;; Mahmoud Hashemi, JD Huntington

;; MIT License

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;; THE SOFTWARE.

(defgroup less-css nil
  "Highlight and indent LESS CSS."
  :prefix "less-css-"
  :link '(url-link :tag "Github for LESS CSS major mode"
		   "https://github.com/makuro/less-css-mode")
  :group 'languages)

(defcustom less-css-indent-level 2 
  "Number of spaces to indent inside a block."
  :group 'less-css
  :type 'integer
  :safe 'integerp)

(defvar less-css-mode-hook nil)

(defvar less-css-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for LESS CSS major mode")

(defvar less-css-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?- "w" st)
    (modify-syntax-entry ?/ ". 14" st)
    (modify-syntax-entry ?* ". 23" st)

    st)
  "Syntax table for less-css-mode")

(defconst less-css-font-lock-keywords-1
  (list
   ;; Selectors
   (list "^[ \t]*\\([^\n;:{}()]*\\){?$" 1 font-lock-keyword-face)
   
   ;; Properties
   (list "\\(\\w+\\)[ \t]*:" 1 font-lock-variable-name-face)

   ;; URLs
   (list ":.*url(\\([^)]*\\))" 1 font-lock-string-face)

   ;; Colors
   (list ":.*\\(#\\w+\\)" 1 font-lock-type-face)

   ;; Mixins
   (list "^[ \t]*\\(\\.\\w+\\)(?[^);\n]*)?;$" 1 font-lock-constant-face)
   (list "^[ \t]*\\.\\w+(?\\([^);\n]*\\))?;$" 1 font-lock-variable-name-face)
   ))

(defconst less-css-font-lock-keywords-2 less-css-font-lock-keywords-1)
(defconst less-css-font-lock-keywords-3 less-css-font-lock-keywords-1)
(defconst less-css-font-lock-keywords
  '(less-css-font-lock-keywords-3 less-css-font-lock-keywords-1 less-css-font-lock-keywords-2
                                  less-css-font-lock-keywords-3)
  "See `font-lock-keywords'.")

(defun less-css-indent-line ()
  "Indent current line of Less CSS."
  (interactive)
  (let ((savep (> (current-column) (current-indentation)))
        (indent (condition-case nil (* less-css-indent-level (max (less-css-calculate-indentation) 0))
                  (error 0))))
    (if savep
        (save-excursion (indent-line-to indent))
      (indent-line-to indent))))

(defun less-css-calculate-indentation ()
  "Return the column to which the current line should be indented."
  ;; Closing brackets now properly indent, provided you put them on their
  ;; own line, which is pretty much the standard.
  (save-excursion
    (end-of-line)
    (let ( (indent-level 0) (endpoint (point)) (indent-next nil) )
      (goto-char (point-min))
      (while (< (point) endpoint)
        (forward-char)
        (cond ((looking-at "{") (setq indent-next t) )
	      ((and (= (point) (line-beginning-position)) indent-next) 
	       (setq indent-level (+ 1 indent-level))
	       (setq indent-next nil))
              ((looking-at "}") (setq indent-level (- indent-level 1)))))
      indent-level)))

(defun less-css-mode ()
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table less-css-mode-syntax-table)
  (use-local-map less-css-mode-map)
  (set (make-local-variable 'font-lock-defaults) (list less-css-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'less-css-indent-line)
  (setq major-mode 'less-mode)
  (setq mode-name "Less (CSS)")
  (run-hooks 'less-css-mode-hook))

(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

(provide 'less-mode)
