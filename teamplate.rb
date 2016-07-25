# generate(:scaffold, "person name:string")
# route "root to: 'people#index'"
# rake("db:migrate")

# Install Devise
gem "devise"
generate "devise:install"
generate "devise", "User"
environment 'config.action_mailer.default_url_options = {host: "localhost", port: 3000}', env: 'development'

# Pundit
gem "pundit"
generate "pundit:install"

# Bootstrap
gem "twitter-bootstrap-rails"
gem "bootstrap_form"
generate "bootstrap:install", "static"
generate "bootstrap:layout" # auto overwrite

# Other gems
%w( pg ).each { |name| gem name }

gem_group :development, :test do
  %w( pry-rails better_errors binding_of_caller ).each do |name|
    gem name
  end
end

if yes?("Do you want HTTParty?")
  gem "httparty"
end

# Set up database
rake "db:create"
rake "db:migrate"

# Initialize the Git repo
after_bundle do
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
