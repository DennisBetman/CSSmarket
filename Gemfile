source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.2"
gem "pg"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"

gem "bcrypt", :require => "bcrypt"

gem "high_voltage", "~> 3.0.0"

gem "elasticsearch-model"
gem "elasticsearch-rails"

gem "brainblocks-js"
gem "stripe"

gem "carrierwave"

gem "redcarpet"

gem "wdm", "~> 0.1.0" if Gem.win_platform?

gem "scss_lint", require: false

group :development, :test do
  gem "byebug", platform: :mri
  gem "sqlite3"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  gem "foreman"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
