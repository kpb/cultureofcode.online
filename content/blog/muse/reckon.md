---
title: "Reckon...is this week's muse"
date: 2020-04-12T11:48:32-06:00
categories:
- muse
tags:
- gradle
- git
- release
description: Reckon is a Gradle plugin to infer your project's version number without the ridiculousness of hard-coding it in build files.
draft: false
---

(A weekly featured project/product that will make your short life better.)

We've all been through the drill: Create a release branch. Bump the version number. Merge and delete the release
branch. Tag the release. What a waste of time. If you're building a project with [Gradle][gradle] and using
[Git][git], the [Reckon][reckon] plugin can infer your projects version number __without__ having to hard-code it in your
build files by taking advantage of all the information that is already available in [Git][git].

[Reckon][reckon] has [pretty great documentation][reckon-doc], but here's a couple of use cases you can run through
yourself to get a feel for using it.

If you don't have [Gradle][gradle] installed, I'd suggest using the excellent [SDKMAN][sdkman] to manage your
installations.

### Use Case: A Java Library Using Maven Snapshot Versioning

##### Create a gradle project

We are going to build a Java library, working towards version 1.0.0.

```bash
$ $ mkdir reckon-snapshot-example
$ cd reckon-snapshot-example
$ gradle init
Starting a Gradle Daemon (subsequent builds will be faster)

Select type of project to generate:
1: basic
2: application
3: library
4: Gradle plugin
Enter selection (default: basic) [1..4] 3
...
```

Accept the defaults for the rest of the options. You should be able to build the project with:

```bash
$ ./gradlew clean assemble
...
BUILD SUCCESSFUL
```
If we look at the results of the build, there is no version number on the build artifact:

```bash
$ ls build/libs/
reckon-snapshot-example.jar
```

##### Initialize a Git Repo

```bash
$ git init .
$ git add .
$ git commit -am "Initial import of project"
```

##### Apply the [Reckon Plugin][reckon]

You can find the latest version of the reckon plugin by searching for it on https://plugins.gradle.org.

Open up `build.gradle` (A good time format it and clean up whitespace), add the plugin, and the _snapshot_
configuration:

```groovy
plugins {
  ...
  id 'org.ajoberstar.reckon' version '0.12.0'
}

reckon {
  scopeFromProp()
  snapshotFromProp()
}
````
Run the build again and notice that [Reckon][reckon] is now inferring a build number and applying it to the project:

```bash
$ ./gradlew clean assemble
Reckoned version: 0.1.0-SNAPSHOT
$ ls build/libs/
reckon-snapshot-example-0.1.0-SNAPSHOT.jar
```

Go ahead and commit the changes in your `build.gradle` file.

```bash
$ git commit -am "Update build file with reckon config"
```

That's pretty cool, but we had decided that we want to be working towards version 1.0.0, not 0.1.0. Let's tell
[Reckon][reckon] that we are working towards a major version release:

```bash
$ ./gradlew clean assemble -Preckon.scope=major
Reckoned version: 1.0.0-SNAPSHOT
$ ls build/libs/
reckon-snapshot-example-1.0.0-SNAPSHOT.jar
```

Boom! Our build now produces the correct snapshot version number, without any hard-coding.

##### Release a Final Version

If the work on this release is done, we can release a final (no snapshot) version of our library. (You'll get an error if
your git repo isn't clean.)

The [Reckon][reckon] snapshot configuration has two stages: _snapshot_ (the default) and _final_. So, we can tell our
build that we want to be in the _final_ stage.

```bash
$ ./gradlew clean assemble -Preckon.scope=major -Preckon.stage=final
Reckoned version: 1.0.0
```

[Reckon's][reckon] _reckonTagCreate_ task can tag the release for us. Since we haven't set up a remote repository, we'll tag locally:

```bash
$ ./gradlew reckonTagCreate -Preckon.scope=major -Preckon.stage=final 
> Task :reckonTagCreate
Reckoned version: 1.0.0

$ git tag
1.0.0
```
##### Working Towards the Next Patch Release

Until we make changes to the project, reckon will infer the version from the Git tag as 1.0.0. If we do some work, we
can have reckon infer the next version for us.

```bash
$ touch foo
$ ./gradlew clean assemble
Reckoned version: 1.1.0-SNAPSHOT
```

[Reckon][reckon] defaults to using the `reckon.scope` of _minor_. If we are working on a patch release, we can set the
scope patch to _patch_:

```bash
$ ./gradlew clean assemble -Preckon.scope=patch
Reckoned version: 1.0.1-SNAPSHOT
$ git commit -am "Add foo file"
```


### Use Case: An Application Using _beta_ --> _rc_ --> _final_ Versioning

In this use case, we are developing an application using a 3 stage versioning scheme.

- __final__: the tested, released version.
- __rc__: release candidate. Believed to be ready for release.
- __beta__: release including significant functionality on the way towards the next version.

You can start a new example by following the `gradle init` example above and choosing _application_ as the project
type.

The build configuration looks like:

```groovy
reckon {
  scopeFromProp()
  stageFromProp('beta', 'rc', 'final')
}
```
From a clean [Git][git] repo, you can see the inferred version:

```bash
$ ./gradlew clean assemble
Reckoned version: 0.1.0-beta.0.1+719d620
```

What's this? Reckon is using the default _scope_ of minor, the first stage alphabetically (beta), and an abbreviated git
commit hash. As before, we are working towards a _final_ version of 1.0.0. We need to set the scope to _major_:

```bash
$ ./gradlew clean assemble -Preckon.scope=major
Reckoned version: 1.0.0-beta.0.1+719d620
```

If we do some work and build with the changes in an uncommitted state, [reckon][reckon] will use a timestamp instead of a
commit hash:

```bash
$ touch foo
$ ./gradlew clean assemble -Preckon.scope=major
Reckoned version: 1.0.0-beta.0.1+20200412T220104Z
```

Assuming we're done developing, we can commit our work and do a beta release:

```bash
$ git add foo && git commit -m "Complete beta development for 1.0.0-beta"
$ ./gradlew reckonTagCreate -Preckon.scope=major -Preckon.stage=beta

> Task :reckonTagCreate
Reckoned version: 1.0.0-beta.1
```

Now we have build 1 of the 1.0.0 beta. [Reckon][reckon] will keep track of not only the beta versions, but the number of
builds as well. We can continue working through beta an rc builds until we are ready to do a final release.

```bash
$ ./gradlew reckonTagCreate -Preckon.scope=major -Preckon.stage=final
> Task :reckonTagCreate
Reckoned version: 1.0.0
```

The [How Reckon Works][reckon-doc] documentation has a ton of examples explaining how the version and build numbers are
inferred.

Hope this helps simplify your release process. Enjoy!

### References

- [Reckon][reckon]
- [How Reckon Works][reckon-doc]. All the examples you need to use the plugin.
- [Semantic Versioning][semver]. The only way to fly.
- [Understanding Maven Version Numbers][maven-version-numbers]. SNAPSHOT, how do it work?


<!-- ref links -->
[git]: https://git-scm.com/ "Git SCM"
[gradle]: https://gradle.org/ "Gradle Build Tool"
[reckon-doc]: https://github.com/ajoberstar/reckon/blob/master/docs/index.md "How Reckon Works"
[reckon]: https://github.com/ajoberstar/reckon "Reckon GitHub Page"
[sdkman]: https://sdkman.io/ "SDKMAN"

[semver]: https://semver.org/ "Semantic Versioning 2.0"

[maven-version-numbers]: https://docs.oracle.com/middleware/1212/core/MAVEN/maven_version.htm#MAVEN8855
