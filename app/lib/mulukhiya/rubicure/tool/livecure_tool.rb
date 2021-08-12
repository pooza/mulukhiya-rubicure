module Mulukhiya
  module Rubicure
    class LivecureTool < Tool
      def exec(args = {})
        events = {}
        GirlsBirthdayCalendar.new(all: false).events.each do |date, girls|
          events[date] = girls.map {|g| g.merge(type: 'precure')}
        end
        CastBirthdayCalendar.new(all: false).events.each do |date, girls|
          girls.reject(&:have_birthday?).each do |girl|
            events[date] ||= []
            events[date].push(girl.merge(type: 'cast'))
          end
        end
        return events.sort.to_h
      end

      def help
        return ['bin/cure.rb livecure - 直近の実況日程 (JSON)']
      end
    end
  end
end
