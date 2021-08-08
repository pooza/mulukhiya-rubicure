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
