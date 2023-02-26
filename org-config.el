;;; org-config.el -*- lexical-binding: t; -*-

;;; presonal org-mode configs
(defun org-mode-config ()
  "Org-mode."
  (setq org-extend-today-until 4
        org-use-effective-time t)
  (setq org-todo-keywords
        '((sequence "TODO(t)"
                    "IN-PROGRESS(p)"
                    "|"
                    "DONE(d)"
                    "HOLD(h@/!)"
                    "CANCELED(c@/!)"
                    "HANDLED(l@/!)")
          (sequence "|" "PAUSE(p)" "CHAT(c)" "EMAIL(e)" "MEETING(m)" "REVIEW(r)" "GEEK(g)")))

  ;;; Look & Feel

  ;; I like to have something different than ellipsis because I often use them
  ;; myself.
  (setq org-ellipsis " [+]")
  (custom-set-faces '(org-ellipsis ((t (:foreground "gray40" :underline nil)))))

  (defun my-org-settings ()
    (org-display-inline-images)
    (setq fill-column 75)
    (abbrev-mode)
    (org-indent-mode)
    nil)

  (add-hook 'org-mode-hook #'my-org-settings)

  (setq org-tags-column 69)

  ;; src block indentation / editing / syntax highlighting
  (setq org-src-fontify-natively t
        org-src-window-setup 'current-window ;; edit in current window
        org-src-preserve-indentation t ;; do not put two spaces on the left
        org-src-tab-acts-natively t)

  ;; *** Templates
  ;; the %a refer to the place you are in emacs when you make the capture
  ;; that's very neat when you do that in an email for example.
  (setq org-capture-templates
        '(("t" "todo"         entry (file "~/.org/inbox.org")
           "* TODO %?\n%U\n- ref :: %a\n")
          ;; time tracker (clocked tasks)
          ("g" "geek"         entry (file+olp+datetree "~/.org/tracker.org")
           "* GEEK %?         :perso:\n%U\n- ref :: %a\n"
           :prepend t :tree-type week :clock-in t :clock-keep t)
          ("c" "chat"         entry (file+olp+datetree "~/.org/tracker.org")
           "* CHAT %?         :work:chat:\n%U\n- ref :: %a\n"
           :prepend t :tree-type week :clock-in t :clock-keep t)
          ("e" "email"        entry (file+olp+datetree "~/.org/tracker.org")
           "* EMAIL %?        :work:email:\n%U\n- ref :: %a\n"
           :prepend t :tree-type week :clock-in t :clock-keep t)
          ("m" "meeting"      entry (file+olp+datetree "~/.org/tracker.org")
           "* MEETING %?      :work:meeting:\n%U\n- ref :: %a\n"
           :prepend t :tree-type week :clock-in t :clock-keep t)
          ("r" "review"       entry (file+olp+datetree "~/.org/tracker.org")
           "* REVIEW %?       :work:review:\n%U\n- ref :: %a\n"
           :prepend t :tree-type week :clock-in t :clock-keep t)
          ("w" "work"         entry (file+olp+datetree "~/.org/tracker.org")
           "* IN-PROGRESS %?  :work:\n%U\n- ref :: %a\n"
           :prepend t :tree-type week :clock-in t :clock-keep t)
          ("p" "pause"        entry (file+olp+datetree "~/.org/tracker.org")
           "* PAUSE %?        :pause:\n%U\n- ref :: %a\n"
           :prepend t :tree-type week :clock-in t :clock-keep t)
          ("i" "interruption" entry (file+olp+datetree "~/.org/tracker.org")
           "* IN-PROGRESS %?  :interruption:work:\n%U\n- ref :: %a\n"
           :prepend t :tree-type week :clock-in t :clock-keep t)
          ("f" "chore"        entry (file "~/.org/inbox.org")
           "* IN-PROGRESS %?  :chore:\n%U\n"
           :clock-in t :clock-keep t)))

  ;; How to create default clocktable
  (setq org-clock-clocktable-default-properties
        '(:scope subtree :maxlevel 4 :timestamp t :link t :tags t :narrow 36! :match "work"))

  ;; How to display default clock report in agenda view
  (setq org-agenda-clockreport-parameter-plist
        '(:lang "en" :maxlevel 4 :fileskip0 t :link t :indent t :narrow 80!))

  ;; *** Projectile; default TODO file to create in your projects
  (setq org-projectile-file "inbox.org")

  ;; *** Refile mapped to SPC y o r
  (map! :leader :desc "org-refile" "y o r" #'org-refile)

  ;; Refile to either the =refile.org= file or to =agenda.org= org =standup.org=
  (setq org-refile-target-files
        '("~/.org/tracker.org"
          "~/.org/inbox.org"))

  (setq org-refile-targets
        '((nil :maxlevel . 5)
          (org-refile-target-files :maxlevel . 5)))

  ;; *** Agenda
  (setq org-log-into-drawer t) ;; hide the log state change history a bit better
  (setq org-agenda-files org-refile-target-files)
  (setq org-deadline-warning-days 7)
  (setq org-agenda-skip-scheduled-if-deadline-is-shown t)
  (setq org-habit-show-habits-only-for-today nil)
  (setq org-habit-graph-column 65)
  (setq org-duration-format 'h:mm) ;; show hours at max, not days
  (setq org-agenda-compact-blocks t)
  ;; default show today
  (setq org-agenda-span 'day)
  (setq org-agenda-start-day "-0d")
  (setq org-agenda-start-on-weekday nil)
  (setq org-agenda-custom-commands
        '(("d" "Done tasks" tags "/DONE|CANCELED")
          ("g" "Plan Today"
           ((agenda "" ((org-agenda-span 'day)))
            (org-agenda-skip-function '(org-agenda-skip-deadline-if-not-today))
            (org-agenda-entry-types '(:deadline))
            (org-agenda-overriding-header "Today's Deadlines ")))))
  (setq org-agenda-window-setup 'only-window)

  (defun y/go-to-today-agenda ()
    (interactive)
    (org-agenda nil "a"))
  ;; Faster jump to agenda today keybinding shortcut (SPC y a)
  (map! :leader
        :desc "Today's agenda"
        "y a" #'y/go-to-today-agenda)

  ;; ** Org Annotate

  ;; Ability to take annotate some files, can of double usage with org-capture.
  ;; Still, I keep that keyboard shortcut here.
  ;; (evil-leader/set-key "oa" 'org-annotate-file)
  (setq org-annotate-file-storage-file "~/.org/annotations.org")


  ;; ** Org colums
  ;; Can be nice sometime to have that column view
  ;; give a felling of Excel view
  (setq org-columns-default-format
        "%TODO %3PRIORITY %40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM %8TAGS(TAG)")
  (map! :leader "y o c" #'org-columns)

  ;; ** Deft
  ;; useful to find files and jump to them
  (setq deft-extensions '("org" "gpg" "md" "txt"))
  (setq deft-recursive t)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-default-extension "org")
  (setq deft-directory "~/.org")


  ;; Org Babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(;; other Babel languages
     (shell . t)
     (http . t)
     (clojure . t)
     (haskell . t)
     (plantuml . t) ;; UML graphs
     (gnuplot . t)))
  (setq org-plantuml-jar-path "~/bin/plantuml.jar"))

(use-package! org
  :config (org-mode-config))


;;; Config org super agenda
(use-package! org-super-agenda
  :after org-agenda
  :custom (org-super-agenda-groups
           '( ;; Each group has an implicit boolean OR operator between its selectors.
             (:name "Overdue" :deadline past :order 0)
             (:name "Evening Habits" :and (:habit t :tag "evening") :order 8)
             (:name "Habits" :habit t :order 6)
             (:name "Today" ;; Optionally specify section name
              :time-grid t  ;; Items that appear on the time grid (scheduled/deadline with time)
              :order 3)     ;; capture the today first but show it in order 3
             (:name "Low Priority" :priority "C" :tag "maybe" :order 7)
             (:name "Due Today" :deadline today :order 1)
             (:name "Important"
              :and (:priority "A" :not (:todo ("DONE" "CANCELED")))
              :order 2)
             (:name "Due Soon" :deadline future :order 4)
             (:name "Todo" :not (:habit t) :order 5)
             (:name "Waiting" :todo ("WAITING" "HOLD") :order 9)))
  :config
  (setq org-super-agenda-header-map nil)
  (org-super-agenda-mode t))
