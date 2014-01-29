# >---------------------------------------------------------------------------<
#
#            _____       _ _
#           |  __ \     (_) |       /\
#           | |__) |__ _ _| |___   /  \   _ __  _ __  ___
#           |  _  // _` | | / __| / /\ \ | '_ \| '_ \/ __|
#           | | \ \ (_| | | \__ \/ ____ \| |_) | |_) \__ \
#           |_|  \_\__,_|_|_|___/_/    \_\ .__/| .__/|___/
#                                        | |   | |
#                                        |_|   |_|
#
#   Application template generated by the rails_apps_composer gem.
#   Restrain your impulse to make changes to this file; instead,
#   make changes to the recipes in the rails_apps_composer gem.
#
#   For more information, see:
#   https://github.com/RailsApps/rails_apps_composer/
#
#   Thank you to Michael Bleigh for leading the way with the RailsWizard gem.
#
#   Primarily generated by file:
#   https://github.com/RailsApps/rails_apps_composer/templates/layout.erb
#
# >---------------------------------------------------------------------------<

# >----------------------------[ Initial Setup ]------------------------------<

module Gemfile
  class GemInfo
    def initialize(name) @name=name; @group=[]; @opts={}; end
    attr_accessor :name, :version
    attr_reader :group, :opts

    def opts=(new_opts={})
      new_group = new_opts.delete(:group)
      if (new_group && self.group != new_group)
        @group = ([self.group].flatten + [new_group].flatten).compact.uniq.sort
      end
      @opts = (self.opts || {}).merge(new_opts)
    end

    def group_key() @group end

    def gem_args_string
      args = ["'#{@name}'"]
      args << "'#{@version}'" if @version
      @opts.each do |name,value|
        args << ":#{name}=>#{value.inspect}"
      end
      args.join(', ')
    end
  end

  @geminfo = {}

  class << self
    # add(name, version, opts={})
    def add(name, *args)
      name = name.to_s
      version = args.first && !args.first.is_a?(Hash) ? args.shift : nil
      opts = args.first && args.first.is_a?(Hash) ? args.shift : {}
      @geminfo[name] = (@geminfo[name] || GemInfo.new(name)).tap do |info|
        info.version = version if version
        info.opts = opts
      end
    end

    def write
      File.open('Gemfile', 'a') do |file|
        file.puts
        grouped_gem_names.sort.each do |group, gem_names|
          indent = ""
          unless group.empty?
            file.puts "group :#{group.join(', :')} do" unless group.empty?
            indent="  "
          end
          gem_names.sort.each do |gem_name|
            file.puts "#{indent}gem #{@geminfo[gem_name].gem_args_string}"
          end
          file.puts "end" unless group.empty?
          file.puts
        end
      end
    end

    private
    #returns {group=>[...gem names...]}, ie {[:development, :test]=>['rspec-rails', 'mocha'], :assets=>[], ...}
    def grouped_gem_names
      {}.tap do |_groups|
        @geminfo.each do |gem_name, geminfo|
          (_groups[geminfo.group_key] ||= []).push(gem_name)
        end
      end
    end
  end
end
def add_gem(*all) Gemfile.add(*all); end

@recipes = ["roachking"]
@prefs = {}
@gems = []
@diagnostics_recipes = [["example"], ["setup"], ["railsapps"], ["gems", "setup"], ["gems", "readme", "setup"], ["extras", "gems", "readme", "setup"], ["example", "git"], ["git", "setup"], ["git", "railsapps"], ["gems", "git", "setup"], ["gems", "git", "readme", "setup"], ["extras", "gems", "git", "readme", "setup"], ["controllers", "email", "extras", "frontend", "gems", "git", "init", "models", "railsapps", "readme", "routes", "setup", "testing", "views"], ["controllers", "core", "email", "extras", "frontend", "gems", "git", "init", "models", "railsapps", "readme", "routes", "setup", "testing", "views"], ["controllers", "core", "email", "extras", "frontend", "gems", "git", "init", "models", "prelaunch", "railsapps", "readme", "routes", "setup", "testing", "views"], ["controllers", "core", "email", "extras", "frontend", "gems", "git", "init", "models", "prelaunch", "railsapps", "readme", "routes", "saas", "setup", "testing", "views"], ["controllers", "email", "example", "extras", "frontend", "gems", "git", "init", "models", "railsapps", "readme", "routes", "setup", "testing", "views"], ["controllers", "email", "example", "extras", "frontend", "gems", "git", "init", "models", "prelaunch", "railsapps", "readme", "routes", "setup", "testing", "views"], ["controllers", "email", "example", "extras", "frontend", "gems", "git", "init", "models", "prelaunch", "railsapps", "readme", "routes", "saas", "setup", "testing", "views"], ["apps4", "controllers", "core", "email", "extras", "frontend", "gems", "git", "init", "models", "prelaunch", "railsapps", "readme", "routes", "saas", "setup", "testing", "views"]]
@diagnostics_prefs = [{:railsapps=>"rails-recurly-subscription-saas", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"gmail", :authentication=>"devise", :devise_modules=>"default", :authorization=>"cancan", :starter_app=>"admin_app", :form_builder=>"simple_form"}, {:railsapps=>"rails-stripe-membership-saas", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"gmail", :authentication=>"devise", :devise_modules=>"default", :authorization=>"cancan", :starter_app=>"admin_app", :form_builder=>"simple_form"}, {:railsapps=>"rails-stripe-membership-saas", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"mandrill", :authentication=>"devise", :devise_modules=>"confirmable", :authorization=>"cancan", :starter_app=>"admin_app", :form_builder=>"simple_form"}, {:railsapps=>"rails-prelaunch-signup", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"mandrill", :authentication=>"devise", :devise_modules=>"confirmable", :authorization=>"cancan", :starter_app=>"admin_app", :form_builder=>"simple_form"}, {:railsapps=>"rails3-bootstrap-devise-cancan", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"gmail", :authentication=>"devise", :devise_modules=>"default", :authorization=>"cancan", :starter_app=>"admin_app", :form_builder=>"simple_form"}, {:railsapps=>"rails3-bootstrap-devise-cancan", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"gmail", :authentication=>"devise", :devise_modules=>"default", :authorization=>"cancan", :starter_app=>"admin_app", :form_builder=>"simple_form", :local_env_file=>true, :continuous_testing=>"none"}, {:railsapps=>"rails3-devise-rspec-cucumber", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"none", :email=>"gmail", :authentication=>"devise", :devise_modules=>"default", :authorization=>"none", :starter_app=>"users_app", :form_builder=>"none"}, {:railsapps=>"rails3-mongoid-devise", :database=>"mongodb", :orm=>"mongoid", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"none", :email=>"gmail", :authentication=>"devise", :devise_modules=>"default", :authorization=>"none", :starter_app=>"users_app", :form_builder=>"none"}, {:railsapps=>"rails3-mongoid-omniauth", :database=>"mongodb", :orm=>"mongoid", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"none", :email=>"none", :authentication=>"omniauth", :omniauth_provider=>"twitter", :authorization=>"none", :starter_app=>"users_app", :form_builder=>"none"}, {:railsapps=>"rails3-subdomains", :database=>"mongodb", :orm=>"mongoid", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"none", :email=>"gmail", :authentication=>"devise", :devise_modules=>"default", :authorization=>"none", :starter_app=>"subdomains_app", :form_builder=>"none"}, {:railsapps=>"none", :database=>"sqlite", :unit_test=>"rspec", :integration=>"rspec-capybara", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"none", :authentication=>"omniauth", :omniauth_provider=>"twitter", :authorization=>"cancan", :form_builder=>"none", :starter_app=>"admin_app"}, {:railsapps=>"none", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"none", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"gmail", :authentication=>"devise", :devise_modules=>"invitable", :authorization=>"cancan", :form_builder=>"simple_form", :starter_app=>"admin_app"}, {:railsapps=>"none", :database=>"sqlite", :unit_test=>"rspec", :integration=>"cucumber", :fixtures=>"factory_girl", :frontend=>"bootstrap", :bootstrap=>"sass", :email=>"gmail", :authentication=>"devise", :devise_modules=>"default", :authorization=>"cancan", :form_builder=>"none", :starter_app=>"admin_app"}, {:railsapps=>"none", :database=>"sqlite", :unit_test=>"test_unit", :integration=>"none", :fixtures=>"none", :frontend=>"bootstrap", :bootstrap=>"less", :email=>"sendgrid", :authentication=>"devise", :devise_modules=>"confirmable", :authorization=>"cancan", :form_builder=>"none", :starter_app=>"admin_app"}]
diagnostics = {}

# >-------------------------- templates/helpers.erb --------------------------start<
def recipes; @recipes end
def recipe?(name); @recipes.include?(name) end
def prefs; @prefs end
def prefer(key, value); @prefs[key].eql? value end
def gems; @gems end
def diagnostics_recipes; @diagnostics_recipes end
def diagnostics_prefs; @diagnostics_prefs end

def say_custom(tag, text); say "\033[1m\033[36m" + tag.to_s.rjust(10) + "\033[0m" + "  #{text}" end
def say_recipe(name); say "\033[1m\033[36m" + "recipe".rjust(10) + "\033[0m" + "  Running #{name} recipe..." end
def say_wizard(text); say_custom(@current_recipe || 'composer', text) end

def rails_4?
  Rails::VERSION::MAJOR.to_s == "4"
end

def ask_wizard(question)
  ask "\033[1m\033[36m" + (@current_recipe || "prompt").rjust(10) + "\033[1m\033[36m" + "  #{question}\033[0m"
end

def yes_wizard?(question)
  answer = ask_wizard(question + " \033[33m(y/n)\033[0m")
  case answer.downcase
    when "yes", "y"
      true
    when "no", "n"
      false
    else
      yes_wizard?(question)
  end
end

def no_wizard?(question); !yes_wizard?(question) end

def multiple_choice(question, choices)
  say_custom('question', question)
  values = {}
  choices.each_with_index do |choice,i|
    values[(i + 1).to_s] = choice[1]
    say_custom( (i + 1).to_s + ')', choice[0] )
  end
  answer = ask_wizard("Enter your selection:") while !values.keys.include?(answer)
  values[answer]
end

@current_recipe = nil
@configs = {}

@after_blocks = []
def after_bundler(&block); @after_blocks << [@current_recipe, block]; end
@after_everything_blocks = []
def after_everything(&block); @after_everything_blocks << [@current_recipe, block]; end
@before_configs = {}
def before_config(&block); @before_configs[@current_recipe] = block; end

def copy_from(source, destination)
  begin
    remove_file destination
    get source, destination
  rescue OpenURI::HTTPError
    say_wizard "Unable to obtain #{source}"
  end
end

def copy_from_repo(filename, opts = {})
  repo = 'https://raw.github.com/RailsApps/rails-composer/master/files/'
  repo = opts[:repo] unless opts[:repo].nil?
  if (!opts[:prefs].nil?) && (!prefs.has_value? opts[:prefs])
    return
  end
  source_filename = filename
  destination_filename = filename
  unless opts[:prefs].nil?
    if filename.include? opts[:prefs]
      destination_filename = filename.gsub(/\-#{opts[:prefs]}/, '')
    end
  end
  if (prefer :templates, 'haml') && (filename.include? 'views')
    remove_file destination_filename
    destination_filename = destination_filename.gsub(/.erb/, '.haml')
  end
  if (prefer :templates, 'slim') && (filename.include? 'views')
    remove_file destination_filename
    destination_filename = destination_filename.gsub(/.erb/, '.slim')
  end
  begin
    remove_file destination_filename
    if (prefer :templates, 'haml') && (filename.include? 'views')
      create_file destination_filename, html_to_haml(repo + source_filename)
    elsif (prefer :templates, 'slim') && (filename.include? 'views')
      create_file destination_filename, html_to_slim(repo + source_filename)
    else
      get repo + source_filename, destination_filename
    end
  rescue OpenURI::HTTPError
    say_wizard "Unable to obtain #{source_filename} from the repo #{repo}"
  end
end

def html_to_haml(source)
  begin
    html = open(source) {|input| input.binmode.read }
    Haml::HTML.new(html, :erb => true, :xhtml => true).render
  rescue RubyParser::SyntaxError
    say_wizard "Ignoring RubyParser::SyntaxError"
    # special case to accommodate https://github.com/RailsApps/rails-composer/issues/55
    html = open(source) {|input| input.binmode.read }
    say_wizard "applying patch" if html.include? 'card_month'
    say_wizard "applying patch" if html.include? 'card_year'
    html = html.gsub(/, {add_month_numbers: true}, {name: nil, id: "card_month"}/, '')
    html = html.gsub(/, {start_year: Date\.today\.year, end_year: Date\.today\.year\+10}, {name: nil, id: "card_year"}/, '')
    result = Haml::HTML.new(html, :erb => true, :xhtml => true).render
    result = result.gsub(/select_month nil/, "select_month nil, {add_month_numbers: true}, {name: nil, id: \"card_month\"}")
    result = result.gsub(/select_year nil/, "select_year nil, {start_year: Date.today.year, end_year: Date.today.year+10}, {name: nil, id: \"card_year\"}")
  end
end

def html_to_slim(source)
  html = open(source) {|input| input.binmode.read }
  haml = Haml::HTML.new(html, :erb => true, :xhtml => true).render
  Haml2Slim.convert!(haml)
end

# full credit to @mislav in this StackOverflow answer for the #which() method:
# - http://stackoverflow.com/a/5471032
def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each do |ext|
    exe = "#{path}#{File::SEPARATOR}#{cmd}#{ext}"
      return exe if File.executable? exe
    end
  end
  return nil
end
# >-------------------------- templates/helpers.erb --------------------------end<

if diagnostics_recipes.sort.include? recipes.sort
  diagnostics[:recipes] = 'success'
  say_wizard("WOOT! The recipes you've selected are known to work together.")
else
  diagnostics[:recipes] = 'fail'
  say_wizard("\033[1m\033[36m" + "WARNING! The recipes you've selected might not work together." + "\033[0m")
  say_wizard("Help us out by reporting whether this combination works or fails.")
  say_wizard("Please open an issue for rails_apps_composer on GitHub.")
  say_wizard("Your new application will contain diagnostics in its README file.")
  say_wizard("Continuing...")
end

# this application template only supports Rails version 3.1 and newer
case Rails::VERSION::MAJOR.to_s
when "3"
  case Rails::VERSION::MINOR.to_s
  when "0"
    say_wizard "You are using Rails version #{Rails::VERSION::STRING} which is not supported. Try 3.1 or newer."
    raise StandardError.new "Rails #{Rails::VERSION::STRING} is not supported. Try 3.1 or newer."
  end
when "4"
  say_wizard "You are using Rails version #{Rails::VERSION::STRING}."
else
  say_wizard "You are using Rails version #{Rails::VERSION::STRING} which is not supported. Try 3.1 or newer."
  raise StandardError.new "Rails #{Rails::VERSION::STRING} is not supported. Try 3.1 or newer."
end

say_wizard "Using rails_apps_composer recipes to generate an application."

# >---------------------------[ Autoload Modules/Classes ]-----------------------------<

inject_into_file 'config/application.rb', :after => 'config.autoload_paths += %W(#{config.root}/extras)' do <<-'RUBY'

    config.autoload_paths += %W(#{config.root}/lib)
RUBY
end

# >---------------------------------[ Recipes ]----------------------------------<

# >-------------------------- templates/recipe.erb ---------------------------start<
# >-------------------------------[ roachking ]-------------------------------<
@current_recipe = "roachking"
@before_configs["roachking"].call if @before_configs["roachking"]
say_recipe 'roachking'
@configs[@current_recipe] = config
# >-------------------------- recipes/roachking.rb ---------------------------start<

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


  # Install devise
  generate "devise:install"
  generate "devise User"
  generate "devise:views"

  # Layout
  generate "layout:install bootstrap3 --force"
  generate "layout:navigation --force"
  generate "layout:devise bootstrap3 --force"

  copy_from_repo 'app/views/layouts/application.html.erb', :repo => repo
  copy_from_repo 'app/assets/javascripts/application.js', :repo => repo
  copy_from_repo 'app/assets/stylesheets/application.css.scss', :repo => repo
  copy_from_repo 'app/views/common/_google_analytics.html.erb', :repo => repo

  copy_from_repo 'app/controllers/application_controller.rb', :repo => repo
  copy_from_repo 'app/controllers/home_controller.rb', :repo => repo
  copy_from_repo 'app/views/home/index.html.erb', :repo => repo


  # Routing
  copy_from_repo 'config/routes.rb', :repo => repo
  # CORRECT APPLICATION NAME
  gsub_file 'config/routes.rb', /^.*.routes.draw do/, "#{app_const}.routes.draw do"


  # Settings
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
# >-------------------------- recipes/roachking.rb ---------------------------end<
# >-------------------------- templates/recipe.erb ---------------------------end<


# >-----------------------------[ Final Gemfile Write ]------------------------------<
Gemfile.write

# >---------------------------------[ Diagnostics ]----------------------------------<

# remove prefs which are diagnostically irrelevant
redacted_prefs = prefs.clone
redacted_prefs.delete(:ban_spiders)
redacted_prefs.delete(:better_errors)
redacted_prefs.delete(:dev_webserver)
redacted_prefs.delete(:git)
redacted_prefs.delete(:github)
redacted_prefs.delete(:jsruntime)
redacted_prefs.delete(:local_env_file)
redacted_prefs.delete(:main_branch)
redacted_prefs.delete(:prelaunch_branch)
redacted_prefs.delete(:prod_webserver)
redacted_prefs.delete(:quiet_assets)
redacted_prefs.delete(:rvmrc)
redacted_prefs.delete(:templates)

if diagnostics_prefs.include? redacted_prefs
  diagnostics[:prefs] = 'success'
else
  diagnostics[:prefs] = 'fail'
end

@current_recipe = nil

# >-----------------------------[ Run 'Bundle Install' ]-------------------------------<

say_wizard "Installing gems. This will take a while."
run 'bundle install --without production'
say_wizard "Updating gem paths."
Gem.clear_paths
# >-----------------------------[ Run 'After Bundler' Callbacks ]-------------------------------<

say_wizard "Running 'after bundler' callbacks."
if prefer :templates, 'haml'
  say_wizard "importing html2haml conversion tool"
  require 'html2haml'
end
if prefer :templates, 'slim'
say_wizard "importing html2haml and haml2slim conversion tools"
  require 'html2haml'
  require 'haml2slim'
end
@after_blocks.each{|b| config = @configs[b[0]] || {}; @current_recipe = b[0]; puts @current_recipe; b[1].call}

# >-----------------------------[ Run 'After Everything' Callbacks ]-------------------------------<

@current_recipe = nil
say_wizard "Running 'after everything' callbacks."
@after_everything_blocks.each{|b| config = @configs[b[0]] || {}; @current_recipe = b[0]; puts @current_recipe; b[1].call}

@current_recipe = nil
if diagnostics[:recipes] == 'success'
  say_wizard("WOOT! The recipes you've selected are known to work together.")
  say_wizard("If they don't, open an issue for rails_apps_composer on GitHub.")
else
  say_wizard("\033[1m\033[36m" + "WARNING! The recipes you've selected might not work together." + "\033[0m")
  say_wizard("Help us out by reporting whether this combination works or fails.")
  say_wizard("Please open an issue for rails_apps_composer on GitHub.")
  say_wizard("Your new application will contain diagnostics in its README file.")
end
if diagnostics[:prefs] == 'success'
  say_wizard("WOOT! The preferences you've selected are known to work together.")
  say_wizard("If they don't, open an issue for rails_apps_composer on GitHub.")
else
  say_wizard("\033[1m\033[36m" + "WARNING! The preferences you've selected might not work together." + "\033[0m")
  say_wizard("Help us out by reporting whether this combination works or fails.")
  say_wizard("Please open an issue for rails_apps_composer on GitHub.")
  say_wizard("Your new application will contain diagnostics in its README file.")
end
say_wizard "Finished running the rails_apps_composer app template."
say_wizard "Your new Rails app is ready. Time to run 'bundle install'."
