;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "utfeight"
      user-mail-address "benimadimarda123123@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox) ;; doom-lantern

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-hide-emphasis-markers t) ;; Hide emphasis markers like /this/ or *this*

(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-edit-src-content-indentation 0) ;; Syntax highlighting in code blocks

(setq org-src-fontify-natively t) ;; Syntax highlighting in code blocks

;; This comment
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "c(CANCELLED@/!)"))))

;; Installed with M-x package-install RET org-bullets RET
;; Conflicts with org-superstar-mode (Disable org-superstar-mode to use org-bullets
;; (use-package org-bullets
;;   :ensure t
;;   :config

;;   (setq org-bullets-mode t)
;;   ;; Tbh It's pretty random now. But I can change it later
;;   ;; This does not work for some reason ?!?! It was working before?
;;   (setq org-bullets-bullet-list '("▶" "◉" "§" "Σ" "Ψ" "Ω" ;; "β" "δ" "ᗧ" "᠉" "⋑" "✸"
;;                                   )))

;;;;
;;; Titles and Sections
;; hide #+TITLE:
(with-eval-after-load 'org-faces
  (setq org-hidden-keywords '(title))
  ;; set basic title font
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
  ;; Low levels are unimportant => no scaling
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
  ;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.2) ;\large
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.44) ;\Large
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.728) ;\LARGE
  ;; Only use the first 4 styles and do not cycle.
  (setq org-cycle-level-faces nil)
  (setq org-n-level-faces 4)
  ;; Document Title, (\huge)
  (set-face-attribute 'org-document-title nil
                      :height 2.074
                      :foreground 'unspecified
                      :inherit 'org-level-8)

;;; Basic Setup
  ;; Auto-start Superstar with Org
  )

(with-eval-after-load 'org-superstar
  (set-face-attribute 'org-superstar-item nil :height 1.2)
  (set-face-attribute 'org-superstar-header-bullet nil :height 1.2)
  (set-face-attribute 'org-superstar-leading nil :height 1.3))
;; Set different bullets, with one getting a terminal fallback.
(setq org-superstar-headline-bullets-list '("▶" "λ" "§" "Σ" "Ψ" "Ω" "β" "δ" "ᗧ" "᠉" "⋑" "✸"))
;; Stop cycling bullets to emphasize hierarchy of headlines.
;; (setq org-superstar-cycle-headline-bullets nil)
;; Hide away leading stars on terminal.
;; (setq org-superstar-leading-fallback ?\s)

;;;;

(add-hook 'org-mode-hook 'hl-todo-mode)

(after! org
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode t) (global-hl-todo-mode t)))
  ;; TODO Create some kind of config that will do this:

  (setq org-hide-leading-stars t) ;; Added for troubleshooting NOTE
  (setq org-ellipsis "⤸") ;; ⤵ :arrow_down: ⤸ :arrow_up: ▾ :arrow_down_small: ▴
  )

(setq org-cycle-separator-lines -1) ;; Found on the internet it debugs ellipsis error (That I don't get cuz I can'T see anyhing)

(defun toggle-org-html-export-on-save ()
  (interactive)
  (if (memq 'org-html-export-to-html after-save-hook)
      (progn
        (remove-hook 'after-save-hook 'org-html-export-to-html t)
        (message "Disabled org html export on save for current buffer..."))
    (add-hook 'after-save-hook 'org-html-export-to-html nil t)
    (message "Enabled org html export on save for current buffer...")))

(defun toggle-org-markdown-export-on-save ()
  (interactive)
  (if (memq 'org-md-export-to-markdown after-save-hook)
      (progn
        (remove-hook 'after-save-hook 'org-md-export-to-markdown t)
        (message "Disabled org markdown export on save for current buffer..."))
    (add-hook 'after-save-hook 'org-md-export-to-markdown nil t)
    (message "Enabled org markdown export on save for current buffer...")))

(defun toggle-org-latex-export-on-save ()
  (interactive)
  (if (memq 'org-latex-export-to-latex after-save-hook)
      (progn
        (remove-hook 'after-save-hook 'org-pdftools-export t)
        (message "Disabled org latex export on save for current buffer..."))
    (add-hook 'after-save-hook 'org-pdftools-export nil t)
    (message "Enabled org latex export on save for current buffer...")))

(defun toggle-org-pdf-export-on-save ()
  (interactive)
  (if (memq 'org-latex-export-to-pdf after-save-hook)
      (progn
        (remove-hook 'after-save-hook 'org-pdftools-export t)
        (message "Disabled org pdf export on save for current buffer..."))
    (add-hook 'after-save-hook 'org-pdftools-export nil t)
    (message "Enabled org pdf export on save for current buffer...")))

;; Possibly considerable characters:
;; ⤵ ⤴ ⤶ ⤷ ⤸ ⤹ ⤺ ⤻ ⤼ ⤽ ⤾ ⤿ ⥀ ⥁ ⥂ ⥃ ⥄ ⥅ ⥆ ⥇ ⥈ ⥉ ⥊ ⥋ ⥌ ⥍ ⥎ ⥏ ⥐ ⥑ ⥒ ⥓ ⥔ ⥕ ⥖ ⥗ ⥘ ⥙ ⥚ ⥛ ⥜ ⥝ ⥞ ⥟ ⥠ ⥡ ⥢ ⥣ ⥤ ⥥ ⥦ ⥧ ⥨ ⥩ ⥪ ⥫ ⥬ ⥭ ⥮ ⥯ ⥰ ⥱ ⥲ ⥳ ⥴ ⥵ ⥶ ⥷ ⥸ ⥹ ⥺ ⥻ ⥼ ⥽ ⥾ ⥿ ⦀ ⦁ ⦂ ⦃ ⦄ ⦅ ⦆ ⦇ ⦈ ⦉ ⦊ ⦋ ⦌ ⦍ ⦎ ⦏ ⦐ ⦑ ⦒ ⦓ ⦔ ⦕ ⦖ ⦗ ⦘ ⦙ ⦚ ⦛ ⦜ ⦝ ⦞ ⦟ ⦠ ⦡ ⦢ ⦣ ⦤ ⦥ ⦦ ⦧ ⦨ ⦩ ⦪ ⦫ ⦬ ⦭ ⦮ ⦯ ⦰ ⦱ ⦲ ⦳ ⦴ ⦵ ⦶ ⦷ ⦸ ⦹ ⦺ ⦻ ⦼ ⦽ ⦾ ⦿ ⧀ ⧁ ⧂ ⧃ ⧄ ⧅ ⧆ ⧇ ⧈ ⧉ ⧊ ⧋ ⧌ ⧍ ⧎ ⧏ ⧐ ⧑ ⧒ ⧓ ⧔ ⧕ ⧖ ⧗ ⧘ ⧙ ⧚
;; Thanks Copilot!


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Neotree keybind
;;;; Old
;;; (global-set-key (kbd "C-c C-c") 'neotree)

(map! :leader
      "z" #'neotree)

;; autocompletion up speed

(setq company-dabbrev-downcase t) ;; case sensitive by Copilot
(setq company-idle-delay 0)

;; this makes autocompletion instant which is kinda annoying (Becuase everything you try to write is autocompleted with a huge popup)
;; (setq company-minimum-prefix-length 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
;;; (setq company-show-numbers t)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (
         ;; accept one word completion: FIXME
         ;; THESE ANNOYING BRUH!!!
         ;; ("C-TAB" . 'copilot-accept-completion-by-word)
         ;; ("C-<tab>" . 'copilot-accept-completion-by-word)

         ;; change the suggestion:
         ("C-<right>" . 'copilot-next-completion)
         ("C-<left>" . 'copilot-previous-completion)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

;; Set zsh as default shell with zsh function (:zsh)
(defun zsh ()
  (interactive)
  (term "/bin/zsh"))

;; ;; Setting up ChatGPT
;; (use-package! chatgpt
;;   :defer t
;;   :config
;;   (unless (boundp 'python-interpreter)
;;     (defvaralias 'python-interpreter 'python-shell-interpreter))
;;   (setq chatgpt-repo-path (expand-file-name "straight/repos/ChatGPT.el/" doom-local-dir))
;;   (set-popup-rule! (regexp-quote "*ChatGPT*")
;;     :side 'bottom :size .5 :ttl nil :quit t :modeline nil)
;;   :bind ("C-c q" . chatgpt-query))


;; Setting up Music player


;; --------------------------- EMMS ---------------------------
;; Setting up emms with mpv
;; (setq emms-player-list '(emms-player-mpv))
;; Default directory for emms
;; (setq emms-source-file-default-directory "~/Music/")
;; ------------------------------------------------------------

;; --------------------------- All utf-8 ----------------------------
;; I use my terminal pretty utf-8ified so I want emacs to be utf-8ified too
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)

;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; ;; Setting up emms (Music player)
;; ;; (setq emms-volume-change-function 'emms-volume-alsa-control)
;; (defvar emms-player-mpv-volume 100)

;; (defun emms-player-mpv-get-volume ()
;;   "Sets `emms-player-mpv-volume' to the current volume value
;; and sends a message of the current volume status."
;;   (emms-player-mpv-cmd '(get_property volume)
;;                        #'(lambda (vol err)
;;                            (unless err
;;                              (let ((vol (truncate vol)))
;;                                (setq emms-player-mpv-volume vol)
;;                                (message "Music volume: %s%%"
;;                                         vol))))))

;; (defun emms-player-mpv-raise-volume (&optional amount)
;;   (interactive)
;;   (let* ((amount (or amount 10))
;;          (new-volume (+ emms-player-mpv-volume amount)))
;;     (if (> new-volume 100)
;;         (emms-player-mpv-cmd '(set_property volume 100))
;;       (emms-player-mpv-cmd `(add volume ,amount))))
;;   (emms-player-mpv-get-volume))

;; (defun emms-player-mpv-lower-volume (&optional amount)
;;   (interactive)
;;   (emms-player-mpv-cmd `(add volume ,(- (or amount '10))))
;;   (emms-player-mpv-get-volume))

;; Setting up the font && weight
;; (setq doom-font (font-spec :family "Iosevka" :size 10.0 :weight 'Bold))
(setq doom-font (font-spec :family "JetBrainsMono" :size 10.0 :weight 'Medium))

;; Bindings:

;; for quickrun
(map! "C-M-<" #'quickrun ;; Runs the current buffer.
      "C-<" (lambda () (interactive) (windmove-down) (evil-quit)) ;; quits from the buffer below (generally quickrun buffer)
      )

;; SPLASH SCREEN
(setq fancy-splash-image "~/.config/doom/splash/multi-splash.png")

;; MINIMAP
(minimap-mode t)

;; SHUT-UP EMACS! When quiting
(setq confirm-kill-emacs nil)

;; ;; Browser flickering issue:
;; (use-package! webkit
;;   :config
;;   (modify-frame-parameters nil '((inhibit-double-buffering . t)))
;;   :bind ("C-c w" . webkit)
;;   )

;; ARROW KEYS
;; (map!
;;  :n "C-<right>" #'forward-word
;;  :n "C-<left>"  #'backward-word
;;  :i "C-<right>" #'+default/insert-space-after-cursor
;;  :i "C-<left>"  #'+default/delete-backward-word
;; )
(map!
 :map (insert visual command normal)
 "C-<right>" #'forward-word
 "C-<left>"  #'backward-word
 )
