compass_config do |config|
  config.output_style = :compact
end

require 'slim'
activate :livereload
activate :directory_indexes

set :js_dir, 'javascripts'
set :css_dir, 'stylesheets'
set :images_dir, 'images'

# Add bower's directory to sprockets asset path
after_configuration do

  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]

end

# Dynamic link helpers
helpers do
  def active_link_to(link, url, opts={})
    compare = build? ? ('./' == url_for(url)) : (current_resource.url == url_for(url))
    if compare
      if opts[:class]
        opts[:class] = opts[:class] + ' active'
      else
        opts = {}
        opts[:class] = 'active'
      end
    end
    link_to(link, url, opts)
  end
end

# Build-specific configuration
configure :build do

  activate :minify_css
  activate :minify_javascript
  activate :asset_hash

  activate :relative_assets
  set :relative_links, true

end

