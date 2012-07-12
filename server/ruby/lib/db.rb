require 'pg'

class Database
  def get
    puts "db url is " + ENV['DATABASE_URL'].to_s

    conn = PG.connect("dbname=mikeltcdkp user=mikeltcdkp password=pOE1_m3Nq80BhGWCyG5N host=ec2-23-21-44-44.compute-1.amazonaws.com")
    conn.exec("CREATE TABLE IF NOT EXISTS SHOWING (name varchar(50), channel varchar(20), rating numeric, start timestamp, finish timestamp, image_url varchar(100));")
    conn.exec("INSERT INTO SHOWING(name, channel, rating, start, finish, image_url) VALUES('Birdemic', 'Film4', 2.4, '2012-01-08 04:05:00', '2012-01-08 04:05:00', 'url');")
    conn.flush()
    conn.exec("SELECT * from SHOWING") do |result|
      result.each do |row|
        puts "%s" % row.to_s
      end
    end
  end
end

      #exec "createuser -h localhost -p 5432 -U postgres -S -D -R app3"
      #ßΩexec "createdb -h localhost -p 5432 -U postgres test"
      #exec "psql -h localhost -p 5432 -U postgres -c 'GRANT ALL PRIVILEGES ON DATABASE test to app2;'"


      #puts "DB URL is " + ENV['DATABASE_URL'].to_s

      #conn = PG.connect("dbname=test port=5432 user=app2 host=localhost")
      #conn.exec("DROP TABLE SHOWING;")
      #conn.exec("CREATE TABLE IF NOT EXISTS SHOWING (name varchar(50), channel varchar(20), rating numeric, start timestamp, finish timestamp, image_url varchar(100));")
      #conn.exec("INSERT INTO SHOWING(name, channel, rating, start, finish, image_url) VALUES('Birdemic', 'Film4', 2.4, '2012-01-08 04:05:00', '2012-01-08 04:05:00', 'url');")
      #conn.flush()
      #conn.exec("SELECT * from SHOWING") do |result|
      #result.each do |row|
      #puts "%s" % row.to_s
      #end
      #end
