#!/usr/bin/env janet
(use sh)
(def files-str ($< git diff --staged --name-only --diff-filter=d))
(def files (let [files (string/split "\n" files-str)]
             (take (- (length files) 1) files)))
(def errors @[])
(def colors @{:clear "\e[0m"
              :red "\e[31m"
              :blue "\e[34m"})
(def cmd-start "[[ -x ")
(def cmd-end "]]")
(each file files
  (if ($< ,cmd-start ,file ,cmd-end)
    (array/push errors (string
                        (colors :red) file (colors :clear)
                        " is executable"))))

(if (not (empty? errors))
  (do
   (each err errors (print "[No-Exe] " err))
   (os/exit 1)))
