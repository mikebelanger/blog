require "./blog.cr"
require "file_utils"

class BlogPostList
  def initialize(@posts : Array(MarkdownPage))
  end
  ToHtml.instance_template do
    ul do
      @posts.each do |post|
        li do
          a href: post.anchor(prefix: "blog") do
            post.title.to_s
          end
          p { post.date_published }
        end
      end
    end
  end
end

class MarkdownSource
  def initialize(
      @title : String,
      @pages_directory : String,
      @posts_directory : String,
      @input_directory : String,
      @output_directory : String
    )
    @posts_directory = Path.new(@input_directory, @posts_directory).join()
    @pages_directory = Path.new(@input_directory, @pages_directory).join()

    @index = Website::Site.new(
      pages: Array(HtmlPage).new(),
      title: title
    )
    @posts = Array(MarkdownPage).new()

    # Read all markdown blog posts
    Dir.open(@posts_directory).each_child do |child|
      if child.ends_with?(".md")
        @posts <<
          MarkdownPage.new(
            markdown: File.read(Path.new([@posts_directory, child]).join()),
            filename: child,
            id: child
          )
      end
    end

    # Output all blog posts to an index, so you can see all the blog posts in one spot
    blog_post_index = BlogPostList.new(@posts)
    File.write(Path.new(@pages_directory, "blog.html"), blog_post_index.to_html)

    # Read all html pages meant for top-level (ie) domain.org/page.html
    # Ignore Index as that's made in a separate step
    Dir.open(@pages_directory)
      .select { |page| page.ends_with?(".html") && page != "index.html" }
      .each do |child|
        @index.pages << 
          HtmlPage.new(
            html: File.read(Path.new([@pages_directory, child]).join()),
            filename: child,
            title: child,
            id: child
          )
    end

    # Ensure the directory for output exists
    unless Dir.exists?(@output_directory)
      Dir.mkdir(Path.new(@output_directory))
    end

    # Put blog posts inside the output directory
    blog_path = Path.new([@output_directory, "blog"]).join()

    unless Dir.exists?(blog_path)
      Dir.mkdir(blog_path)
    end
  end
  def render_files
    # Output all our top-level pages
    @index.pages.each do |page|
      File.write(Path.new(@output_directory, page.filename), page.html)
    end

    # Render our index page, which contains the header
    File.write(Path.new(@output_directory, "index.html"), @index.to_html)
    # Output all our blog posts, and write them to an index
    @posts.each do |post|
      File.write(Path.new(@output_directory, "blog", post.htmlName), post.to_html)
    end
  end
  def move_support_files
    ["fonts", "img", "js", "styles", "svg"].each do |subdir|
      FileUtils.cp_r Path.new(@input_directory, subdir), Path.new(@output_directory, subdir)
    end
  end
end

m = MarkdownSource.new(
  title: "Mike's blog",
  pages_directory: "pages",
  posts_directory: "posts",
  input_directory: "input",
  output_directory: "output"
)

m.render_files
m.move_support_files