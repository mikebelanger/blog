require "markd"
require "to_html"
require "crystagiri"

class Page
  getter title, id

  def initialize(title : String, id : String)
    @title = title
    @id = id
  end
  def filename(prefix = nil)
    "#{prefix}/#{@title.sub(" ", "_")
      .sub("md", "html")
      .downcase}"
  end
  def htmlName
    @filename.sub("md", "html")
  end
  def anchor(prefix : String | Nil = nil)
    return_s : String
    if prefix.nil?
      return_s = "##{self.id}"
    else
      return_s = "##{prefix}_#{self.id}"
    end
    return_s
      .sub(".md", "")
      .sub(".html", "")
  end
  def to_s
    @title
      .sub(".html", "")
      .capitalize
  end
end

class HtmlPage < Page
  getter filename, html, title, id

  def initialize(html : String, filename : String, title : String, id : String)
    @html = html
    @filename = filename
    @title = title
    @id = id

    # Now set up some variables for blog metadata
    page_html = Crystagiri::HTML.new html
    t = page_html.at_css("title")
    @title = t ? t.content : title
  end
end

class MarkdownPage < Page
  getter filename, title, date_published : String

  def initialize(markdown : String, filename : String, id : String)
    @filename = filename
    @markdown = markdown
    @id = id
    @date_published = ""
    
    # Now set up some variables for blog metadata
    page_html = Crystagiri::HTML.new Markd.to_html(markdown)

    # Get the title from the first h2 tag
    h2 = page_html.at_css("h2")
    @title = h2 ? h2.content : filename

    # Get the title from the first h2 tag
    d = page_html.at_css("h4")
    @date_published = d ? d.content : ""

    # Get the date published from the first h4
  end
  ToHtml.instance_template do
    Markd.to_html(@markdown)
  end
end

module Website
  class Site
    getter pages
    @pages : Array(HtmlPage)
    def initialize(pages : Array(HtmlPage), title : String)
      @pages = pages
      @title = title
    end
    
    ToHtml.instance_template do
      html lang: "en" do
        head do
          title { @title }
          meta name: "viewport", content: "width=device-width, initial-scale=1, minimum-scale=1"
          meta charset: "utf-8"
          meta name: "description", content: "Author: Mike Belanger, Developer, Artist"
          link rel: "stylesheet", href: "./styles/banner-links.css", type: "text/css"
          link rel: "stylesheet", href: "./styles/blog.css", type: "text/css"
          link rel: "stylesheet", href: "./styles/content.css", type: "text/css"
          link rel: "stylesheet", href: "./styles/default.min.css"
          link rel: "stylesheet", href: "./styles/panda-syntax-dark.css"
          link rel: "stylesheet", href: "./styles/random.css"
          link rel: "stylesheet", href: "./styles/site.css"
          link rel: "stylesheet", href: "./styles/top-banner.css", type: "text/css"
          script src: "./js/highlight.min.js", type: "text/javascript"
          script src: "./js/crystal.min.js", type: "text/javascript"
          script src: "./js/highlightBlog.js", type: "text/javascript"
          script src: "./js/page.js", type: "text/javascript", defer: nil
        end
        header class: "banner", id: "top-banner" do
          section class: "left" do
            # Give each page a link at the top header
            @pages.each do |page|
              a class: "page-link", id: page.id, href: page.anchor do
                page.to_s
              end
            end
          end
          section class: "right" do
            a href: "mailto:mikebelanger@fastmail.com", title: "Mail" do
              img width: "32", height: "32", alt: "e-mail", src: "svg/bxs-envelope.svg"
            end
            a href: "https://www.github.com/mikebelanger", title: "Github" do
              img width: "32", height: "32", alt: "github", src: "svg/bxl-github.svg"
            end
            a href: "https://www.linkedin.com/in/mike-belanger-84035651/", title: "LinkedIn" do
              img width: "32", height: "32", alt: "linkedin", src: "svg/linkedin-square.svg"
            end
            a href: "https://vimeo.com/mikebelanger", title: "Vimeo" do
              img width: "32", height: "32", alt: "vimeo", src: "svg/bxl-vimeo.svg"
            end
          end
        end
        body do
          main id: "contents"
        end
        footer do
          h3 do
            "Icons from"
            a href: "https://boxicons.com/" do
              "BoxIcons"
            end
          end
        end
      end
    end
  end
  struct Blog
    @contents : Hash(String, MarkdownPage)
    def initialize(markdown_directory : String, @output_directory : String)
      @contents = {} of String => MarkdownPage
  
      # Read all posts
      postsDir = Dir.open(markdown_directory)
  
      # TODO: Find better way of filtering for markdown files
      postsDir.each_child do |child|
        if child.ends_with?(".md")
          page = MarkdownPage.new(
            File.read(Path.new([markdown_directory, child]).join()),
            child,
            child
          )
          @contents[page.filename] = page
        end
      end
  
      # Ensure the directory for output exists
      unless Dir.exists?(output_directory)
        Dir.mkdir(Path.new(output_directory))
      end
    end
    def write_all_pages
      @contents.each_key do |k|
        post = @contents[k]
        File.write(Path.new([@output_directory, post.filename]).join(), post.to_html)
      end
    end
    # This means publish an index of pages, then individual html pages that link to it
    def publish
      # Write an index pointing to each file
      File.write(Path.new([@output_directory, "index.html"]).join(), self.to_html)
      self.write_all_pages
    end
    ToHtml.instance_template do
      html lang: "en" do
        @contents.keys.each do |key|
          a href: "./#{@contents[key].filename}", class: "blog-post" do
            @contents[key].title.to_s
          end
        end
      end
    end
  end    
end