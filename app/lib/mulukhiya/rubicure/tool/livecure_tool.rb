module Mulukhiya
  module Rubicure
    class LivecureTool < Tool
      def exec(args = {})
        case args[1]&.underscore
        when nil
          return LivecureCalendar.new.events
        when 'json'
          return LivecureCalendar.new.events
        when 'calendar'
          @type = 'text/calendar; charset=UTF-8'
          return ical
        end
      end

      def ical
        ical = Icalendar::Calendar.new
        ical.append_custom_property('X-WR-CALNAME;VALUE=TEXT', '実況日程')
        LivecureCalendar.new.events.each do |date, girls|
          girls.each do |girl|
            ical.event do |e|
              case girl[:type]
              when 'cast'
                e.summary = "#{girl.cast_name}（#{girl.precure_name}役）の誕生日"
              when 'precure'
                e.summary = "#{girl.human_name}（#{girl.precure_name}）の誕生日"
              end
              e.dtstart = Icalendar::Values::Date.new(date)
            end
          end
        end
        ical.publish
        return ical.to_ical
      end

      def help
        return [
          'bin/cure.rb livecure - 直近の実況日程 (JSON)',
          'bin/cure.rb livecure json - 直近の実況日程 (JSON)',
          'bin/cure.rb livecure calendar - 直近の実況日程 (iCalendar)',
        ]
      end
    end
  end
end
