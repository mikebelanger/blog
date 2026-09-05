+++
title = "Thoughts on Lucky"
date = "2026-08-18"
tags = ["crystal", "lucky", "rails", "web"]
categories = ["general"]
authors = ["mike"]
description = "My thoughts on the Lucky web framework."
+++
[Rails](https://rubyonrails.org) got popular for a reason. It provided high-level productivity with just enough flexibility for a whole swath of web applications. Everyone from junior to senior-level devs could ramp up pretty fast. My first developer job was writing Rails applications, and I went from knowing nothing about Rails to pushing out bugfixes within weeks, and full-features within months.

Lots of startups owe their initial success to Rails. You could argue they would have succeeded with any framework, but they chose that.

That said, Rails' language, [Ruby](https://www.ruby-lang.org/), is a double-edged sword. Ruby's syntax hid lots from the developer, which made it look simple.  But in hiding all that, it made it all the more difficult to understand. It's dynamic typing gave it flexibility, but was nearly impossible to perform any kind of static analysis/linting. This translated to more errors, and the kind of errors you could only see at runtime. 

This has led me, and many other developers to wonder: is the killer combo something like Rails, but uses a statically-typed language?  There's certainly no shortage of frameworks like that, from more established ones like [Quarkus](quarkus.io) to more bleeding edge ones like [Loco](https://loco.rs).

Another one is [Lucky](https://luckyframework.org/).

Lucky is written in a lesser-known language called [Crystal](https://crystal-lang.org/). Crystal's syntax looks almost identical to Ruby's. Object-oriented, elegant. Under the hood, it differs a lot. It's statically-typed, and uses [CSP-style channels](https://crystal-lang.org/reference/1.21/guides/concurrency.html#channels) for concurrency (similar to [Go's](https://gobyexample.com/channels)). It compiles its code into binaries using the same LLVM-backed system as Rust. So you get speedy programs, static analysis, all while retaining a simple syntax.
