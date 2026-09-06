+++
title = "Thoughts on Lucky"
date = "2026-08-18"
tags = ["crystal", "lucky", "rails", "web"]
categories = ["general"]
authors = ["mike"]
description = "My thoughts on the Lucky web framework."
+++
[Rails](https://rubyonrails.org) got popular for a reason. Everyone from junior to senior-level devs could ramp up with Rails pretty fast. My first developer job involved writing Rails applications. I went from knowing nothing about Rails to pushing out bugfixes within weeks, and full-features within months.

My story isn't unique. Many successful startups got their initial MVP shipped using Rails. You could argue they would have succeeded with any framework, and to some extent, I would agree. If that framework included:

  * A CLI for generating clean, conventional code quickly
  * A REPL (read: console) for easy debugging and inspection
  * Bonus points if the language was concise, relatively boilerplate-free, and allowed developers to focus on business logic.

Then sure, that framework could work too. 

That said, Rails' language, [Ruby](https://www.ruby-lang.org/), is a double-edged sword. Ruby's syntax hid lots from the developer, which made it look simple.  But hiding all that complexity came at a cost. This cost came in the form of strange, runtime behaviors. It's dynamic typing gave it flexibility, but was nearly impossible to perform any kind of static analysis/linting. This translated to more errors, and the kind of errors you could only see at runtime. 

How to get ahead of those runtime errors? There's a few ways. Automated testing, be it unit, integration or end-to-end, is one way.  But writing tests take valuable time, and rely on the vigilant, impartial developers. Another way, which is easier to enforce, is to use a statically-typed language. Something that doesn't let the developer go ahead until their code achieves some degree of type safety.

There's certainly no shortage of frameworks like that, from more established ones like [Quarkus](quarkus.io) to more bleeding edge ones like [Loco](https://loco.rs).

Another one is [Lucky](https://luckyframework.org/).

Lucky is written in a lesser-known language called [Crystal](https://crystal-lang.org/). Crystal's syntax looks almost identical to Ruby's. Object-oriented, elegant. Under the hood, it differs a lot. It's statically-typed, and uses [CSP-style channels](https://crystal-lang.org/reference/1.21/guides/concurrency.html#channels) for concurrency (similar to [Go's](https://gobyexample.com/channels)). It compiles its code into binaries using the same LLVM-backed system as Rust. So you get speedy programs, static analysis, all while retaining a simple syntax.
