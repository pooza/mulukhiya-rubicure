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
        return datasource.series.map {|s| s[:key]}
      end

      def all
        return datasource.series
      end

      def series(name)
        s = datasource.find_series(name)
        raise Ginseng::NotFoundError, "series '#{name}' not found" unless s
        return s
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
