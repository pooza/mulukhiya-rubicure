module Mulukhiya
  module Rubicure
    class CastTool < Tool
      def exec(args = {})
        case args[1]&.underscore
        when 'calendar'
          @type = 'text/calendar; charset=UTF-8'
          return ical
        end
      end

      def ical
        ical = Icalendar::Calendar.new
        ical.append_custom_property('X-WR-CALNAME;VALUE=TEXT', 'キャストの誕生日')
        CastBirthdayCalendar.new(years: 2).events.each do |date, girls|
          girls.each do |girl|
            ical.event do |e|
              e.summary = "#{girl.cast_name}（#{girl.precure_name}役）の誕生日"
              e.dtstart = Icalendar::Values::Date.new(date)
            end
          end
        end
        ical.publish
        return ical.to_ical
      end
    end
  end
end
