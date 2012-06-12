require 'timeout'

class UnreliableObjectDelegate
  def initialize target, timeout_in_seconds, max_attempts
    @target = target
    @timeout_in_seconds = timeout_in_seconds
    @max_attempts = max_attempts
  end

  def method_missing method, *args, &block
    puts "Calling method " + method.to_s + " at " + Time.now.to_s
    (@max_attempts - 1).times do
      begin
        return try_call method, *args, &block
      rescue
        puts "WARNING - call to " + method.to_s + " timed out after " + @timeout_in_seconds.to_s +
          "s.  Attempting another call..."
      end
    end
    
    puts "SEVERE WARNING - There have now been " + @max_attempts.to_s + " timeouts on calls to " +
      method.to_s + ".  Making final attempt..."

    return try_call method, *args, &block
  end

  def try_call method, *args, &block
    Timeout::timeout(@timeout_in_seconds) do
      result = @target.send method, *args, &block
      puts "Unreliable method " + method.to_s + " succeeded.  Result is " + result.to_s.ljust(40)
      result
    end
  end
end
