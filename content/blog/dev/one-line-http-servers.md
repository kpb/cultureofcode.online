---
title: Morning Dose of One Line HTTP Servers
date: 2024-04-15
categories:
  - dev
draft: false
---

When you need to serve something up from the command line.<!--more-->

We've all done something like:

```bash {linenos=false}
$ ruby -run -ehttpd . -p8000
```

It's a really convenient way of serving up some content on a development machine. Maybe you don't have Ruby? Well,
[William Bowers][] has put together the [mother of all lists of one line, static HTTP servers][one line servers].

Go forth and serve.

[William Bowers]: https://gist.github.com/willurd
[one line servers]: https://gist.github.com/willurd/5720255
