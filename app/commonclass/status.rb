class Status
  def self.options_for_enum
    { not_started: 0,
      in_progress: 1,
      done: 2,
    }
  end
  def self.options_for_status
    res = []
    self.options_for_enum.each do | key, value |
      res.push([(I18n.t "status.#{key}"), key])
    end
    return res
  end
end
