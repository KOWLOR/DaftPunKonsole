activate :google_analytics do |ga|
  ga.tracking_id = 'ua-xxxxx'
  ga.anonymize_ip = true
  ga.debug = false
  ga.development = false
  ga.minify = true
end

require 'slim'

activate :livereload
activate :directory_indexes

set :js_dir, 'assets/javascripts'
set :css_dir, 'assets/stylesheets'
set :images_dir, 'assets/images'

# Add bower's directory to sprockets asset path
after_configuration do

  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]

end

# Build-specific configuration
configure :build do

  activate :autoprefixer,
    browsers: ['last 2 versions', 'ie 8', 'ie 9']

  activate :minify_html
  activate :minify_css
  activate :minify_javascript

  activate :asset_hash
  activate :relative_assets
  activate :gzip

end
