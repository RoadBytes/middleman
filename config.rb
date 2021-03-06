###
# Blog settings
###

activate :blog do |blog|
  blog.name   = "personal"
  blog.prefix = "personal"
  blog.layout = "blog_layout"
  blog.summary_separator = /READMORE/

  # Tags configurations
  blog.taglink = "personal/tags/:tag.html"
  blog.tag_template = "tag.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "personal/page/{num}"
end

activate :blog do |blog|
  blog.name   = "technical"
  blog.prefix = "technical"
  blog.layout = "blog_layout"

  # Tags configurations
  blog.taglink = "technical/tags/:tag.html"
  blog.tag_template = "tag.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "technical/page/{num}"
end

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
# page "/about.html", :layout => "layouts/about-layout"
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  def question_toggle(question, answer, textbox = false)
    textarea_html = "<textarea rows='4' style='color: green' " +
                    "placeholder='write your answer before checking mine'>" +
                    "</textarea>"
    textarea_result = textbox ? textarea_html : ""

    "<div class='question'>" +
    "  Q: #{question}"       +
    "  <div class='answer'>" +
    "    A: #{answer}"       +
    "  </div>"               +
    "</div>"                 +
    textarea_result
  end
end

activate :syntax do |syn|
  syn.inline_theme = nil
end

set :markdown_engine, :kramdown

set :markdown, :layout_engine => :erb,
               :fenced_code_blocks => true,
               :tables => true,
               :autolink => true,
               :smartypants => true,
               :with_toc_data => true

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

activate :imageoptim do |options|
  # Use a build manifest to prevent re-compressing images between builds
  options.manifest = true

  # Silence problematic image_optim workers
  options.skip_missing_workers = true

  # Cause image_optim to be in shouty-mode
  options.verbose = false

  # Setting these to true or nil will let options determine them (recommended)
  options.nice = true
  options.threads = true

  # Image extensions to attempt to compress
  options.image_extensions = %w(.png .jpg .gif .svg)

  # Compressor worker options, individual optimisers can be disabled by passing
  # false instead of a hash
  options.advpng    = { :level => 4 }
  options.gifsicle  = { :interlace => false }
  options.jpegoptim = { :strip => ['all'], :max_quality => 100 }
  options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
  options.optipng   = { :level => 6, :interlace => false }
  options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
  options.pngout    = { :copy_chunks => false, :strategy => 0 }
  options.svgo      = {}
end

activate :middleman_simple_thumbnailer

set :relative_links, true

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  #
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets
  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
