+++
title = "Hello World"
date = "2026-08-18"
tags = ["introduction", "hello"]
categories = ["general"]
authors = ["admin"]
description = "Where this blog starts, and how to make it yours."
+++

Every blog starts somewhere, and this one starts here. The site around this post is powered by Hwaro, a fast static site generator written in Crystal.

## What the samples show

Three sample posts (including this one) demonstrate how dates, tags, and categories flow through the homepage feed, the archives, and the taxonomy pages. When you're ready to write for real:

- Delete the samples under `content/posts/`.
- Run `hwaro new posts/my-first-post.md` to start a post; the archetype fills in the front matter.
- Publish with `hwaro build`.

The feed and archives pick up new posts automatically. Nothing else to wire up.