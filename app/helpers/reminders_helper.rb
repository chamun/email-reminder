module RemindersHelper
  def time_options
    %w(AM PM).collect do |period|
      (1..11).collect do |hour|
        "#{sprintf '%02d', hour}:00 #{period}"
      end.unshift("12:00 #{period}")
    end.flatten
  end
end
