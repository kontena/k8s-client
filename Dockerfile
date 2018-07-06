FROM ruby:2.4.3

WORKDIR /app

COPY Gemfile *.gemspec ./
COPY lib/pharos/kube/client/version.rb ./lib/pharos/kube/client/
RUN bundle install

COPY . .

ENTRYPOINT ["bundle", "exec"]
