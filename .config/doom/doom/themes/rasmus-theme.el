;;; rasmus-theme.el --- Rasmus theme for Doom Emacs -*- lexical-binding: t; no-byte-compile: t; -*-

(require 'doom-themes)

(def-doom-theme rasmus
  "A dark theme based on the Rasmus colorscheme."

  ;; Palette: (name default 256 16)
  ((bg         '("#1a1a19" nil nil))
   (fg         '("#d1d1d1" nil nil))
   (bg-alt     '("#222221" nil nil))
   (fg-alt     '("#b6b6b5" nil nil))

   (base0      '("#1a1a19" "black"   "black"))
   (base1      '("#222221" "black"   "black"))
   (base2      '("#323231" "black"   "black"))
   (base3      '("#333332" "black"   "black"))
   (base4      '("#4c4c4b" "brightblack" "brightblack"))
   (base5      '("#b6b6b5" "brightwhite" "brightwhite"))
   (base6      '("#d1d1d1" "white"   "white"))
   (base7      '("#eaeaea" "white"   "white"))
   (base8      '("#ffffff" "white"  "white"))

   (grey       base4)
   (red        '("#ff968c" nil nil))
   (orange     '("#ffc591" nil nil))
   (green      '("#61957f" nil nil))
   (teal       '("#7bb099" nil nil))
   (yellow     '("#ffdeaa" nil nil))
   (blue       '("#8db4d4" nil nil))
   (dark-blue  '("#323231" nil nil))
   (magenta    '("#de9bc8" nil nil))
   (violet     '("#f7b4e1" nil nil))
   (cyan       '("#94c9b2" nil nil))
   (dark-cyan  '("#61957f" nil nil))

   ;; semantic mappings
   (highlight      blue)
   (vertical-bar   base2)
   (selection      '("#2a2a29" nil nil))
   (builtin        magenta)
   (comments       grey)
   (doc-comments   (doom-lighten grey 0.25))
   (constants      violet)
   (functions      blue)
   (keywords       red)
   (methods        blue)
   (operators      red)
   (type           yellow)
   (strings        green)
   (variables      fg)
   (numbers        orange)
   (region         '("#2a2a29" nil nil))
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; modeline specific
   (modeline-bg     base2)
   (modeline-bg-alt base1)
   (modeline-fg     fg)
   (modeline-fg-alt fg-alt))

  ;; Face overrides
  ((line-number :foreground base4)
   (line-number-current-line :foreground fg :weight 'bold)

   ;; modeline
   (mode-line :background modeline-bg :foreground modeline-fg)
   (mode-line-inactive :background modeline-bg-alt :foreground modeline-fg-alt)

   ;; tab-bar (Emacs 27+)
   (tab-bar :background base0 :foreground fg)
   (tab-bar-tab :background "#323231" :foreground fg :weight 'bold)
   (tab-bar-tab-inactive :background "#222221" :foreground fg-alt)

   ;; borders/dividers
   (window-divider :foreground "#323231")
   (vertical-border :foreground "#323231")

   ;; fringe
   (fringe :background base0)))

;;; rasmus-theme.el ends here
