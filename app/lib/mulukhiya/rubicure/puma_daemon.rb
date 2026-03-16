module Mulukhiya
  module Rubicure
    class PumaDaemon < Ginseng::Daemon
      include Package

      def command
        return Ginseng::CommandLine.new([
          'puma',
          File.join(Environment.dir, 'config.ru'),
          '--port', config['/puma/port'].to_s,
          '--environment', Environment.type
        ])
      end

      def self.disable?
        return false
      end
    end
  end
end
