###
# Blog settings
###

# Time.zone = "UTC"

activate :syntax

activate :livereload

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = true
end


activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"

  blog.permalink = "{year}/{month}/{day}/{title}"
  # Matcher for blog source files
  blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "post"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  blog.year_link = "{year}.html"
  blog.month_link = "{year}/{month}.html"
  blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page{num}"
end

activate :directory_indexes

#redirect "/blog/2016/04/25/generativity.html", to: "/blog/2016/04/28/generativity.html"

page "/blog/*", layout: "blog"
page "/blog/atom.xml", layout: false
page "/wiki/*", layout: "wiki"
page "/404.html", directory_index: false

helpers do
  def page_title
    if current_article
      current_article.title + " :: "
    elsif current_page.path.start_with? "wiki"
      wiki_title + " :: "
    end
  end

  def wiki_title
    File.read(current_page.source_file).lines.first.chomp("\n").gsub('#', "")
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

sprockets.append_path File.join root, 'bower_components'
