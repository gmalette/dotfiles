;; -*- mode: dotspacemacs -*-

(defun dotspacemacs/layers ()
  (setq
   dotspacemacs-configuration-layers
   `(auto-completion
     c-c++
     clojure
     colors
     elixir
     elm
     emacs-lisp
     git
     github
     javascript
     lua
     haskell
     html
     idris
     markdown
     purescript
     python
     (ruby :variables ruby-version-manager 'chruby)
     rust
     shell
     (syntax-checking :variables syntax-checking-enable-tooltips nil)
     vagrant
     version-control
     yaml)))

(defun dotspacemacs/user-init ()
  (menu-bar-mode -1)
  (setq-default require-final-newline t)
  (setq auto-completion-return-key-behavior nil
        auto-completion-tab-key-behavior 'complete
        enh-ruby-add-encoding-comment-on-save nil
        ruby-enable-enh-ruby-mode t))

(defun dotspacemacs/user-config ()
  (require 'chruby)
  (chruby "2.3")

  (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.mrb$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.es6$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
  (add-to-list 'auto-mode-alist '(".eslintrc" . json-mode)))
