repo = 'https://raw.github.com/tonilin/rails_recipe/master/'


copy_from 'https://raw.github.com/RailsApps/rails-composer/master/files/gitignore.txt', '.gitignore'
git :init
git :add => '-A'
git :commit => '-qm "initial commit"'

# Ruby version
copy_from_repo '.ruby-version', :repo => repo
copy_from_repo '.powrc', :repo => repo
git :add => '-A'
git :commit => '-qm "Add .ruby-version and .powrc"'


# Database
copy_from_repo 'config/database.yml', :repo => repo
mysql_username = ask_wizard("Username for MySQL? (root)")
mysql_password = ask_wizard("Password for MySQL?")

mysql_username ||= "root"
mysql_password ||= ""


gsub_file "config/database.yml", /username: .*/, "username: #{mysql_username}"
gsub_file "config/database.yml", /password:/, "password: #{mysql_password}"
gsub_file "config/database.yml", /database: myapp_development/, "database: #{app_name}_development"
gsub_file "config/database.yml", /database: myapp_test/,        "database: #{app_name}_test"
gsub_file "config/database.yml", /database: myapp_production/,  "database: #{app_name}_production"

git :add => '-A'
git :commit => '-qm "Setting database"'

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


git :add => '-A'
git :commit => '-qm "Add gems"'

after_bundler do
  generate 'simple_form:install --bootstrap'
  git :add => '-A'
  git :commit => '-qm "Setting simple form"'


  # Figaro
  generate 'figaro:install'
  gsub_file 'config/application.yml', /# PUSHER_.*\n/, ''
  gsub_file 'config/application.yml', /# STRIPE_.*\n/, ''
  git :add => '-A'
  git :commit => '-qm "Setting figaro"'
end

after_everything do
  # remove commented lines and multiple blank lines from Gemfile
  # thanks to https://github.com/perfectline/template-bucket/blob/master/cleanup.rb
  gsub_file 'Gemfile', /#.*\n/, "\n"
  gsub_file 'Gemfile', /\n^\s*\n/, "\n"


  # remove commented lines and multiple blank lines from config/routes.rb
  gsub_file 'config/routes.rb', /  #.*\n/, "\n"
  gsub_file 'config/routes.rb', /\n^\s*\n/, "\n"




  git :add => '-A'
  git :commit => '-qm "Clean up"'


  generate "devise:install"
  generate "devise User"
  generate "devise:views"

  git :add => '-A'
  git :commit => '-qm "Initial devise"'


  generate "layout:install bootstrap3 --force"
  generate "layout:navigation --force"
  generate "layout:devise bootstrap3 --force"
  git :add => '-A'
  git :commit => '-qm "Add bootstrap3 view"'

end




__END__

name: roachking
description: "Select all core recipes."
author: tonilin

requires: []
category: collections