FROM ruby:2.6.5

# add nodejs and yarn
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Add Libs
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  nodejs yarn build-essential libpq-dev imagemagick git-all nano

# Add gem Bundler
RUN gem install bundler

# Set Path
ENV INSTALL_PATH /onebitexchange

# Create directory
RUN mkdir -p $INSTALL_PATH

# Set Directory for main PATH
WORKDIR $INSTALL_PATH

# Copy gemfile for inside the container
COPY Gemfile ./

# Set path for Gems
ENV BUNDLE_PATH /gems

# Copy code for inside the container
COPY . .