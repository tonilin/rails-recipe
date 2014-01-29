repo = 'https://raw.github.com/tonilin/rails_recipe/master/'

mysql_username = ask_wizard("Username for MySQL? [root]")
mysql_password = ask_wizard("Password for MySQL?")
mysql_username = "root" if mysql_username.blank?
mysql_password = ""     if mysql_password.blank?



copy_from "#{repo}/gitignore.txt", '.gitignore'
git :init


# Ruby version
copy_from_repo '.ruby-version', :repo => repo
copy_from_repo '.powrc', :repo => repo


# Database
copy_from_repo 'config/database.yml', :repo => repo


gsub_file "config/database.yml", /username: .*/, "username: #{mysql_username}"
gsub_file "config/database.yml", /password:/, "password: #{mysql_password}"
gsub_file "config/database.yml", /database: myapp_development/, "database: #{app_name}_development"
gsub_file "config/database.yml", /database: myapp_test/,        "database: #{app_name}_test"
gsub_file "config/database.yml", /database: myapp_production/,  "database: #{app_name}_production"

# GEMSET

# Database
gsub_file 'Gemfile', /gem 'sqlite3'\n/, ''
add_gem 'mysql2'

# SEO
add_gem 'friendly_id', '~> 5.0.0'
add_gem 'babosa'
add_gem 'meta-tags', '1.5.0', require: 'meta_tags'
add_gem 'sitemap_generator'

# Auth
add_gem 'devise', '3.2.2'
add_gem 'omniauth'
add_gem 'omniauth-facebook'

# View
add_gem 'bootstrap-sass', '~> 3.0.3.0'
add_gem 'simple_form', "~> 3.0.1"
add_gem 'will_paginate', "3.0.3"
add_gem 'active_link_to'
add_gem 'font-awesome-rails', '~> 4.0.0'
add_gem 'rails-i18n', '~> 4.0.0' # For 4.0.x
add_gem 'will_paginate-bootstrap'
add_gem 'high_voltage'
add_gem "active_model_serializers"

# Notification
add_gem 'hipchat'
add_gem 'airbrake'


# File
add_gem 'rmagick'
add_gem 'carrierwave'
add_gem 'carrierwave-meta'


# Deploy
add_gem 'rvm-capistrano'
add_gem 'unicorn', :group => [:production]
add_gem "capistrano", :group => [:development]
add_gem "capistrano-ext", :group => [:development]
add_gem "cape", :group => [:development]
add_gem 'capistrano-unicorn', :require => false, :group => [:development]

# Setting
add_gem 'figaro'
add_gem 'settingslogic'


# Debugger
add_gem "binding_of_caller", :group => [:development]
add_gem "better_errors", "~> 0.9.0", :group => [:development]
add_gem "meta_request", :group => [:development]


# TEST
add_gem "rspec-rails", :group => [:development, :test]
add_gem "database_cleaner", :group => [:development, :test]
add_gem "shoulda-matchers", :group => [:development, :test]
add_gem "fabrication", :group => [:development, :test]
add_gem "faker", :group => [:development, :test]
add_gem "timecop", :group => [:development, :test]


# Tool
add_gem "annotate", :group => [:development]
add_gem "powder", :group => [:development]
add_gem 'rails_layout', :group => [:development]



after_bundler do
  generate 'simple_form:install --bootstrap'


  # Figaro
  generate 'figaro:install'
  gsub_file 'config/application.yml', /# PUSHER_.*\n/, ''
  gsub_file 'config/application.yml', /# STRIPE_.*\n/, ''
end

after_everything do
  # remove commented lines and multiple blank lines from Gemfile
  # thanks to https://github.com/perfectline/template-bucket/blob/master/cleanup.rb
  gsub_file 'Gemfile', /#.*\n/, "\n"
  gsub_file 'Gemfile', /\n^\s*\n/, "\n"


  # remove commented lines and multiple blank lines from config/routes.rb
  gsub_file 'config/routes.rb', /  #.*\n/, "\n"
  gsub_file 'config/routes.rb', /\n^\s*\n/, "\n"




  generate "devise:install"
  generate "devise User"
  generate "devise:views"




  generate "layout:install bootstrap3 --force"
  generate "layout:navigation --force"
  generate "layout:devise bootstrap3 --force"

  copy_from_repo 'app/views/layouts/application.html.erb', :repo => repo
  copy_from_repo 'app/views/common/_google_analytics.html.erb', :repo => repo


  copy_from_repo 'app/controllers/home_controller.rb', :repo => repo
  copy_from_repo 'app/views/home/index.html.erb', :repo => repo



  copy_from_repo 'config/routes.rb', :repo => repo
  # CORRECT APPLICATION NAME
  gsub_file 'config/routes.rb', /^.*.routes.draw do/, "#{app_const}.routes.draw do"



  copy_from_repo 'app/models/setting.rb', :repo => repo
  copy_from_repo 'config/config.yml', :repo => repo
  gsub_file "config/config.yml", /app_name: .*/, "app_name: #{app_name}"
  gsub_file "config/config.yml", /domain: .*/, "domain: #{app_name}.dev"



  # Deploy recipe
  copy_from_repo 'config/deploy.rb', :repo => repo
  copy_from_repo 'config/unicorn.rb', :repo => repo
  copy_from_repo 'Capfile', :repo => repo
  copy_from_repo 'config/recipes/deploy/assets.rb', :repo => repo
  copy_from_repo 'config/recipes/deploy/remote_rake.rb', :repo => repo
  copy_from_repo 'config/recipes/deploy/sitemap.rb', :repo => repo
  copy_from_repo 'config/recipes/deploy/upload_setting.rb', :repo => repo
  copy_from_repo 'config/recipes/rails/log.rb', :repo => repo
  gsub_file "config/deploy.rb", /myapp/, "#{app_name}"
  gsub_file "config/unicorn.rb", /myapp/, "#{app_name}"






  git :add => '-A'
  git :commit => '-qm "Initial commit"'

end




__END__

name: roachking
description: "Select all core recipes."
author: tonilin

requires: []
category: collections