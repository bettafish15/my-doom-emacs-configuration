;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "StormShadow"
      user-mail-address "bettafish15@gmail.com")

;;(setq fancy-splash-image "~/.doom.d/text.txt")
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(add-hook! '+doom-dashboard-functions :append (insert "\n" (+doom-dashboard--center +doom-dashboard--width "A Smooth Sea Never Made a Skilled Sailor")))

(defun custom-banner ()
  (let* ((banner
          '("   _____ _                       _____ _               _               "
	    "  /  ___| |                     /  ___| |             | |              "
	    "  \\ `--.| |_ ___  _ __ _ __ ___ \\ `--.| |__   __ _  __| | _____      __"
	    "   `--. \\ __/ _ \\| '__| '_ ` _ \\ `--. \\ '_ \\ / _` |/ _` |/ _ \\ \\ /\\ / /"
	    "  /\\__/ / || (_) | |  | | | | | /\\__/ / | | | (_| | (_| | (_) \\ V  V / "
	    "  \\\____/ \\\__\\\___/|_|  |_| |_| |_\\____/|_| |_|\\__,_|\\__,_|\\___/ \\_/\\_/  "
	    "									    "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(custom-set-faces!
  '(doom-dashboard-banner :weight normal)
  ;;'(doom-dashboard-footer :inherit font-lock-constant-face)
  ;;'(doom-dashboard-footer-icon :inherit all-the-icons-red)
  ;;'(doom-dashboard-loaded :inherit font-lock-warning-face)
  ;;'(doom-dashboard-menu-desc :inherit font-lock-string-face)
  ;;'(doom-dashboard-menu-title :inherit font-lock-function-name-face)
  )

(setq +doom-dashboard-ascii-banner-fn #'custom-banner)

;;(setq-hook! 'typescript-mode-hook +format-with-lsp nil)
;;
(server-start)

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
;;
(add-to-list 'default-frame-alist '(font . "Iosevka-14"))
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(setq doom-theme 'doom-tokyo-night
      doom-font (font-spec :family "Iosevka" :size 14)
      doom-unicode-font (font-spec :family "Iosevka" :size 12)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 16)
      doom-big-font (font-spec :family "Iosevka" :size 19)
      )

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; (setq doom-theme 'doom-dracula) ;; << This line enables the theme

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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
                                        ;
;;; Modules

;;; :completion company
;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
(after! company
  (setq company-idle-delay nil))


;;; :ui modeline
;; An evil mode indicator is redundant with cursor shape
(advice-add #'doom-modeline-segment--modals :override #'ignore)


;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;;; :tools lsp
;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; If an LSP server isn't present when I start a prog-mode buffer, you
        ;; don't need to tell me. I know. On some machines I don't care to have
        ;; a whole development environment for some ecosystems.
        lsp-enable-suggest-server-download nil))

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(defun my-dired-create-empty-file ()
  (interactive)
  (let* ((ts (format-time-string "%Y-%m-%dT%H.%M.%S" (current-time)))
         (fname (format "%s.org" ts)))
    (dired-create-empty-file fname)
    (find-file fname)))

(global-set-key [f6] 'my-dired-create-empty-file)

(after! lsp-ui
  (setq lsp-ui-sideline-diagnostic-max-lines 5))

(map! :after vterm
      :map vterm-mode-map
      "C-k" #'vterm-send-up
      "C-j" #'vterm-send-down)


(use-package! lsp-tailwindcss)
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; (when (daemonp)
;;   (exec-path-from-shell-initialize))

;; (exec-path-from-shell-copy-env "PATH")

;; cloudformation-mode

(define-derived-mode cfn-mode yaml-mode
  "Cloudformation"
  "Cloudformation template mode.")

(add-to-list 'auto-mode-alist '(".template\\'" . cfn-mode))
(after! flycheck
  (flycheck-define-checker cfn-lint
    "A Cloudformation linter using cfn-python-lint.

See URL 'https://github.com/awslabs/cfn-python-lint'."
    :command ("cfn-lint" "-f" "parseable" source)
    :error-patterns (
                     (warning line-start (file-name) ":" line ":" column
                              ":" (one-or-more digit) ":" (one-or-more digit) ":"
                              (id "W" (one-or-more digit)) ":" (message) line-end)
                     (error line-start (file-name) ":" line ":" column
                            ":" (one-or-more digit) ":" (one-or-more digit) ":"
                            (id "E" (one-or-more digit)) ":" (message) line-end)
                     )
    :modes (cfn-mode)
    )
  (add-to-list 'flycheck-checkers 'cfn-lint)
  )

(setq lsp-clients-angular-language-server-command
      '("node"
        "/usr/lib/node_modules/@angular/language-server"
        "--ngProbeLocations"
        "/usr/lib/node_modules"
        "--tsProbeLocations"
        "/usr/lib/node_modules"
        "--stdio"))
