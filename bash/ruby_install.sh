#!/usr/bin/env bash

source /etc/profile.d/rvm.sh
echo 'source /etc/profile.d/rvm.sh' >> ~/.bashrc
rvm install ruby-2.4.3
rvm use ruby-2.4.3 --default
gem install bundler
bundler install