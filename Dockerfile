FROM ubuntu:16.04
RUN mkdir /cvv
COPY . ./cvv
WORKDIR /cvv
EXPOSE 80
RUN apt-get update && apt-get install -y ca-certificates \
                                         curl \
                                         software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update && \
    apt-get -y install build-essential \
                            ruby2.4 \
                            ruby2.4-dev \
                            ca-certificates \
                            curl \
                            ffmpeg imagemagick libmagickwand-dev wget
RUN gem install bundler
RUN bundler install
CMD bundle exec puma -C config/puma.rb