echo UPDATING RUBY...
sudo apt-get install ruby1.9
sudo apt-get install memcached

echo UPDATING GEMS...
sudo gem install server/ruby/movie_robot
sudo gem uninstall movie_robot

./runserverwithoutupdate.sh
