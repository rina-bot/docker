FROM ruby:2.7.2

ENV RAILS_ENV=production

# install dependencies
RUN apt-get update
RUN apt-get install -yq  beanstalkd npm postgresql-client

RUN npm install -g yarn

COPY rina /app
WORKDIR /app
RUN bundle install

# let rails generate credentials
# XXX: this generates a fixed secrect_key_base in the image,
#      need more work to re-generate on first start
RUN EDITOR=/bin/true bin/rails credentials:edit

RUN bin/rails assets:precompile
COPY entrypoint.sh .

ENTRYPOINT ./entrypoint.sh
