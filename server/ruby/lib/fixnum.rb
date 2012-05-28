class Fixnum
  def days
    hours * 24
  end

  def hours
    minutes * 60
  end
  
  def minutes
    self * 60
  end
end
