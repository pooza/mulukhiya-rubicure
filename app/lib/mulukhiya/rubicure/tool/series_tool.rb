module Mulukhiya
  module Rubicure
    class SeriesTool < Tool
      def exec(args = {})
        case args[1]&.underscore
        when nil
          return all
        when 'index'
          return index
        else
          return series(args[1])
        end
      end

      def index
        return Precure.map(&:series_name)
      end

      def all
        return Precure.map(&:to_h)
      end

      def series(name)
        return ::Rubicure::Series.find(name.to_sym).to_h
      end

      def help
        return [
          'bin/cure.rb series - すべてのシリーズ (JSON)',
          'bin/cure.rb series index - すべてのシリーズの名前 (JSON)',
          'bin/cure.rb series :name - 指定したシリーズ (JSON)',
          '  ex) bin/cure.rb series unmarked # ふたりはプリキュアを表示',
        ]
      end
    end
  end
end
