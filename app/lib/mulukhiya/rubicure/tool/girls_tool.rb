module Mulukhiya
  module Rubicure
    class GirlsTool < Tool
      def exec(args)
        return all unless args[1]
        return ical if args[1].underscore == 'calendar'
        return girl(args[1])
      end

      def all
        return Precure.all.map(&:to_h)
      end

      def ical
        ical = Icalendar::Calendar.new
        ical.append_custom_property('X-WR-CALNAME;VALUE=TEXT', 'プリキュアの誕生日')
        GirlsBirthdayCalendar.new(years: 2).events.each do |date, girls|
          girls.each do |girl|
            ical.event do |e|
              e.summary = "#{girl.human_name}（#{girl.precure_name}）の誕生日"
              e.dtstart = Icalendar::Values::Date.new(date)
            end
          end
        end
        ical.publish
        return ical.to_ical
      end

      def girl(name)
        [name, "cure_#{name.sub(/^cure_/, '')}"].map(&:to_sym).each do |sym|
          next unless girl = ::Rubicure::Girl.find(sym)
          return girl.to_h
        rescue NameError
          # nop
        end
      end
    end
  end
end
