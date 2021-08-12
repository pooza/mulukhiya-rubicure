module Mulukhiya
  module Rubicure
    class LivecureTool < Tool
      def exec(args)
        dates = {}
        girl_birthdays.each do |date, girls|
          dates[date] = girls.map {|g| g.merge(type: 'precure')}
        end
        cast_birthdays.each do |date, girls|
          girls.reject(&:have_birthday?).each do |girl|
            dates[date] ||= []
            dates[date].push(girl.merge(type: 'cast'))
          end
        end
        return dates.sort.to_h
      end

      def today
        return Date.today
      end

      def days
        return 60
      end

      def years
        return 1
      end

      def girl_birthdays
        birthdays = {}
        Precure.all.select(&:have_birthday?).each do |girl|
          (today.year..(today.year + years)).each do |year|
            date = Date.parse("#{year}/#{girl.birthday}")
            next if date < today
            next if today + days < date
            birthdays[date] ||= []
            birthdays[date].push(girl)
          end
        end
        return birthdays.sort.to_h
      end

      def cast_birthdays
        birthdays = {}
        Precure.all.select(&:have_cast_birthday?).each do |girl|
          (today.year..(today.year + years)).each do |year|
            date = Date.parse("#{year}/#{girl.cast_birthday}")
            next if date < today
            next if today + days < date
            birthdays[date] ||= []
            birthdays[date].push(girl)
          end
        end
        return birthdays.sort.to_h
      end
    end
  end
end
