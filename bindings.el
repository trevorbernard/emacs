;; Ignore minimize functionality
(global-set-key "\C-z" 'ignore)
(global-set-key "\C-x\C-z" 'ignore)

;; Allow M-x to be accessed by ctrl
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(provide 'bindings)