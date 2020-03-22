---
title: Encryption With Emacs
date: 2016-01-17
categories:
  - dev
tags:
  - emacs
draft: false
---

Of course it would be nice to encrypt/decrypt files from Emacs.
[EasyPG](http://epg.osdn.jp/) comes with GNU Emacs since Emacs23 (source file: epa-file.el). Simply add to your init file:

```emacslisp
(require 'epa-file)
(epa-file-enable)
```

Visit *anyfile*.gpg and it will be encrypted when you save the buffer.

If you're running X and you prefer a non-graphical keyphrase prompt, include in your config:

```emacslisp
(setenv "GPG_AGENT_INFO" nil)
```

### References

[EasyPG Home Page](http://epg.osdn.jp/).


[EmacsWiki EasyPG Entry](http://www.emacswiki.org/emacs/EasyPG). Configuration and troubleshooting info.
