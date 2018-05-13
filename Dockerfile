FROM ubuntu
RUN mkdir /cvv
COPY . ./cvv
WORKDIR /cvv
EXPOSE 80
RUN apt-get update && apt-get install -y software-properties-common \
                                         curl \
                                         ffmpeg imagemagick libmagickwand-dev
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN chmod +x bash/ruby_install.sh
RUN bash/ruby_install.sh
CMD bundle exec puma -C config/puma.rb