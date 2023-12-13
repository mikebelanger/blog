// Get document contents right below display banner
const pageContentNode = document.getElementById('contents');

if (pageContentNode) {
  const loadPage = async (blogLink) => {
    let html = await fetch(blogLink).then(result => result.text());
    if (html) pageContentNode.innerHTML = html;
    // Highlight any syntax necessary
    if (hljs) hljs.highlightAll();
  }

  // Base content changes on a corresponding template inside the banner
  const updateLink = (event) => {
    // If it isn't anything, default to home
    const extension = event?.target.location.hash.replace('#', '');

    // If its a blog post
    if (extension.includes('blog_')) {
      loadPage(`${extension.replace('_', '/')}.html`);    
    // If its a top-level page
    } else {
      switch(extension) {
        case '':
          loadPage('/home.html')
          break;
        case 'blog':
          loadPage('/blog.html')
          break;
        default:
          loadPage(extension);
          break;
      }  
    }
  }
    // In case a visitor is accessing something other than home ie) #art, #tools.  We want to draw the content
  // for those pages right after they load.
  document.addEventListener("DOMContentLoaded", (event) => updateLink(event));
  window.addEventListener("hashchange", (event) => updateLink(event));
}