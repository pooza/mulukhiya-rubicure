require 'rubicure'

module Mulukhiya
  module Rubicure
    class Tool
      include Package

      def exec(args)
        raise Ginseng::ImplementError, "'#{__method__}' not implemented"
      end

      def self.create(name)
        return "Mulukhiya::Rubicure::#{name.camelize}Tool".constantize.new
      end

      private

      def initialize
      end
    end
  end
end
