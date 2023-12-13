# Blog
Source code for my (eventual) blog at mikebelanger.ca

# How it works
- `input/pages` are html pages that get top-level access. Add a page by adding an html file, and title it with a `<title></title>` tag.
- `input/posts` are markdown pages that get compiled into html for the blog section. Add a blog post by adding a markdown file.

# To build

1. Ensure you have a recent-ish version of [Crystal](http://crystal-lang.org).  I'm using `1.10.1 (2023-10-25)`.
2. `cd` into this dir, and go ```shards install```.
3. Build the blog-builder binary like ```crystal build build_site.cr```
4. Run the compiled binary (this command probably looks different on Windows):
```sh
./build_site
```
5. An output directory should get created with all the necessary files, including the `index.html`.
