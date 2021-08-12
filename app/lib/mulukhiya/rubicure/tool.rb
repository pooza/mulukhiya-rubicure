require 'rubicure'

module Mulukhiya
  module Rubicure
    class Tool
      include Package
      attr_reader :type

      def exec(args)
        raise Ginseng::ImplementError, "'#{__method__}' not implemented"
      end

      def body(args)
        contents = ["Content-Type: #{type}", '']
        result = exec(args)
        if result.is_a?(String)
          contents.push(result)
        else
          contents.push(JSON.pretty_generate(result))
        end
        return contents.join("\n")
      end

      def self.create(name)
        return "Mulukhiya::Rubicure::#{name.camelize}Tool".constantize.new
      end

      private

      def initialize
        @type = 'text/calendar; charset=UTF-8'
      end
    end
  end
end
