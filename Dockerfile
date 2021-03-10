FROM ruby:2.7.1
ENV RAILS_ENV "development"
ENV NODE_ENV "development"
RUN apt-get update && apt-get install -y \
  curl \
  git \
  build-essential \
  libpq-dev \
  postgresql-client &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

RUN apt-get update -qq && apt-get install -y curl git libpq-dev postgresql-client nodejs
RUN gem update --system \
  && gem install bundler:2.1.4 --no-document \
  && gem install rails
RUN mkdir /syadem
WORKDIR /syadem
COPY Gemfile /syadem/Gemfile
COPY Gemfile.lock /syadem/Gemfile.lock
RUN bundle install
COPY . /syadem

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]