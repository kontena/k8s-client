FROM ruby:2.4.3

WORKDIR /app

COPY Gemfile *.gemspec ./
COPY lib/k8s/client/version.rb ./lib/k8s/client/
RUN bundle install

COPY . .

ENTRYPOINT ["bundle", "exec"]
