(defun get-active-minor-mode-list ()
  (let ((active-modes))
    (mapc (lambda (mode) (condition-case nil
                         (if (and (symbolp mode) (symbol-value mode))
                             (add-to-list 'active-modes mode))
                       (error nil)))
          minor-mode-list)
    active-modes))

(defun cider-set-ns-and-eval-buffer ()
  (when (member 'cider-mode (get-active-minor-mode-list))
    (cider-repl-set-ns (cider-current-ns))
    (if (not (equal "project.clj" (file-name-nondirectory buffer-file-name)))
        (cider-load-current-buffer))))

(add-hook 'after-save-hook 'cider-set-ns-and-eval-buffer)
(add-hook 'window-configuration-change-hook 'cider-set-ns-and-eval-buffer) 
