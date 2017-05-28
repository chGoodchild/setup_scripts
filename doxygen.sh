#!/bin/bash

# Doxygen is an emacs plugin that parses through the code, looks for
# comments and generates a documentation
# file. http://emacs-fu.blogspot.de/2009/01/commenting-your-functions.html
sudo apt-get -y install doxymacs

echo "(add-hook 'c-mode-common-hook" >> .emacs
echo "  (lambda ()" >> .emacs
echo "    (require 'doxymacs)" >> .emacs
echo "    (doxymacs-mode t)" >> .emacs
echo "    (doxymacs-font-lock)))" >> .emacs
