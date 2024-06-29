# Use the official Ruby image from Docker Hub
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y curl gnupg build-essential libpq-dev

# Install Node.js and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

# Set the working directory
WORKDIR /myapp

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem update --system 3.3.22 && bundle install

# Copy the main application
COPY . .

# Copy master key for Rails credentials
COPY config/master.key /myapp/config/master.key

# Install JavaScript dependencies
RUN yarn install

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Set the command to run the application
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
