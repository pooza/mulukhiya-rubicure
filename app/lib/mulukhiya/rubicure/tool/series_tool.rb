module Mulukhiya
  module Rubicure
    class SeriesTool < Tool
      def exec(args)
        return all unless args[1]
        return series(args[1])
      end

      def all
        return Precure.map(&:to_h)
      end

      def series(name)
        return ::Rubicure::Series.find(name.to_sym).to_h
      end
    end
  end
end
