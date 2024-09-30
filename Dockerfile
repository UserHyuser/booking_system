FROM ruby:3.2.2

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    build-essential libpq-dev cmake pkg-config libgit2-dev libssl-dev git lsb-release gnupg2 wget nodejs redis-tools \
    libjemalloc2 && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    apt update && \
    apt install -y postgresql-client-16 && apt-get install -y vim

WORKDIR /booking_system

COPY Gemfile* ./

RUN gem install bundler -v 2.4.19
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
