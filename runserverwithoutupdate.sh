echo STARTING UP SERVER...
cd server/ruby
ruby -Ilib lib/server.rb 1234 &

echo INITIALISING THE SERVER...
sleep 3
curl http://localhost:1234/init

