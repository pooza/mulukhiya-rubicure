require 'rubicure'

module Mulukhiya
  module Rubicure
    class Tool
      include Package
      attr_reader :type

      def exec(args = {})
        raise Ginseng::ImplementError, "'#{__method__}' not implemented"
      end

      def body(args = {})
        result = exec(args)
        contents = ["Content-Type: #{type}", '']
        if result.is_a?(String)
          contents.push(result)
        else
          contents.push(JSON.pretty_generate(result))
        end
        return contents.join("\n")
      end

      def help
        return "-- #{self.class} のヘルプは未定義 --"
      end

      def self.create(name)
        return "Mulukhiya::Rubicure::#{name.camelize}Tool".constantize.new
      end

      def self.all
        return enum_for(__method__) unless block_given?
        config['/tools'].each do |name|
          yield create(name)
        end
      end

      private

      def initialize
        @type = 'application/json; charset=UTF-8'
      end
    end
  end
end
