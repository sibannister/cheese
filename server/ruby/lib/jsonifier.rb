class Array
  def to_json
    items_json = map {|item| item.to_json}
    '[' + items_json.join(',') + ']'
  end
end
