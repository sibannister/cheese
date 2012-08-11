class RemotePersister
  @@key = "json"

  def initialize
    #@dalli_cache = Dalli::Client.new 'mc5.ec2.northscale.net:11211', :username => 'app5077305%40heroku.com', :password => 'YvePBrvyZp3pPLs0'
    @dalli_cache = Dalli::Client.new 'localhost:11211'
  end

  def reset
    @dalli_cache.delete @@key
  end

  def save data
    @dalli_cache.set @@key, data
  end

  def retrieve
    @dalli_cache.get @@key
  end
end
