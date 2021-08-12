module Mulukhiya
  module Rubicure
    class GirlsTool < Tool
      def exec(args = {})
        case args[1]&.underscore
        when nil
          return all
        when 'index'
          return index
        when 'calendar'
          @type = 'text/calendar; charset=UTF-8'
          return ical
        else
          return girl(args[1])
        end
      end

      def all
        return Precure.all.map(&:to_h)
      end

      def index
        return Precure.all.map(&:girl_name)
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

      def help
        return [
          'bin/cure.rb girls - すべてのプリキュア (JSON)',
          'bin/cure.rb girls index - すべてのプリキュアの名前 (JSON)',
          'bin/cure.rb girls :name - 指定したプリキュア (JSON)',
          '  ex) bin/cure.rb girls black # キュアブラックを表示',
          'bin/cure.rb girls calendar - プリキュアの誕生日カレンダー (iCalendar)',
        ]
      end
    end
  end
end
