module Mulukhiya
  module Rubicure
    class GirlsTool < Tool
      def exec(args)
        return all unless args[1]
        return girl(args[1])
      end

      def all
        return Precure.all.map(&:to_h)
      end

      def girl(name)
        name = "cure_#{name.sub(/^cure_/, '')}"
        return ::Rubicure::Girl.find(name.to_sym).to_h
      end
    end
  end
end
