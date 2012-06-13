echo "CHECK FOR OLD PROCESSES (kill using kill -9 process_id)"
lsof -i tcp:1234
read -p "Are you happy to continue?"

echo STARTING UP SERVER...
cd server/ruby
ruby -Ilib lib/server.rb 1234 &

echo INITIALISING THE SERVER...
sleep 3
wget "http://localhost:1234/cache?days=1"

