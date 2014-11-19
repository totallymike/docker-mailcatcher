FROM ruby:2.1.5

ENV MAILCATCHER_ENV production

RUN git clone --depth 1 -b with_assets \
    https://github.com/Paxa/mailcatcher.git /mailcatcher 

WORKDIR /mailcatcher

RUN bundle install --deployment && \
    gem build ./mailcatcher.gemspec && \
    gem install ./mailcatcher-0.6.0.gem

WORKDIR /

RUN rm -rf /mailcatcher

EXPOSE 1025 1080

CMD ["mailcatcher", "--smtp-ip=0.0.0.0", "--http-ip=0.0.0.0", "--foreground"]
