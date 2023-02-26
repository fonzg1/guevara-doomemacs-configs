;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Alfonso Guevara"
      user-mail-address "guevaraa01@gmail.com")

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
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 12))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)
;;(setq doom-theme 'doom-one)

;;(custom-set-faces!        'doom-tokyo-night
;;  '(doom-dashboard-banner :foreground "" :background "#" :weight )
;;  '(doom-dashboard-footer :inherit font-lock-constant-face)
;;  '(doom-dashboard-footer-icon :inherit )
;;  '(doom-dashboard-loaded :inherit font-lock-warning-face)
;;  '(doom-dashboard-menu-desc :inherit font-lock-string-face)
;;  '(doom-dashboard-menu-title :inherit font-lock-function-name-face))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  (setq org-directory "~/Documents/Org")
  (setq org-journal-dir "~/Documents/Org/OrgJournal")
  (setq org-roam-directory "~/Documents/Org/OrgRoam")
  (setq org-agenda-files '("~/Documents/Org/Agenda.org"))

  ;;(setq org-log-done 'time)
  (setq org-log-done 'note)

  (setq
        org-noter-notes-search-path '("~/Documents/Org/Org-Notes")
        org-noter-separate-notes-from-heading t
        org-noter-always-create-frame nil)
  ;; Set date and time prefix, and date and file format (with .org extension) to (day of week) MM/DD/YY.
  (setq org-journal-date-prefix "#+TITLE: "
        org-journal-time-prefix "* "
        org-journal-date-format "%a, %m-%d-%Y"
        org-journal-file-format "%m-%d-%Y.org")

  ;;; org-capture modifications

  ;;  Frist and formost Clear Doom's default templates
  (setq org-capture-templates '())

  ;; (defun +doct-icon-declaration-to-icon (declaration)
  ;;   "Convert :icon declaration to icon"
  ;;   (let ((name (pop declaration))
  ;;         (set  (intern (concat "all-the-icons-" (plist-get declaration :set))))
  ;;         (face (intern (concat "all-the-icons-" (plist-get declaration :color))))
  ;;         (v-adjust (or (plist-get declaration :v-adjust) 0.01)))
  ;;     (apply set `(,name :face ,face :v-adjust ,v-adjust))))

  ;; (defun +doct-iconify-capture-templates (groups)
  ;;   "Add declaration's :icon to each template group in GROUPS."
  ;;   (let ((templates (doct-flatten-lists-in groups)))
  ;;     (setq doct-templates (mapcar (lambda (template)
  ;;                                    (when-let* ((props (nthcdr (if (= (length template) 4) 2 5) template))
  ;;                                                (spec (plist-get (plist-get props :doct) :icon)))
  ;;                                      (setf (nth 1 template) (concat (+doct-icon-declaration-to-icon spec)
  ;;                                                                     "\t"
  ;;                                                                     (nth 1 template))))
  ;;                                    template)
  ;;                                  templates))))

  ;; (setq doct-after-conversion-functions '(+doct-iconify-capture-templates))

  ;; ;; (defvar +org-capture-recipies  "~/Desktop/TEC/Organisation/recipies.org")

  ;; (defun set-org-capture-templates ()
  ;;   (setq org-capture-templates
  ;;         (doct `(("Personal todo" :keys "t"
  ;;                  :icon ("checklist" :set "octicon" :color "green")
  ;;                  :file +org-capture-todo-file
  ;;                  :prepend t
  ;;                  :headline "Inbox"
  ;;                  :type entry
  ;;                  :template ("* TODO %?"
  ;;                             "%i %a"))
  ;;                 ("Personal note" :keys "n"
  ;;                  :icon ("sticky-note-o" :set "faicon" :color "green")
  ;;                  :file +org-capture-todo-file
  ;;                  :prepend t
  ;;                  :headline "Inbox"
  ;;                  :type entry
  ;;                  :template ("* %?"
  ;;                             "%i %a"))
  ;;                 ("Email" :keys "e"
  ;;                  :icon ("envelope" :set "faicon" :color "blue")
  ;;                  :file +org-capture-todo-file
  ;;                  :prepend t
  ;;                  :headline "Inbox"
  ;;                  :type entry
  ;;                  :template ("* TODO %^{type|reply to|contact} %\\3 %? :email:"
  ;;                             "Send an email %^{urgancy|soon|ASAP|anon|at some point|eventually} to %^{recipiant}"
  ;;                             "about %^{topic}"
  ;;                             "%U %i %a"))
  ;;                 ("Interesting" :keys "i"
  ;;                  :icon ("eye" :set "faicon" :color "lcyan")
  ;;                  :file +org-capture-todo-file
  ;;                  :prepend t
  ;;                  :headline "Interesting"
  ;;                  :type entry
  ;;                  :template ("* [ ] %{desc}%? :%{i-type}:"
  ;;                             "%i %a")
  ;;                  :children (("Webpage" :keys "w"
  ;;                              :icon ("globe" :set "faicon" :color "green")
  ;;                              :desc "%(org-cliplink-capture) "
  ;;                              :i-type "read:web")
  ;;                             ("Article" :keys "a"
  ;;                              :icon ("file-text" :set "octicon" :color "yellow")
  ;;                              :desc ""
  ;;                              :i-type "read:reaserch")
  ;;                             ("\tRecipie" :keys "r"
  ;;                              :icon ("spoon" :set "faicon" :color "dorange")
  ;;                              :file +org-capture-recipies
  ;;                              :headline "Unsorted"
  ;;                              :template "%(org-chef-get-recipe-from-url)")
  ;;                             ("Information" :keys "i"
  ;;                              :icon ("info-circle" :set "faicon" :color "blue")
  ;;                              :desc ""
  ;;                              :i-type "read:info")
  ;;                             ("Idea" :keys "I"
  ;;                              :icon ("bubble_chart" :set "material" :color "silver")
  ;;                              :desc ""
  ;;                              :i-type "idea")))
  ;;                 ("Tasks" :keys "k"
  ;;                  :icon ("inbox" :set "octicon" :color "yellow")
  ;;                  :file +org-capture-todo-file
  ;;                  :prepend t
  ;;                  :headline "Tasks"
  ;;                  :type entry
  ;;                  :template ("* TODO %? %^G%{extra}"
  ;;                             "%i %a")
  ;;                  :children (("General Task" :keys "k"
  ;;                              :icon ("inbox" :set "octicon" :color "yellow")
  ;;                              :extra "")
  ;;                             ("Task with deadline" :keys "d"
  ;;                              :icon ("timer" :set "material" :color "orange" :v-adjust -0.1)
  ;;                              :extra "\nDEADLINE: %^{Deadline:}t")
  ;;                             ("Scheduled Task" :keys "s"
  ;;                              :icon ("calendar" :set "octicon" :color "orange")
  ;;                              :extra "\nSCHEDULED: %^{Start time:}t")))
  ;;                 ("Project" :keys "p"
  ;;                  :icon ("repo" :set "octicon" :color "silver")
  ;;                  :prepend t
  ;;                  :type entry
  ;;                  :headline "Inbox"
  ;;                  :template ("* %{time-or-todo} %?"
  ;;                             "%i"
  ;;                             "%a")
  ;;                  :file ""
  ;;                  :custom (:time-or-todo "")
  ;;                  :children (("Project-local todo" :keys "t"
  ;;                              :icon ("checklist" :set "octicon" :color "green")
  ;;                              :time-or-todo "TODO"
  ;;                              :file +org-capture-project-todo-file)
  ;;                             ("Project-local note" :keys "n"
  ;;                              :icon ("sticky-note" :set "faicon" :color "yellow")
  ;;                              :time-or-todo "%U"
  ;;                              :file +org-capture-project-notes-file)
  ;;                             ("Project-local changelog" :keys "c"
  ;;                              :icon ("list" :set "faicon" :color "blue")
  ;;                              :time-or-todo "%U"
  ;;                              :heading "Unreleased"
  ;;                              :file +org-capture-project-changelog-file)))
  ;;                 ("\tCentralised project templates"
  ;;                  :keys "o"
  ;;                  :type entry
  ;;                  :prepend t
  ;;                  :template ("* %{time-or-todo} %?"
  ;;                             "%i"
  ;;                             "%a")
  ;;                  :children (("Project todo"
  ;;                              :keys "t"
  ;;                              :prepend nil
  ;;                              :time-or-todo "TODO"
  ;;                              :heading "Tasks"
  ;;                              :file +org-capture-central-project-todo-file)
  ;;                             ("Project note"
  ;;                              :keys "n"
  ;;                              :time-or-todo "%U"
  ;;                              :heading "Notes"
  ;;                              :file +org-capture-central-project-notes-file)
  ;;                             ("Project changelog"
  ;;                              :keys "c"
  ;;                              :time-or-todo "%U"
  ;;                              :heading "Unreleased"
  ;;                              :file +org-capture-central-project-changelog-file)))))))

  ;; (set-org-capture-templates)
  ;; (unless (display-graphic-p)
  ;;   (add-hook 'server-after-make-frame-hook
  ;;             (defun org-capture-reinitialise-hook ()
  ;;               (when (display-graphic-p)
  ;;                 (set-org-capture-templates)
  ;;                 (remove-hook 'server-after-make-frame-hook
  ;;                              #'org-capture-reinitialise-hook)))))
  ) ;; endof org configurations

;;;; org-roam-ui
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-fellow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
;;;; endof org-roam-ui configs

(after! deft
  ;; specify where is the notes directory
  (setq deft-directory "~/Documents/Org/Org-Notes"))

;; (use-package! org-super-agenda
;;   :after org-agenda
;;   :custom (org-super-agenda-groups
;;            '( ;; Each group has an implicit boolean OR operator between its selectors.
;;              (:name "Overdue" :deadline past :order 0)
;;              (:name "Evening Habits" :and (:habit t :tag "evening") :order 8)
;;              (:name "Habits" :habit t :order 6)
;;              (:name "Today" ;; Optionally specify section name
;;               :time-grid t  ;; Items that appear on the time grid (scheduled/deadline with time)
;;               :order 3)     ;; capture the today first but show it in order 3
;;              (:name "Low Priority" :priority "C" :tag "maybe" :order 7)
;;              (:name "Due Today" :deadline today :order 1)
;;              (:name "Important"
;;               :and (:priority "A" :not (:todo ("DONE" "CANCELED")))
;;               :order 2)
;;              (:name "Due Soon" :deadline future :order 4)
;;              (:name "Todo" :not (:habit t) :order 5)
;;              (:name "Waiting" :todo ("WAITING" "HOLD") :order 9)))
;;   :config
;;   (setq org-super-agenda-header-map nil)
;;   (org-super-agenda-mode t))

(setq
      org-agenda-time-grid '((daily today require-timed) "----------------------" nil)
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-include-diary t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-with-log-mode t)

(setq org-agenda-custom-commands
      '(("z" "Super zaen view"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :date today
                                :todo "TODAY"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :todo "NEXT"
                                 :order 1)
                          (:name "Important"
                                 :tag "Important"
                                 :priority "A"
                                 :order 6)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :order 7)
                          (:name "Assignments"
                                 :tag "Assignment"
                                 :order 10)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "Emacs"
                                 :tag "Emacs"
                                 :order 13)
                          (:name "Research"
                                 :tag "Research"
                                 :order 15)
                          (:name "To read"
                                 :tag "Read"
                                 :order 30)
                          (:name "Waiting"
                                 :todo "WAITING"
                                 :order 20)
                          (:name "trivial"
                                 :priority<= "C"
                                 :tag ("Trivial" "Unimportant")
                                 :todo ("SOMEDAY" )
                                 :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))))

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
(setq undo-limit 80000000       ; Raise undo-limit to 80MB
      evil-want-fine-undo t     ; By default while insert all
      auto-save-default t       ; enable auto save
      )

(display-time-mode 1)           ; Display time in the mode-line

(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"       #'evil-window-left
      "<down>"       #'evil-window-down
      "<up>"         #'evil-window-up
      "<right>"      #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right
      )

(setq menu-bar-mode 1)
;; vterm settings
(setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes")


;; Doom Snippets configs
;;(after! snippets
;;  (setq doom-snippets-dir "~/.config/doom/snippets/"))

;; lsp-mode configs
(after! lsp-mode
  (setq lsp-idle-delay 0.500
        lsp-log-io 'nil
        gc-cons-threshold (* 1024 1024 100))
  )

(after! lsp-clangd
  (setq lsp-clients-clangd-args
        ("-j=4"
         "--background-index"
         "--clang-tidy"
         "--completion-style=detailed"
         "--header-insertion=never"
         "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 1))

;; Completion Engines configurations
;; Company Configs:
;;
;; Reduce prefix length to 2
(after! company
  (setq +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet))
  (setq company-minimum-prefix-length 2)
  (setq company-show-quick-access t)
  (setq company-idle-delay 0.5)
)
;;; Add tabnine as a company backend
(use-package! company-tabnine
  :when (featurep! :completion company)
  :config
  (setq company-tabnine-binaries-folder "/usr/bin")
  (setq company-tabnine--disable-next-transform nil)
  (defun my-company--transform-candidates (func &rest args)
    (if (not company-tabnine--disable-next-transform)
        (apply func args)
      (setq company-tabnine--disable-next-transform nil)
      (car args)))

  (defun my-company-tabnine (func &rest args)
    (when (eq (car args) 'candidates)
      (setq company-tabine--disable-next-transform t))
    (apply func args))

  (advice-add #'company--transform-candidates :around #'my-company--transform-candidates)
  (advice-add #'company-tabnine :around #'my-company-tabnine)

  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (setq company-show-quick-access t)

  ;; Use the tab-and-go frontend.
  ;; Allows TAB to select and complete at the same time.
  (company-tng-configure-default)
  (setq company-frontends
        '(company-tng-frontend
          company-pseudo-tooltip-frontend
          company-echo-metadata-frontend))
  )
(add-to-list 'company-backends #'company-tabnine)

;;;; Spell Checking Configurations
;;; Flyspell Configs
(after! flyspell
  ;; Sets how many idle seconds until spellchecking.
  (setq flyspell-lazy-idle-seconds 2)

  ;; To Reduce False positives disable spelling on certain faces

  ;; Flyspell series of predicate functions to determine if a word should be spell checked.
  (set-flyspell-predicate! '(markdown-mode gfm-mode)
    #'+markdown-flyspell-word-p)

  ;; Flyspell predicates take no arguments and must return a boolean to determine if
  ;; the word at point should be spell checked
  (defun +markdown-flyspell-word-p ()
    "Return t if point is on a word that should be spell checked.

  Return nil if on a link url, markup, html, or references."
    (let ((faces (doom-enlist (get-text-property (point) 'face))))
      (or (and (memq 'font-lock-comment-face faces)
               (memq 'markdown-code-face faces))
          (not (cl-loop with unsafe-faces = '(markdown-reference-face
                                              markdown-url-face
                                              markdown-markup-face
                                              markdown-comment-face
                                              markdown-html-attr-name-face
                                              markdown-html-attr-value-face
                                              markdown-html-tag-name-face
                                              markdown-code-face)
                        for face in faces
                        if (memq face unsafe-faces)
                        return t)))))
  )

;;;; eglot
;;(add-to-list 'eglot-server-programs
;;             '(python-mode "kitelsp"))

;;;; Org Mode

;;;; ui/tabs
(after! centaur-tabs
  (setq centaur-tabs-bar 'right
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-modified-marker t ))
;;       centaur-tabs-close-button ""
;;       centaur-tabs-modified-marker ""))

;;; Programming Languages Configurations
;;;; Arduino Configs
(use-package! arduino-cli-mode
  :ensure t
  :hook (arduino-mode . arduino-cli-mode)
  :mode "\\.ino\\'"
  :custom
  (arduino-cli--warnings 'all)
  (arduino-cli--verify 't))
;; auto enable on ".ino" files
(add-to-list 'auto-minor-mode-alist '("\\.ino\\'". arduino-cli-mode))

;;;; C/C++
;;;;
;;;; Golang
;;;;
;;;; Python
(setq conda-env-home-directory (expand-file-name "~/.conda/"))
(custom-set-variables '(conda-anaconda-home "/opt/anaconda/"))
(add-hook 'python-mode-hook 'anaconda-mode) ;; enables anaconda-mode in all python buffers
(add-hook 'python-mode-hook 'anaconda-eldoc-mode) ;;


;;;; JavaScript
;;;;

;; Configs for LaTeX
;; Set LaTeX viewer
(setq +latex-viewers '(okular))

;;; Lammps plugin
(after! lammps-mode
  (setq auto-mode-alist (append
                         '(("in\\.'" . lammps-mode))
                         '(("\\.lmp\\'" . lammps-mode))
                         auto-mode-alist
                         ))
  )
