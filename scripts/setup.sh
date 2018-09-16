bundle install

# setup for paters
mysql -h mysql -e 'create database scraping_sample;'
bundle exec rake db:migrate
