;; emacs.el --- fichier de configuration d'Emacs

;;; Commentary:
;; Fichier de configuration d'Emacs (Editeur de texte)
;; Le fichier doit s'appeler ~/.emacs ou ~/.emacs.el
;; Ensimag 2016.

;; Auteur : Matthieu Moy <Matthieu.Moy@imag.fr> et l'équipe du Stage
;; Unix de rentrée.

(setq tab-width 4)

;; Ceci est le fichier de configuration d'Emacs. Il est écrit dans un
;; langage appelé Emacs-lisp, mais rassurez-vous, vous n'avez pas
;; besoin de le connaitre pour changer votre configuration.
;;
;; Tout ce qui est précédé par un point-virgule est un commentaire.

;;; Code:

;; Nécessaire pour pouvoir configurer les packages additionnels
(require 'package)
;; Décommenter pour ajouter l'archive melpa à la liste des packages
;; disponibles :
;(add-to-list 'package-archives
;             '("melpa" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; Vérifications en cours de frappe.
;; Si besoin, installer flycheck : http://www.flycheck.org/
(when (functionp 'global-flycheck-mode)
  (global-flycheck-mode 1)
  (push 'python-pylint flycheck-checkers)
  )

;; Correspondance des parenthèses :
;; Avec ceci, positionnez le curseur sur une parenthèse ouvrante ou
;; une parenthèse fermante, Emacs met en couleur la paire de
;; parenthèses.
(show-paren-mode 1)

;; Afficher les numéros de lignes dans la mode-line (barre du bas de
;; fenêtre) :
(line-number-mode t)
(global-linum-mode 1)
(column-number-mode t)

;; Faire clignoter l'écran au lieu de faire « beep ». Sympa en salle
;; machine !
(setq visible-bell t)

;; Pour les curieux ...

;; La suite de ce fichier ne contient que des commentaires ! Ce sont
;; des suggestions pour vous constituer votre .emacs.el. Décommentez
;; les lignes de configuration (i.e. supprimer les ";") puis relancez
;; Emacs pour les activer.

;; Ne pas afficher le message d'accueil
;(setq inhibit-splash-screen t)

;; Visionner la région (aka sélection) courante :
;(transient-mark-mode t)

;; Des raccourcis claviers et une selection comme sous Windows
;; (C-c/C-x/C-v pour copier coller, ...)
;(cua-mode 1)
;; Sauver avec Control-s :
;(global-set-key [(C s)] 'save-buffer)

;; Correction orthographique :
;(ispell-change-dictionary "francais")
;; Souligner les mots incorrects en mode LaTeX
;(add-hook 'latex-mode-hook 'flyspell-mode)

;; Se limiter à des lignes de 80 caractères dans les modes textes (y
;; compris le mode LaTeX) :
;; cf. http://www-verimag.imag.fr/~moy/emacs/#autofill
;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Changer le comportement de la selection de fichiers (C-x C-f)
;(ido-mode 1)

;; Dans la même série : changer le comportement de la complétion.
;(icomplete-mode)

;; Pour une interface graphique un peu dépouillée
;(menu-bar-mode -1)
;(scroll-bar-mode -1)
;(tool-bar-mode -1)
;(blink-cursor-mode -1)

;; Définir des touches pour se déplacer rapidement :
;; Aller à la parenthèse ouvrante correspondante :
;(global-set-key [M-right] 'forward-sexp)
;; Aller à la parenthèse Fermante correspondante :
;(global-set-key [M-left] 'backward-sexp)

;; Pour utiliser emacsclient (man emacsclient)
;(server-start)

;; Compiler avec M-f9, recompiler (avec la même commande de
;; compilation) avec f9.
;(global-set-key [M-f9]   'compile)
;(global-set-key [f9]     'recompile)

;; Se souvenir des derniers fichiers ouverts
;(setq recentf-menu-path nil)
;(setq recentf-menu-title "Recentf")
;(recentf-mode 1)

;; Un menu pour naviguer entre les fonctions dans un fichier (Python,
;; Ada, C, ...). On l'ajoute pour tous les modes ayant de la
;; coloration syntaxique :
;(defun try-to-add-imenu ()
;  (condition-case nil (imenu-add-to-menubar "Navigation") (error nil)))
;(add-hook 'font-lock-mode-hook 'try-to-add-imenu)


;; et maintenant ?
;; Si vous avez lu jusqu'ici, vous aurez probablement envie d'aller
;; plus loin. Commencez-donc par la page EnsiWiki sur le .emacs :
;;   http://ensiwiki.ensimag.fr/index.php/Dot_Emacs

;; emacs.el ends here.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-default-style (quote ((c-mode . "user") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(custom-enabled-themes (quote (tango-dark)))
 '(delete-selection-mode t)
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


