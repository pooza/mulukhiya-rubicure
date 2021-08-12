module Mulukhiya
  module Rubicure
    class HelpTool < Tool
      def exec(args = {})
        return Tool.all.map(&:help).flatten.join("\n")
      end

      def help
        return ['bin/cure.rb help - ヘルプ']
      end

      private

      def initialize
        super
        @type = 'text/plain; charset=UTF-8'
      end
    end
  end
end
