module Mulukhiya
  module Rubicure
    class Datasource
      include Package
      include Singleton

      def girls
        @girls ||= fetch_girls.map {|record| Girl.new(record)}
      end

      def find_girl(name)
        name = name.to_s
        girls.find {|g| g.key == name || g.key == "cure_#{name}"}
      end

      def series
        @series ||= fetch_series
      end

      def find_series(name)
        name = name.to_s
        series.find {|s| s[:key] == name}
      end

      private

      def initialize
        @http = HTTP.new
      end

      def fetch_girls
        url = "#{config['/gas/girls/url']}?action=girls"
        @http.get(url).map {|record| record.transform_keys(&:to_sym)}
      end

      def fetch_series
        url = "#{config['/gas/series/url']}?action=series"
        @http.get(url).map do |record|
          h = record.transform_keys(&:to_sym)
          h[:title] = h.delete(:series) if h.key?(:series)
          h
        end
      end
    end
  end
end
