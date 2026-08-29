+++
title = "Thoughts on Lucky"
date = "2026-08-18"
tags = ["crystal", "lucky"]
categories = ["general"]
authors = ["mike"]
description = "Where this blog starts, and how to make it yours."
+++

## The Lucky Framework

My first developer job was writing [Rails](https://rubyonrails.org/) apps. So I have a soft-spot in my heart for Ruby on Rails. In that time, I learned a lot about why Rails was so popular. Its convention-over-configuration scaffold generation was a godsend. The simple, elegant syntax of [Ruby](https://ruby-lang.org/), combined with some clever Rails macros allowed me to focus on business logic rather than code boilerplate and ceremony.

After a few years of doing this, I found myself getting burned out. It turns out Rails was great for getting quick prototypes up and running, and getting clients excited. Where Rails fell short was maintenance: preventing Nil-reference errors, improper variable name calling. Performance wasn't the best, either.

Really, those issues can be attributed to the dynamic type (read: duck) type system of Ruby. So I don't think my experience with Rails was unique. It was a common experience of any framework written in a dynamically-typed programming language.

I eventually switched jobs, and started doing more frontend, React-specific sites. Most of it using Typescript. Typescript prevented lots of the silly footguns that javascript, another dynamically typed language, would tend to give. But there were other drawbacks to this tech. React, on its own, was just a library, not a framework. So there were no scaffold generators, and if there were macros/preprocessors, they must've been minimal. That translated to much more boilerplate. Besides, the code was pure client-side. Most of the time, the client side was at the whim of a backend that was usually dynamically-typed.

This all made me wonder: can I get the best of both "worlds"? Something with good, strong scaffold-generation to enforce conventions, and something with static typing? Something with simple syntax, but strong-typing? That brings me to [Lucky](https://luckyframework.org/).

Lucky is written in a less-known language called [Crystal](https://crystal-lang.org/). Crystal's syntax looks almost identical to Ruby's. Object-oriented, elegent. Under the hood, it differs a lot. It's statically-typed, and uses [CSP-style continutations](https://crystal-lang.org/reference/1.21/guides/concurrency.html#channels) channels for concurrency (similar to [Go's](https://gobyexample.com/channels)) It uses the same LLVM-backed system to compile its code into binaries, (the same as Rust's, actually). So you get speedy programs, static analysis, all while retaining a simple syntax.
