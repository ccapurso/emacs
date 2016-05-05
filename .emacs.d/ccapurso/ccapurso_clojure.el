(defun ccapurso/add-midje-forms-to-clojure-dedenting ()
  (put-clojure-indent 'fact-group 1)
  (put-clojure-indent 'facts 1)
  (put-clojure-indent 'fact 1)
  (put-clojure-indent 'tabular nil)
  (put-clojure-indent 'for-all 1))

(eval-after-load 'clojure-mode
    '(add-hook 'clojure-mode-hook 'ccapurso/add-midje-forms-to-clojure-dedenting))
