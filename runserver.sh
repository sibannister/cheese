echo UPDATING SERVER...
sudo gem install server/ruby/movie_robot
sudo gem uninstall movie_robot

echo STARTING UP SERVER...
cd server/ruby
ruby -Ilib lib/server.rb

echo STOPPING SERVER...
