(connection-local-set-profile-variables
 'remote-pyenv
 '((tramp-remote-path . ("/home/remote/.pyenv/shims"
                         "/home/remote/.pyenv/bin"
                         tramp-own-remote-path
                         tramp-default-remote-path))))

(connection-local-set-profiles
 '(:machine "192.168.1.215") 'remote-pyenv)
(provide 'tramp-paths)
