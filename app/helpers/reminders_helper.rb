module RemindersHelper
  def time_options
    (1..23).collect do |hour|
      [ to_am_pm(hour), hour ]
    end.unshift(['12:00 AM', 0])
  end

  private

  def to_am_pm(hour)
    result = hour % 12
    result = 12 if result == 0
    "#{ sprintf '%02d', result }:00 #{ period(hour) }"
  end

  def period(hour)
    hour < 12 ? 'AM' : 'PM'
  end
end
