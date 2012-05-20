Gem::Specification.new do |s|
    s.name        = 'movie_robot'
    s.version     = '0.0.1'
    s.date        = '2012-05-20'
    s.summary     = "Movie robot server"
    s.description = "The server for an app which searches the tv schedules for decent films"
    s.authors     = ["Spencer Ward"]
    s.email       = 'spencerkward@gmail.com'
    s.files       = Dir.glob("lib/**/**")
    s.homepage    = 'https://sites.google.com/site/winecheeseandgrapes/home'
    s.add_runtime_dependency 'imdb'
    s.add_runtime_dependency 'savon'
end

