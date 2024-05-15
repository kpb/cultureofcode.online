---
title: Installing Up-To-Date Node.js on Linux
date: 2016-03-18
categories:
  - dev
tags:
  - nodejs
draft: true
---

I'm running a recent version of [XUbuntu](http://xubuntu.org/), and have installed [Node.js](https://nodejs.org/en/) via
the package manager. But, the version in the Ubuntu repos is horribly out of date: <!--more-->

```bash
$ nodejs -v
v0.10.25
```

As of today, the LTS version is 16.11.5. It's pretty easy to install from the source. But, there's a better way. The
[Node.js](https://nodejs.org/en/) project maintains [a set of repos](https://github.com/nodesource/distributions) for
most Linux distros, which includes excellent installation instructions. In my case, it was incredibly simple:

```bash
$ curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - [sudo] password for kenneth:

Installing the NodeSource Node.js 4.x LTS Argon repo...

...

Adding the NodeSource signing key to your keyring...

Creating apt sources list file for the NodeSource Node.js 4.x LTS Argon repo...

...

Running `apt-get update` for you...
```
Then, I installed the shiny new Node.js using [Aptitude](https://wiki.debian.org/Aptitude) - because
[Aptitude](https://wiki.debian.org/Aptitude) is the bomb:

```bash
$ sudo aptitude install nodejs
The following NEW packages will be installed:
rlwrap{a}
The following packages will be upgraded:
nodejs{b}
1 packages upgraded, 1 newly installed, 0 to remove and 1 not upgraded.
Need to get 8,781 kB of archives. After unpacking 38.6 MB will be used.
The following packages have unmet dependencies:
nodejs : Conflicts: nodejs-dev but 0.10.25~dfsg2-2ubuntu1 is installed.
  Conflicts: npm but 1.4.21+ds-2 is installed.
nodejs-dev : Depends: nodejs (= 0.10.25~dfsg2-2ubuntu1) but 4.4.0-1nodesource1~wily1 is to be installed.
The following actions will resolve these dependencies:

Remove the following packages:
1)     nodejs-dev
2)     npm
```
No problem, [Ghost Rider](https://en.wikipedia.org/wiki/Ghost_Rider_%28comics%29), just accept the solution to remove
the original packages and roll on:

```bash
Accept this solution? [Y/n/q/?] y
The following NEW packages will be installed:
rlwrap{a}
The following packages will be REMOVED:
...
The following packages will be upgraded:
nodejs
1 packages upgraded, 1 newly installed, 60 to remove and 1 not upgraded.
Setting up nodejs (4.4.0-1nodesource1~wily1) ...
```
All done!

```bash
$ nodejs -v
v4.4.0
```

Get your up-to-date [Node.js](https://nodejs.org/en/) on!
