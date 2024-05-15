---
title: Lombok...is this week's muse
date: 2016-07-01
description: Eliminate boiler plate code with project Lombok
categories:
 - muse
draft: true
---

_(A weekly featured project/product that will make your short life better.)_


Would you give me an uncomfortably long hug if I told you that you never had to write another
[Java](https://www.java.com/) getter/setter again?  [Project Lombok](https://projectlombok.org/features/index.html) can
help you do this with simple annotations!

```java
class Person {
  @Getter @Setter String firstName;
  @Getter @Setter String lastName;
}
```

But wait, there's more. You can eliminate all sorts of boilerplate code: `toString()`, `equals()`, `hashCode()`,
etc. The [project](https://projectlombok.org/features/index.html) has great documentation and is easy to get started
with.

There is a longer tutorial, [Reducing Boilerplate Code with Project Lombok](http://jnb.ociweb.com/jnb/jnbJan2010.html),
that also explores the limits and controversy around the project.
