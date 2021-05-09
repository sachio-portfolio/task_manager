class Priority
  def self.options_for_priority
    priority_list = []
    self.options_for_enum.each do | key, value |
      priority_list.push([(I18n.t "priority.#{key}"), key])
    end
    return priority_list
  end
  private
  def self.options_for_enum
    { high: 0,
      normal: 1,
      low: 2,
    }
  end
end
