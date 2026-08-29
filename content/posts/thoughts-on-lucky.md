+++
title = "Thoughts on Lucky"
date = "2026-08-18"
tags = ["crystal", "lucky"]
categories = ["general"]
authors = ["mike"]
description = "My thoughts on the Lucky web framework."
+++

## The Lucky Framework

My first developer gig was writing [Rails](https://rubyonrails.org/) apps. At that job, I learned why Rails was so popular. Its cli-generators were a godsend. The simple, elegant syntax of [Ruby](https://ruby-lang.org/), combined with some clever macros allowed me to focus on business logic rather than coding boilerplate and ceremony.

After a few years of writing/maintaining Rails apps, I got burned out. Rails was great for getting quick prototypes up and running, and getting clients excited (and to pay!). Where Rails fell short was maintenance: preventing Nil-reference errors, improper variable name calling. Rails' sluggish performance wasn't usually an issue for me, but when it was, it was a nightmare to deal with.

Really, those issues weren't specific to Rails. Most of the issues I ran into can be attributed to the dynamically-typed (read: duck) aspect of Ruby. After doing more work in other untyped languages like Javascript and Python, I encountered similar issues. So really, it was a problem with dynamically-typed languages.

I eventually switched jobs, and started doing more frontend, React-specific sites. Most of it using Typescript. Typescript prevented lots of the silly footguns that javascript, another dynamically typed language, were prone to. If I had to make large changes to the codebase (such as a refactor, or resolve merge conflicts) I felt reasonably confident once the TS compiler was satisfied.

But the Typescript + React combo had its own downsides. I used React on its own.  Which is fine, but its just a library, not a framework. So there were no scaffold generators, and if there were macros/preprocessors, they must've been minimal (ignoring the fact that TSX is kind of a macro system, of sorts). That translated to much more boilerplate. If there were any coding conventions, we had to adhere to them manually. PR reviews felt like us policing eachother on silly code conventions, and less about the intent of the PR.

This made me wonder: can we get the best of both worlds? Something with good, strong scaffold-generation to enforce conventions, and something with static typing? Something with simple syntax, but strong-typing? That brings me to [Lucky](https://luckyframework.org/).

Lucky is written in a less-known language called [Crystal](https://crystal-lang.org/). Crystal's syntax looks almost identical to Ruby's. Object-oriented, elegent. Under the hood, it differs a lot. It's statically-typed, and uses [CSP-style continutations](https://crystal-lang.org/reference/1.21/guides/concurrency.html#channels) channels for concurrency (similar to [Go's](https://gobyexample.com/channels)) It uses the same LLVM-backed system to compile its code into binaries, (the same as Rust's, actually). So you get speedy programs, static analysis, all while retaining a simple syntax.
