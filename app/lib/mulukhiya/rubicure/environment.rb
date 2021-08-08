module Mulukhiya
  module Rubicure
    class Environment < Ginseng::Environment
      def self.name
        return File.basename(dir)
      end

      def self.dir
        return Mulukhiya::Rubicure.dir
      end
    end
  end
end
