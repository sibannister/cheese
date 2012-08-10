require 'json'

class Array
  def to_json
    items_json = map {|item| item.to_json}
    '[' + items_json.join(',') + ']'
  end
end

class Jsonifiable
  def to_json
    to_hash.to_json.to_s
  end

  def to_s
    to_json
  end
end

