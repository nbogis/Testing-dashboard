module TimeModule
  # get number of second from a Time object
  def self.convert_to_seconds(time)
    return time.hour*3600 + time.min * 60 + time.sec
  end

  # get time from seconds
  def self.convert_to_time(seconds)
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

  # get the time from Time object (2016-11-22 21:16:56)
  # this method return "21:16:56"
  def self.get_time(time)
    return time.strftime("%H:%M:%S")
  end
end
