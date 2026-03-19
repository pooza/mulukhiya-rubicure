module CureAPI
  class CastBirthdayCalendar < Calendar
    def events
      entries = {}
      Datasource.instance.girls.select(&:cast_birthday?).each do |girl|
        (today.year..(today.year + years)).each do |year|
          date = Date.parse("#{year}/#{girl.cast_birthday}")
          next unless include?(date)
          entries[date] ||= []
          entries[date].push(girl)
        end
      end
      return entries.sort.to_h
    end
  end
end
